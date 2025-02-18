feature 'authentication' do
  it 'a user can sign in' do
    # Create a test user
    Chitter.setup_user(email: 'superhans@chitter.com', password: 'guessme')

    # Then sign in as them
    visit '/sessions'
    fill_in(:email, with: 'superhans@chitter.com')
    fill_in(:password, with: 'guessme')
    click_button('Sign in')

    expect(page).to have_content 'Welcome, superhans@chitter.com'
  end

  scenario 'a user sees an error if they get their email wrong' do
    Chitter.setup_user(email: 'superhans@chitter.com', password: 'guessme')
  
    visit '/sessions'
    fill_in(:email, with: 'nohans@chitter.com')
    fill_in(:password, with: 'guessme')
    click_button('Sign in')
  
    expect(page).not_to have_content 'superhans@chitter.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user sees an error if they get their password wrong' do
    Chitter.setup_user(email: 'superhans@chitter.com', password: 'guessme')

    visit '/sessions'
    fill_in(:email, with: 'superhans@chitter.com')
    fill_in(:password, with: 'emsseug')
    click_button('Sign in')

    expect(page).not_to have_content 'Welcome, superhans@chitter.com'
    expect(page).to have_content 'Please check your email or password.'
  end

  scenario 'a user can sign out' do
    Chitter.setup_user(email: 'superhans@chitter.com', password: 'guessme')

    visit '/sessions'
    fill_in(:email, with: 'superhans@chitter.com')
    fill_in(:password, with: 'guessme')
    click_button('Sign in')

    click_button('Sign out')

    expect(page).not_to have_content 'Welcome, superhans@chitter.com'
    expect(page).to have_content 'You have signed out.'
  end
end
