Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Jan 2005 09:50:30 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:40649 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225229AbVAGJu0>; Fri, 7 Jan 2005 09:50:26 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP id 58F80401C5
	for <linux-mips@linux-mips.org>; Fri,  7 Jan 2005 10:51:07 +0100 (CET)
Message-ID: <41DE5C1C.3090406@enix.org>
Date: Fri, 07 Jan 2005 10:53:32 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040926)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Problem with MV64340 serial driver
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig3D1206668ABA14F79AFB3537"
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig3D1206668ABA14F79AFB3537
Content-Type: multipart/mixed;
 boundary="------------030904090902040005010107"

This is a multi-part message in MIME format.
--------------030904090902040005010107
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

I've implemented a serial driver for the Marvell 64340 chipset. This 
driver works fairly well. It uses SDMA for both input and input. SDMA 
buffers and descriptors are stored in Marvell SRAM.

However, I'm facing a strange problem when copy/pasting a lot of data to 
the terminal which is connected through the serial line to the MIPS box 
: after outputting a random number of the copied characters, the output 
hangs.

The system is not crashed, I can successfully connect through SSH, kill 
the shell that is running on the serial line, and a new shell will start 
on the serial line and will work correctly.

I've traced down the problem, and I saw that when the terminal is 
blocked, in fact reception interrupts are still correctly received. The 
problem comes from TX interrupts that aren't issued anymore.

When the terminal is in the hang state, I've looked at the Marvell 
interrupt mask register and it's correct (i.e both RX and TX interrupts 
enabled). I've also looked at the Command/Status part of the TX 
descriptor (I use only one TX descriptor and TX buffer). And I can see 
that the Owner bit is 0, which means that the buffer is now owned by the 
processor. If I'm correct, it means that the data has been set, and that 
the processor should have received an interrupt telling that the 
transmission is done. However, the processor doesn't receive the interrupt.

Moreover, I've seen that when the terminal is in the hang state, if I 
set the Owner bit of the TX descriptor, then the data are sent again and 
the serial line works again.

Any idea of what could be wrong ? As this occurs only when copy/paste, I 
suspect a strange race condition problem. Marvell has released an errata 
concerning a race condition with TX and SDMA, but 1) the doc states that 
our chip is not affected, 2) the scenario of the doc uses multiple TX 
buffers/descriptors, something we are not doing.

Enclosed you will find the code of the serial driver.

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: thomas.petazzoni@jabber.dk
http://kos.enix.org, http://sos.enix.org
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------030904090902040005010107
Content-Type: text/x-csrc;
 name="mv64340.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="mv64340.c"

/*
 * MV64340 Driver.
 *
 * This driver is based on the Tiny TTY driver by Greg Kroah-Hartman,
 * described in a Linux Journal article :
 * http://www.linuxjournal.com/article.php?sid=6331
 *
 * Copyright (C) 2002 Greg Kroah-Hartman (greg@kroah.com)
 *
 *	This program is free software; you can redistribute it and/or modify
 *	it under the terms of the GNU General Public License as published by
 *	the Free Software Foundation; version 2 of the License.
 */

#include <linux/kernel.h>
#include <linux/errno.h>
#include <linux/init.h>
#include <linux/slab.h>
#include <linux/tty.h>
#include <linux/tty_flip.h>
#include <linux/serial.h>
#include <linux/serial_core.h>
#include <linux/module.h>
#include <asm/mv64340/mv64340_uart.h>
#include <asm/marvell.h>
#include <asm/mach-npp/board.h>
#include <asm/mach-npp/rm9000.h>
#include <linux/mv643xx.h>


#define MV64340_SERIAL_NR         1
#define MV64340_SERIAL_MAJOR      TTY_MAJOR
#define MV64340_SERIAL_MINOR      64
#define MV64340_SERIAL_NAME       "mv64340-serial"

#define MY_NAME MV64340_SERIAL_NAME

#define MV64340_SERIAL_DEBUG

static int nextTx_sdma_buf;
static int nextRx_sdma_buf;
static int Txbuf_ch_cnt;

/* Further defined */
static void mv64340_stop_tx(struct uart_port *port, unsigned int tty_stop);

static int mv64340_debug_status = 0;

/*
 * This function initializes the SDMA TX buffer.
 * Currently, a single SDMA TX buffer is supported, so
 * SDMA_TX_BUFFER_NUM must be one
 *
 */
static void initialize_sdma_tx_buffers(void)
{
#if (SDMA_TX_BUFFER_NUM != 1)
 #error "SDMA_TX_BUFFER_NUM is different from 1 !"
#endif

#ifdef MV64340_SERIAL_DEBUG
  memset((void*) SDMA_UART_TX_BUF_ADDR(0), 'A', SDMA_TX_BUFFER_SIZE);
#endif

  /* First and Last buffer, Enable Interrupt and the buffer is Owned
     by the MV64340, so that it can be processed */
  SDMA_UART_TX_DESC_WRITE(0, CMD_STAT_OFF,
			  (1 << SDMA_DESC_L) |
			  (1 << SDMA_DESC_F) |
			  (1 << SDMA_DESC_EI) |
			  (1 << SDMA_DESC_O));

  /* Initialize sizes. Everything is set to zero, because sizes will
     be properly configured for each transmission by the
     mv64340_commit_tx_buffer() function */
  SDMA_UART_TX_DESC_WRITE(0, BUF_SZ_OFF,
			  (0 << SDMA_DESC_BYTE_COUNT) |
			  (0 << SDMA_DESC_BUFFER_SIZE));

  /* Configure the address of the buffer corresponding to this buffer
     descriptor */
  SDMA_UART_TX_DESC_WRITE(0, BUF_ADDR_OFF,
			  SDMA_UART_TX_BUF_ADDR(0));

  /* No next descriptor */
  SDMA_UART_TX_DESC_WRITE(0, BUF_NEXT_OFF, 0);

  /* Set this buffer descriptor as current TX and first TX */
  MV_WRITE(MV64340_SDMA_CURRENT_TX_DESCRIPTOR_POINTER(1),
	   SDMA_UART_TX_DESC_ADDR(0));
  MV_WRITE(MV64340_SDMA_FIRST_TX_DESCRIPTOR_POINTER(1),
	   SDMA_UART_TX_DESC_ADDR(0));

  nextTx_sdma_buf = 0;
}

/*
 * This function initializes the SDMA RX buffers.

 * It supports the initialization of a buffer descriptor chain, in
 * which each descriptor is linked to the next one, and the last one
 * points to the first one (circular list).
 */
static void initialize_sdma_rx_buffers(void)
{
  int i;

  for (i = 0; i < SDMA_RX_BUFFER_NUM; i++)
    {
      /* First and last buffer, Enable Interrupt, buffer is Owned by
	 the MV64340 */
      SDMA_UART_RX_DESC_WRITE(i, CMD_STAT_OFF,
			      (1 << SDMA_DESC_L) |
			      (1 << SDMA_DESC_F) |
			      (1 << SDMA_DESC_EI) |
			      (1 << SDMA_DESC_O));

      /* Configure the size of the buffer */
      SDMA_UART_RX_DESC_WRITE(i, BUF_SZ_OFF,
			      (0 << SDMA_DESC_BYTE_COUNT) |
			      (SDMA_RX_BUFFER_SIZE << SDMA_DESC_BUFFER_SIZE));

      /* Set up the address of the buffer corresponding to this buffer
	 descriptor */
      SDMA_UART_RX_DESC_WRITE(i, BUF_ADDR_OFF,
			      SDMA_UART_RX_BUF_ADDR(i));

      /* Points to the next buffer descriptor */
      SDMA_UART_RX_DESC_WRITE(i, BUF_NEXT_OFF,
			      SDMA_UART_RX_DESC_ADDR(i + 1));

#ifdef MV64340_SERIAL_DEBUG
      memset((void*) SDMA_UART_RX_BUF_ADDR(i), 'B', SDMA_RX_BUFFER_SIZE);
#endif
    }

  /* Make the last buffer descriptor point to the first one */
  SDMA_UART_RX_DESC_WRITE((SDMA_RX_BUFFER_NUM - 1),
			  BUF_NEXT_OFF,
			  SDMA_UART_RX_DESC_ADDR(0));

  /* Set the first RX buffer descriptor as the current one */
  MV_WRITE(MV64340_SDMA_CURRENT_RX_DESCRIPTOR_POINTER(1),
	   SDMA_UART_RX_DESC_ADDR(0));

  MV_WRITE(MV64340_MPSC_CHANNEL_REG3(1), 0xFFF);

  /* enable receive DMA channel in SDCM0 */
  MV_WRITE(MV64340_SDMA_COMMAND_REG(1), MV64340_SDMA_SDCM_ERD);

  nextRx_sdma_buf = 0;
}

/*
 * This function prepares the SDMA TX buffer for a transmission
 */
static void mv64340_prepare_tx_buffer(void)
{
  /* Only one TX buffer */
  nextTx_sdma_buf = 0;

  /* Make sure status/command is correctly initialized */
  SDMA_UART_TX_DESC_WRITE(nextTx_sdma_buf,
			  CMD_STAT_OFF,
			  (1 << SDMA_DESC_L) |
			  (1 << SDMA_DESC_F) |
			  (1 << SDMA_DESC_EI) |
			  (1 << SDMA_DESC_O));

  /* Set all sizes to 0, as they will be properly set later by the
     mv64340_commit_tx_buffer() function */
  SDMA_UART_TX_DESC_WRITE(nextTx_sdma_buf,
			  BUF_SZ_OFF,
			  ((0 << SDMA_DESC_BYTE_COUNT) |
			   (0 << SDMA_DESC_BUFFER_SIZE)));

  /* Reset the character counter, so that character that needs to be
     transmitted will be inserted at the beginning of the buffer by
     the mv64340_add_char_to_tx_buffer() function */
  Txbuf_ch_cnt = 0;

#ifdef MV64340_SERIAL_DEBUG
  memset((void*) SDMA_UART_TX_BUF_ADDR(0), 'A', SDMA_TX_BUFFER_SIZE);
#endif
}

/*
 * Adds a single character in the TX buffer for a transmission. The
 * buffer MUST have been prepared by a call to
 * mv64340_prepare_tx_buffer().
 *
 * ch : The character to add in the TX buffer
 */
static void mv64340_add_char_to_tx_buffer(unsigned char ch)
{
  /* Write the character to the buffer */
  SDMA_UART_TX_BUFFER_WRITE(nextTx_sdma_buf, Txbuf_ch_cnt, ch);

  /* Increment the counter for the next character */
  Txbuf_ch_cnt++;
}

/*
 * This function really issue the transmission of data contained in
 * the TX buffer.
 *
 * The TX buffer MUST have been already reset by the
 * mv64340_prepare_tx_buffer() function and characters should have
 * been added using the mv64340_add_char_to_tx_buffer() function
 */
static void mv64340_commit_tx_buffer(void)
{
  /* Correctly set the size fields */
  SDMA_UART_TX_DESC_WRITE(nextTx_sdma_buf,
			  BUF_SZ_OFF,
			  ((Txbuf_ch_cnt << SDMA_DESC_BYTE_COUNT) |
			   (Txbuf_ch_cnt << SDMA_DESC_BUFFER_SIZE)));

  /* Let's go with the transmission by issuing a TxD (TX demand). We
     will be informed of the completion with an interrupt */
  MV_WRITE(MV64340_SDMA_COMMAND_REG(1), MV64340_SDMA_SDCM_TXD);
}

/*
 * This function transmits characters using SDMA TX buffer. It tries
 * to transmit as many characters as possible (the limit is
 * SDMA_TX_BUFFER_SIZE and the number of available character in the
 * TTY buffer).
 *
 * port : The serial port
 */
static void mv64340_tx_chars(struct uart_port *port)
{
  struct circ_buf *xmit = &port->info->xmit;
  int count;

  mv64340_prepare_tx_buffer();

  /* Send the XON/XOFF character, and return */
  if (port->x_char) {
    mv64340_add_char_to_tx_buffer(port->x_char);
    mv64340_commit_tx_buffer();
    port->icount.tx++;
    port->x_char = 0;
    return;
  }

  /* Nothing to send anymore ? */
  if (uart_circ_empty(xmit) || uart_tx_stopped(port)) {
    mv64340_stop_tx(port, 0);
    return;
  }

  /* Fill in the SDMA TX buffer with as many characters as possible */
  count = SDMA_TX_BUFFER_SIZE;
  do {
    mv64340_add_char_to_tx_buffer(xmit->buf[xmit->tail]);
    xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
    port->icount.tx++;
    if (uart_circ_empty(xmit))
      break;
  } while (--count > 0);

  /* Start the transmission */
  mv64340_commit_tx_buffer();

  if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
    uart_write_wakeup(port);

  /* If verything is done, stop */
  if (uart_circ_empty(xmit))
    mv64340_stop_tx(port, 0);
}

/*
 * This function resets the current reception, reset the SDMA cause
 * register and the SDMA RX buffers.
 */
static void reset_rx(void) {
  unsigned int tmp;

  //  printk("Reset RX\n");

  /* Clear "Enable Rx DMA" bit, and abort current reception by setting
     AR bit. See MV64340 documentation, table 556, page 629 */
  tmp = MV_READ(MV64340_SDMA_COMMAND_REG(1));
  tmp &= ~MV64340_SDMA_SDCM_ERD;
  tmp |= MV64340_SDMA_SDCM_AR;
  MV_WRITE(MV64340_SDMA_COMMAND_REG(1), tmp);

  /* Wait for the "abort reception" bit to become 0 */
  while(1)
    {
      tmp = MV_READ(MV64340_SDMA_COMMAND_REG(1));
      if (!(tmp & MV64340_SDMA_SDCM_AR))
	break;
    };

  MV_WRITE(MV64340_SDMA_CAUSE_REG, 0);

  initialize_sdma_rx_buffers();
  initialize_sdma_tx_buffers();
}

/*
 * This function prepares the buffers for the next receptions
 */
static void setup_next_rx(void)
{
  /*
   * Restore the buffer descriptor used for the current reception to
   * its original state.
   */
  SDMA_UART_RX_DESC_WRITE(nextRx_sdma_buf,
			  CMD_STAT_OFF,
			  (1 << SDMA_DESC_L) |
			  (1 << SDMA_DESC_F) |
			  (1 << SDMA_DESC_EI) |
			  (1 << SDMA_DESC_O));
  SDMA_UART_RX_DESC_WRITE(nextRx_sdma_buf,
			  BUF_SZ_OFF,
			  ((0 << SDMA_DESC_BYTE_COUNT) |
			   (SDMA_RX_BUFFER_SIZE << SDMA_DESC_BUFFER_SIZE)));

#ifdef MV64340_SERIAL_DEBUG
      memset((void*) SDMA_UART_RX_BUF_ADDR(nextRx_sdma_buf),
	     'B', SDMA_RX_BUFFER_SIZE);
#endif

  /* Next reception will occur in next buffer */
  nextRx_sdma_buf++;
  nextRx_sdma_buf &= SDMA_RX_BUFFER_MASK;
}

/*
 * THis function handles the reception of data from a single SDMA
 * buffer, pointed by the nextRx_sdma_buf variable. It will transfer
 * the data contained in this buffer to the TTY input buffer, so as to
 * make the data available to applications.
 *
 * port : The port on which the interrupt occured
 */
static void mv64340_do_rx_buffer(struct uart_port *port)
{
  unsigned int byte_count, cnt;
  struct tty_struct *tty = port->info->tty;

  /* Compute the number of bytes of data inside the buffer */
  byte_count =  SDMA_UART_RX_DESC_READ(nextRx_sdma_buf, BUF_SZ_OFF);
  byte_count &= 0xFFFF;

  if(byte_count == 0) {
    MV_WRITE(MV64340_MPSC_CHANNEL_REG3(1), 0xFFF);
    return;
  }

  /* Iterate on each byte */
  for (cnt = 0 ; cnt < byte_count ; cnt++)
    {
      unsigned char ch;

      /* Make sure there's enough room in the tty buffer */
      if(tty->flip.count >= TTY_FLIPBUF_SIZE)
	{
	  tty->flip.work.func((void*) tty);
	  if(tty->flip.count >= TTY_FLIPBUF_SIZE)
	    return;
	}

      /* Fetch the data */
      ch = SDMA_UART_RX_BUFFER_READ(nextRx_sdma_buf, cnt);

      /* Insert it in the buffer */
      *tty->flip.char_buf_ptr++ = ch;
      *tty->flip.flag_buf_ptr++ = TTY_NORMAL;
      port->icount.rx++;
      tty->flip.count++;
    }

  /* Push the buffer to the tty */
  tty_flip_buffer_push(tty);
}

/*
 * This function handles the reception of data from a serial port. It
 * is called by the interrupt handler. First of all, it checks for
 * errors, and then iterates on each buffer to receive the
 * data. Collecting the data of each buffer is done by an internal
 * function, mv64340_do_rx_buffer.
 *
 * port  : The port on which occured the interrupt
 *
 * cause : A pointer to the SDMA interrupt cause as input. The
 * function should modify this value according to its needs. Then, the
 * calling function will write this modified SDMA cause to the SDMA
 * cause register.
 *
 * Returns 0 on success, -1 when error occured.
 */
static int mv64340_do_rx(struct uart_port *port, unsigned int *cause)
{
  unsigned int sdma_desc_stat_off;

  /* Clear the RX buffer return bit for channel 1 */
  *cause &= ~ SDMA_CAUSE_RX_BUFFER_RETURN(1);

  /* Was there a reception error ? */
  if(*cause & SDMA_CAUSE_RX_BUFFER_ERROR(1))
    {
      /* Do something */
      reset_rx();
      return -1;
    }

  /* Fetch the status part of the first buffer descriptor */
  sdma_desc_stat_off = SDMA_UART_RX_DESC_READ(nextRx_sdma_buf,
					      CMD_STAT_OFF);

  /* When bit O (Owner) is not set, it means that the CPU owns the
     buffer, and must handle it. We do not only handle the current
     buffer, but all buffer that are not owned anymore by the Marvell,
     because during the handling of an interrupt, multiple buffers can
     be filled, but only one interrupt will be generated */
  while((sdma_desc_stat_off & (1 << SDMA_DESC_O)) == 0)
    {
      /* Was there an error ? */
      if(sdma_desc_stat_off & (1 << SDMA_DESC_ES))
	{
	  if(sdma_desc_stat_off & (1 << SDMA_DESC_PE))
	    port->icount.parity++;
	  if(sdma_desc_stat_off & (1 << SDMA_DESC_FR))
	    port->icount.frame++;
	  if(sdma_desc_stat_off & (1 << SDMA_DESC_OR))
	    port->icount.overrun++;

	  reset_rx();
	  return -1;
	}

      /* Transfer the data from the SDMA buffer to the TTY buffer */
      mv64340_do_rx_buffer(port);

      /* Set up for next reception (will clean up current buffer
	 descriptor and increment nextRx_sdma_buf) */
      setup_next_rx();

      /* Fetch the status part of the next descriptor */
      sdma_desc_stat_off = SDMA_UART_RX_DESC_READ(nextRx_sdma_buf,
						  CMD_STAT_OFF);
    }

  return 0;
}

/*
 * This is the serial driver interrupt handler. It is called when
 * reception or transmission interrupt occurs
 */
static inline irqreturn_t mv64340_interrupt(int irq, void *dev_id,
					    struct pt_regs *regs)
{
  struct uart_port *port = dev_id;
  unsigned int cause;
  int res;

  spin_lock(& port->lock);

  cause = MV_READ(MV64340_SDMA_CAUSE_REG);

  /* Reception */
  if(cause & SDMA_CAUSE_RX_BUFFER_RETURN(1))
    {
      res = mv64340_do_rx(port, & cause);
      if(res < 0)
	{
	  printk("MV64340-serial: reception error\n");
	  cause &= ~SDMA_CAUSE_RX_BUFFER_ERROR(1);
	  //	  MV_WRITE(MV64340_SDMA_CAUSE_REG, cause);
	  MV_WRITE(MV64340_SDMA_CAUSE_REG, 0);
	  reset_rx();
	  spin_unlock(& port->lock);
	  return IRQ_HANDLED;
	}
    }

  /* Transmission end notification */
  if(cause & SDMA_CAUSE_TX_BUFFER_RETURN(1))
    {
      cause &= ~SDMA_CAUSE_TX_BUFFER_RETURN(1);

      /* Transmission error ? */
      if(cause & SDMA_CAUSE_TX_BUFFER_ERROR(1))
	{
	  printk("MV64340-serial: transmission error\n");
	  cause &= ~SDMA_CAUSE_TX_BUFFER_ERROR(1);
	  //MV_WRITE(MV64340_SDMA_CAUSE_REG, cause);
	  MV_WRITE(MV64340_SDMA_CAUSE_REG, 0);
	  reset_rx();
	  spin_unlock(& port->lock);
	  return IRQ_HANDLED;
	}

      mv64340_tx_chars(port);
    }

  /* Write back the new value of the cause register */
  //MV_WRITE(MV64340_SDMA_CAUSE_REG, cause);
  MV_WRITE(MV64340_SDMA_CAUSE_REG, 0);

  spin_unlock(& port->lock);

  return IRQ_HANDLED;
}

/*
 *
 * Below are the functions needed by the serial_core API. They are all
 * listed in the uart_ops structure.
 *
 */

static unsigned int mv64340_tx_empty(struct uart_port *port)
{
  return TIOCSER_TEMT;
}

static void mv64340_set_mctrl(struct uart_port *port, unsigned int mctrl)
{
}

static unsigned int mv64340_get_mctrl(struct uart_port *port)
{
  return 0;
}

static void mv64340_break_ctl(struct uart_port *port, int break_state)
{
}

static void mv64340_stop_tx(struct uart_port *port, unsigned int tty_stop)
{
  unsigned int tmp;

  if(! tty_stop)
    return;

  /* port->lock is already taken */

  /* Stop interrupts on TX */
  tmp = MV_READ(MV64340_SDMA_MASK_REG);
  tmp &= ~(0x3 << 10);
  MV_WRITE(MV64340_SDMA_MASK_REG, tmp);
}

static void mv64340_start_tx(struct uart_port *port, unsigned int tty_start)
{
  unsigned int tmp;

  if(! tty_start)
    return;

  /* port->lock is already taken */

  /* Activate interrupts on TX */
  tmp = MV_READ(MV64340_SDMA_MASK_REG);
  tmp |= (0x3 << 10);
  MV_WRITE(MV64340_SDMA_MASK_REG, tmp);

  mb();

  /* We issue a "fake" transmission demand to generate the first
     interrupt that will really call the tranmission process */
  MV_WRITE(MV64340_SDMA_COMMAND_REG(1), MV64340_SDMA_SDCM_TXD);
}

static void mv64340_stop_rx(struct uart_port *port)
{
  unsigned int tmp;

  /* port->lock is already taken */

  /* Stop interrupts on RX */
  tmp = MV_READ(MV64340_SDMA_MASK_REG);
  tmp &= ~(0x3 << 8);
  MV_WRITE(MV64340_SDMA_MASK_REG, tmp);
}


static void mv64340_enable_ms(struct uart_port *port)
{
}

static int mv64340_startup(struct uart_port *port)
{
  unsigned int tmp;

  spin_lock(& port->lock);

  reset_rx();
  initialize_sdma_tx_buffers();

  tmp = MV_READ(MV64340_SDMA_MASK_REG);
  tmp |= (/* (0x3 << 10) | */ (0x3 << 8));
  MV_WRITE(MV64340_SDMA_MASK_REG, tmp);

  spin_unlock(& port->lock);

  return 0;
}

static void mv64340_shutdown(struct uart_port *port)
{
  unsigned int tmp;

  spin_lock(& port->lock);

  tmp = MV_READ(MV64340_SDMA_MASK_REG);
  tmp &= ~((0x3 << 10) | (0x3 << 8));
  MV_WRITE(MV64340_SDMA_MASK_REG, tmp);

  spin_unlock(& port->lock);
}

static const char *mv64340_type(struct uart_port *port)
{
  return "mv64340-serial";
}

static void mv64340_release_port(struct uart_port *port)
{
}

static int mv64340_request_port(struct uart_port *port)
{
  return 0;
}

static void mv64340_config_port(struct uart_port *port, int flags)
{
}

static int mv64340_verify_port(struct uart_port *port, struct serial_struct *ser)
{
  return 0;
}

static void mv64340_set_termios(struct uart_port *port, struct termios *new,
                                struct termios *old)
{
}

static struct uart_ops mv64340_ops = {
  .tx_empty	= mv64340_tx_empty,
  .set_mctrl	= mv64340_set_mctrl,
  .get_mctrl	= mv64340_get_mctrl,
  .stop_tx	= mv64340_stop_tx,
  .start_tx	= mv64340_start_tx,
  .stop_rx	= mv64340_stop_rx,
  .enable_ms	= mv64340_enable_ms,
  .break_ctl	= mv64340_break_ctl,
  .startup	= mv64340_startup,
  .shutdown	= mv64340_shutdown,
  .type		= mv64340_type,
  .release_port	= mv64340_release_port,
  .request_port	= mv64340_request_port,
  .config_port	= mv64340_config_port,
  .verify_port	= mv64340_verify_port,
  .set_termios  = mv64340_set_termios,
};

static struct uart_port mv64340_port = {
  .ops		= &mv64340_ops,
  .type         = PORT_MV64340,
};

struct uart_driver mv64340_reg = {
  .owner	= THIS_MODULE,
  .driver_name	= MV64340_SERIAL_NAME,
  .dev_name	= "ttyS",
  .major	= TTY_MAJOR,
  .minor	= 64,
  .nr		= MV64340_SERIAL_NR,
};


static int __init mv64340_init(void)
{
  int result;

  printk("[mv64340-serial] Sram base @ 0x%x\n", sram_base);

  result = uart_register_driver(&mv64340_reg);
  if (result)
    return result;

  result = uart_add_one_port(&mv64340_reg, &mv64340_port);
  if (result)
    uart_unregister_driver(&mv64340_reg);

  if(request_irq((NPP_BOARD_MV64340_IRQ_BASE + MV64340_SDMA1_INT),
		 mv64340_interrupt, (SA_INTERRUPT),
		 "uart", &mv64340_port)) {
    printk(KERN_ERR "Cannot allocate IRQ for UARTA_RX.\n");
  }

  initialize_sdma_rx_buffers();
  initialize_sdma_tx_buffers();

  printk("MV64340 Serial driver, using IRQ %d\n",
	 NPP_BOARD_MV64340_IRQ_BASE + MV64340_SDMA1_INT);

  return result;
}

module_init (mv64340_init);

--------------030904090902040005010107--

--------------enig3D1206668ABA14F79AFB3537
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFB3lwf9lPLMJjT96cRArfHAKC5kI4ZPp4n9NGj62GERE7rYS6GrQCfVw9H
asMJ39Y1WyCVdlR9flgYR0Q=
=gIdh
-----END PGP SIGNATURE-----

--------------enig3D1206668ABA14F79AFB3537--
