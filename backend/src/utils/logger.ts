export const logger = {
  info: (message: string, meta?: object) => {
    console.log(message, meta);
  },
  error: (message: string, error?: Error) => {
    console.error(message, error);
  }
}; 