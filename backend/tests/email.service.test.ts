import { EmailService } from '../src/services/email.service';

describe('EmailService', () => {
  let emailService: EmailService;

  beforeEach(() => {
    emailService = new EmailService();
  });

  it('should send an email', async () => {
    const spy = jest.spyOn(console, 'log');
    await emailService.sendEmail('test@example.com', 'Test', 'Hello');
    expect(spy).toHaveBeenCalled();
  });
}); 