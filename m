Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Jan 2016 21:29:14 +0100 (CET)
Received: from exsmtp03.microchip.com ([198.175.253.49]:64147 "EHLO
        email.microchip.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009376AbcAEU3K4DG2F convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Jan 2016 21:29:10 +0100
Received: from CHN-SV-EXMX01.mchp-main.com ([fe80::453e:263d:be10:ebe8]) by
 chn-sv-exch03.mchp-main.com ([fe80::9916:1afa:df82:7a64%14]) with mapi id
 14.03.0181.006; Tue, 5 Jan 2016 13:29:01 -0700
From:   <Paul.Thacker@microchip.com>
To:     <andy.shevchenko@gmail.com>, <Joshua.Henderson@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <ralf@linux-mips.org>, <Andrei.Pistirica@microchip.com>,
        <gregkh@linuxfoundation.org>, <jslaby@suse.com>,
        <linux-serial@vger.kernel.org>, <linux-api@vger.kernel.org>
Subject: Re: [PATCH v2 10/14] serial: pic32_uart: Add PIC32 UART driver
Thread-Topic: [PATCH v2 10/14] serial: pic32_uart: Add PIC32 UART driver
Thread-Index: AQHRNsCME92lzOY7V0e3fYiKG2XSEA==
Date:   Tue, 5 Jan 2016 20:29:00 +0000
Message-ID: <F2D704DDA6AE8B4A87FF87509480F4A449E4072A@CHN-SV-EXMX01.mchp-main.com>
References: <1450133093-7053-1-git-send-email-joshua.henderson@microchip.com>
        <1450133093-7053-11-git-send-email-joshua.henderson@microchip.com>
 <CAHp75VeAEmw-nrq+O_-ER6Hb+ktNghYRo37XDhTZCWBvWSWRoQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.10.215.90]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Paul.Thacker@microchip.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50933
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Paul.Thacker@microchip.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 12/20/2015 09:14 AM, Andy Shevchenko wrote:
> On Tue, Dec 15, 2015 at 12:42 AM, Joshua Henderson
> <joshua.henderson@microchip.com> wrote:
>> From: Andrei Pistirica <andrei.pistirica@microchip.com>
>>
>> This adds UART and a serial console driver for Microchip PIC32 class
>> devices.
>>
>> Signed-off-by: Andrei Pistirica <andrei.pistirica@microchip.com>
>> Signed-off-by: Joshua Henderson <joshua.henderson@microchip.com>
>> Cc: Ralf Baechle <ralf@linux-mips.org>
>> ---
>>   drivers/tty/serial/Kconfig       |   21 +
>>   drivers/tty/serial/Makefile      |    1 +
>>   drivers/tty/serial/pic32_uart.c  |  927 ++++++++++++++++++++++++++++++++++++++
>>   drivers/tty/serial/pic32_uart.h  |  198 ++++++++
>>   include/uapi/linux/serial_core.h |    3 +
>>   5 files changed, 1150 insertions(+)
>>   create mode 100644 drivers/tty/serial/pic32_uart.c
>>   create mode 100644 drivers/tty/serial/pic32_uart.h
>>
>> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
>> index f38beb2..8853b1e 100644
>> --- a/drivers/tty/serial/Kconfig
>> +++ b/drivers/tty/serial/Kconfig
>> @@ -901,6 +901,27 @@ config SERIAL_SGI_L1_CONSOLE
>>                  controller serial port as your console (you want this!),
>>                  say Y.  Otherwise, say N.
>>
>> +config SERIAL_PIC32
>> +       tristate "Microchip PIC32 serial support"
>> +       depends on MACH_PIC32
>> +       select SERIAL_CORE
>> +       help
>> +         If you have a PIC32, this driver supports the serial ports.
>> +
>> +         Say Y or M to use PIC32 serial ports, otherwise say N. Note that
>> +         to use a serial port as a console, this must be included in kernel and
>> +         not as a module.
>> +
>> +config SERIAL_PIC32_CONSOLE
>> +       bool "PIC32 serial console support"
>> +       depends on SERIAL_PIC32
>> +       select SERIAL_CORE_CONSOLE
>> +       help
>> +         If you have a PIC32, this driver supports the putting a console on one
>> +         of the serial ports.
>> +
>> +         Say Y to use the PIC32 console, otherwise say N.
>> +
>>   config SERIAL_MPC52xx
>>          tristate "Freescale MPC52xx/MPC512x family PSC serial support"
>>          depends on PPC_MPC52xx || PPC_MPC512x
>> diff --git a/drivers/tty/serial/Makefile b/drivers/tty/serial/Makefile
>> index 5ab4111..bc5e354 100644
>> --- a/drivers/tty/serial/Makefile
>> +++ b/drivers/tty/serial/Makefile
>> @@ -93,6 +93,7 @@ obj-$(CONFIG_SERIAL_CONEXANT_DIGICOLOR)       += digicolor-usart.o
>>   obj-$(CONFIG_SERIAL_MEN_Z135)  += men_z135_uart.o
>>   obj-$(CONFIG_SERIAL_SPRD) += sprd_serial.o
>>   obj-$(CONFIG_SERIAL_STM32)     += stm32-usart.o
>> +obj-$(CONFIG_SERIAL_PIC32)     += pic32_uart.o
>>
>>   # GPIOLIB helpers for modem control lines
>>   obj-$(CONFIG_SERIAL_MCTRL_GPIO)        += serial_mctrl_gpio.o
>> diff --git a/drivers/tty/serial/pic32_uart.c b/drivers/tty/serial/pic32_uart.c
>> new file mode 100644
>> index 0000000..5c05c11
>> --- /dev/null
>> +++ b/drivers/tty/serial/pic32_uart.c
>> @@ -0,0 +1,927 @@
>> +/*
>> + * PIC32 Integrated Serial Driver.
>> + *
>> + * Copyright (C) 2015 Microchip Technology, Inc.
>> + *
>> + * Authors:
>> + *   Steve Scott <steve.scott@microchip.com>,
>> + *   Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +
>> +#include <linux/kernel.h>
>> +#include <linux/platform_device.h>
>> +#include <linux/of.h>
>> +#include <linux/of_device.h>
>> +#include <linux/of_irq.h>
>> +#include <linux/of_gpio.h>
>> +#include <linux/init.h>
>> +#include <linux/module.h>
>> +#include <linux/slab.h>
>> +#include <linux/console.h>
>> +#include <linux/clk-provider.h>
>
> Didn't notice clock provider here.

Not needed. Will be removed.

>
>> +#include <linux/clk.h>
>> +#include <linux/clkdev.h>
>> +#include <linux/tty.h>
>> +#include <linux/tty_flip.h>
>> +#include <linux/sysrq.h>
>> +#include <linux/serial.h>
>> +#include <linux/serial_core.h>
>> +#include <uapi/linux/serial_core.h>
>> +#include <linux/delay.h>
>
> Revisit this list and leave exactly what is used.

Done. Updated patch will remove linux/clkdev.h, linux/sysrq.h, 
linux/serial.h, uapi/linux/serial_core.h.

>
>> +
>> +#include "pic32_uart.h"
>> +
>> +/* UART name and device definitions */
>> +#define PIC32_DEV_NAME         "pic32-uart"
>> +#define PIC32_MAX_UARTS                6
>> +
>> +#define PIC32_SDEV_NAME                "ttyS"
>> +#define PIC32_SDEV_MAJOR       TTY_MAJOR
>> +#define PIC32_SDEV_MINOR       64
>> +
>> +/* pic32_sport pointer for console use */
>> +static struct pic32_sport *pic32_sports[PIC32_MAX_UARTS];
>> +
>> +static inline int pic32_enable_clock(struct pic32_sport *sport)
>> +{
>> +       sport->ref_clk++;
>> +
>
> Useless empty line (do in one style).

Ack.

>
>> +       return clk_prepare_enable(sport->clk);
>> +}
>> +
>> +static inline void pic32_disable_clock(struct pic32_sport *sport)
>> +{
>> +       sport->ref_clk--;
>> +       clk_disable_unprepare(sport->clk);
>> +}
>> +
>> +/* serial core request to check if uart tx buffer is empty */
>> +static unsigned int pic32_uart_tx_empty(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +       u32 val = pic32_uart_read(sport, PIC32_UART_STA);
>> +
>> +       return (val & PIC32_UART_STA_TRMT) ? 1 : 0;
>> +}
>> +
>> +/* serial core request to set UART outputs */
>> +static void pic32_uart_set_mctrl(struct uart_port *port, unsigned int mctrl)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +
>> +       /* set loopback mode */
>> +       if (mctrl & TIOCM_LOOP)
>> +               pic32_uart_rset(PIC32_UART_MODE_LPBK, sport, PIC32_UART_MODE);
>> +       else
>> +               pic32_uart_rclr(PIC32_UART_MODE_LPBK, sport, PIC32_UART_MODE);
>> +}
>> +
>> +/* get the state of CTS input pin for this port */
>> +static unsigned int get_cts_state(struct pic32_sport *sport)
>> +{
>> +       /* default state must be asserted */
>> +       int val = 1;
>
> Redundant.
>
>> +
>> +       /* read and invert UxCTS */
>> +       if (gpio_is_valid(sport->cts_gpio))
>> +               val = !gpio_get_value(sport->cts_gpio);
>
> If (�)
>   return �;
>
> return 1;

Ack.

>
>> +
>> +       return val;
>> +}
>> +
>> +/* serial core request to return the state of misc UART input pins */
>> +static unsigned int pic32_uart_get_mctrl(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +       unsigned int mctrl = 0;
>> +
>> +       if (!sport->hw_flow_ctrl) {
>> +               mctrl |= TIOCM_CTS;
>
>> +               goto ret;
>> +       }
>> +
>> +       if (get_cts_state(sport))
>
> else if (get_cts_state(sport))

Ack.

>
>> +               mctrl |= TIOCM_CTS;
>> +
>
>> +ret:
>
> And remove useless label, besides that fact that its name is awfully chosen.

Ack.

>
>> +       /* DSR and CD are not supported in PIC32, so return 1
>> +        * RI is not supported in PIC32, so return 0
>> +        */
>> +       mctrl |= TIOCM_CD;
>> +       mctrl |= TIOCM_DSR;
>> +
>> +       return mctrl;
>> +}
>> +
>> +/* stop tx and start tx are not called in pairs, therefore a flag indicates
>> + * the status of irq to control the irq-depth.
>> + */
>> +static inline void pic32_uart_irqtxen(struct pic32_sport *sport, u8 en)
>> +{
>> +       if (en && !tx_irq_enabled(sport)) {
>> +               enable_irq(sport->irq_tx);
>> +               tx_irq_enabled(sport) = 1;
>> +       } else if (!en && tx_irq_enabled(sport)) {
>> +               /* use disable_irq_nosync() and not disable_irq() to avoid self
>> +                * imposed deadlock by not waiting for irq handler to end,
>> +                * since this callback is called from interrupt context.
>> +                */
>> +               disable_irq_nosync(sport->irq_tx);
>> +               tx_irq_enabled(sport) = 0;
>> +       }
>> +}
>> +
>> +/* serial core request to disable tx ASAP (used for flow control) */
>> +static void pic32_uart_stop_tx(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +
>> +       if (!(pic32_uart_read(sport, PIC32_UART_MODE) & PIC32_UART_MODE_ON))
>> +               return;
>> +
>> +       if (!(pic32_uart_read(sport, PIC32_UART_STA) & PIC32_UART_STA_UTXEN))
>> +               return;
>> +
>> +       /* wait for tx empty */
>> +       while (!(pic32_uart_read(sport, PIC32_UART_STA) & PIC32_UART_STA_TRMT))
>> +               udelay(1);
>> +
>> +       pic32_uart_rclr(PIC32_UART_STA_UTXEN, sport, PIC32_UART_STA);
>> +       pic32_uart_irqtxen(sport, 0);
>> +}
>> +
>> +/* serial core request to (re)enable tx */
>> +static void pic32_uart_start_tx(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +
>> +       pic32_uart_irqtxen(sport, 1);
>> +       pic32_uart_rset(PIC32_UART_STA_UTXEN, sport, PIC32_UART_STA);
>> +}
>> +
>> +/* serial core request to stop rx, called before port shutdown */
>> +static void pic32_uart_stop_rx(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +
>> +       /* disable rx interrupts */
>> +       disable_irq(sport->irq_rx);
>> +
>> +       /* receiver Enable bit OFF */
>> +       pic32_uart_rclr(PIC32_UART_STA_URXEN, sport, PIC32_UART_STA);
>> +}
>> +
>> +/* serial core request to start/stop emitting break char */
>> +static void pic32_uart_break_ctl(struct uart_port *port, int ctl)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +       unsigned long flags = 0;
>
> Useless assignment.

Ack.

>
>> +
>> +       spin_lock_irqsave(&port->lock, flags);
>> +
>> +       if (ctl)
>> +               pic32_uart_rset(PIC32_UART_STA_UTXBRK, sport, PIC32_UART_STA);
>> +       else
>> +               pic32_uart_rclr(PIC32_UART_STA_UTXBRK, sport, PIC32_UART_STA);
>> +
>> +       spin_unlock_irqrestore(&port->lock, flags);
>> +}
>> +
>> +/* get port type in string format */
>> +static const char *pic32_uart_type(struct uart_port *port)
>> +{
>> +       return (port->type == PORT_PIC32) ? PIC32_DEV_NAME : NULL;
>> +}
>> +
>> +/* read all chars in rx fifo and send them to core */
>> +static void pic32_uart_do_rx(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +       struct tty_port *tty;
>> +       unsigned int max_count;
>> +
>> +       /* limit number of char read in interrupt, should not be
>> +        * higher than fifo size anyway since we're much faster than
>> +        * serial port
>> +        */
>> +       max_count = PIC32_UART_RX_FIFO_DEPTH;
>> +
>> +       spin_lock(&port->lock);
>> +
>> +       tty = &port->state->port;
>> +
>> +       do {
>> +               u32 sta_reg, c;
>> +               char flag;
>> +
>> +               /* get overrun/fifo empty information from status register */
>> +               sta_reg = pic32_uart_read(sport, PIC32_UART_STA);
>> +               if (unlikely(sta_reg & PIC32_UART_STA_OERR)) {
>> +
>> +                       /* fifo reset is required to clear interrupt */
>> +                       pic32_uart_rclr(PIC32_UART_STA_OERR, sport,
>> +                                                       PIC32_UART_STA);
>> +
>> +                       port->icount.overrun++;
>> +                       tty_insert_flip_char(tty, 0, TTY_OVERRUN);
>> +               }
>> +
>> +               /* Can at least one more character can be read? */
>> +               if (!(sta_reg & PIC32_UART_STA_URXDA))
>> +                       break;
>> +
>> +               /* read the character and increment the rx counter */
>> +               c = pic32_uart_read(sport, PIC32_UART_RX);
>> +
>> +               port->icount.rx++;
>> +               flag = TTY_NORMAL;
>> +               c &= 0xff;
>> +
>> +               if (unlikely((sta_reg & PIC32_UART_STA_PERR) ||
>> +                            (sta_reg & PIC32_UART_STA_FERR))) {
>> +
>> +                       /* do stats first */
>> +                       if (sta_reg & PIC32_UART_STA_PERR)
>> +                               port->icount.parity++;
>> +                       if (sta_reg & PIC32_UART_STA_FERR)
>> +                               port->icount.frame++;
>> +
>> +                       /* update flag wrt read_status_mask */
>> +                       sta_reg &= port->read_status_mask;
>> +
>> +                       if (sta_reg & PIC32_UART_STA_FERR)
>> +                               flag = TTY_FRAME;
>> +                       if (sta_reg & PIC32_UART_STA_PERR)
>> +                               flag = TTY_PARITY;
>> +               }
>> +
>> +               if (uart_handle_sysrq_char(port, c))
>> +                       continue;
>> +
>> +               if ((sta_reg & port->ignore_status_mask) == 0)
>> +                       tty_insert_flip_char(tty, c, flag);
>> +
>> +       } while (--max_count);
>> +
>> +       spin_unlock(&port->lock);
>> +
>> +       tty_flip_buffer_push(tty);
>> +}
>> +
>> +/* fill tx fifo with chars to send, stop when fifo is about to be full
>> + * or when all chars have been sent.
>> + */
>> +static void pic32_uart_do_tx(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +       struct circ_buf *xmit = &port->state->xmit;
>> +       unsigned int max_count = PIC32_UART_TX_FIFO_DEPTH;
>> +
>> +       if (port->x_char) {
>> +               pic32_uart_write(port->x_char, sport, PIC32_UART_TX);
>> +               port->icount.tx++;
>> +               port->x_char = 0;
>> +               return;
>> +       }
>> +
>> +       if (uart_tx_stopped(port)) {
>> +               pic32_uart_stop_tx(port);
>> +               return;
>> +       }
>> +
>> +       if (uart_circ_empty(xmit))
>> +               goto txq_empty;
>> +
>> +       /* keep stuffing chars into uart tx buffer
>> +        * 1) until uart fifo is full
>> +        * or
>> +        * 2) until the circ buffer is empty
>> +        * (all chars have been sent)
>> +        * or
>> +        * 3) until the max count is reached
>> +        * (prevents lingering here for too long in certain cases)
>> +        */
>> +       while (!(PIC32_UART_STA_UTXBF &
>> +               pic32_uart_rval(sport, PIC32_UART_STA))) {
>> +               unsigned int c = xmit->buf[xmit->tail];
>> +
>> +               pic32_uart_write(c, sport, PIC32_UART_TX);
>> +
>> +               xmit->tail = (xmit->tail + 1) & (UART_XMIT_SIZE - 1);
>> +               port->icount.tx++;
>> +               --max_count;
>
> It's not used outside of while, so �
>
>> +               if (uart_circ_empty(xmit))
>> +                       break;
>> +               if (max_count == 0)
>
> if (--mac_count == 0)
>
>> +                       break;
>
> Or you can move the original 'if' condition inside 'while' one since
> it's a last in the loop.

Will change to if (--mac_count == 0).

>
>> +       }
>> +
>> +       if (uart_circ_chars_pending(xmit) < WAKEUP_CHARS)
>> +               uart_write_wakeup(port);
>> +
>> +       if (uart_circ_empty(xmit))
>> +               goto txq_empty;
>> +
>> +       return;
>> +
>> +txq_empty:
>> +       pic32_uart_irqtxen(sport, 0);
>> +}
>> +
>> +/* RX interrupt handler */
>> +static irqreturn_t pic32_uart_rx_interrupt(int irq, void *dev_id)
>> +{
>> +       struct uart_port *port = dev_id;
>> +
>> +       pic32_uart_do_rx(port);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +/* TX interrupt handler */
>> +static irqreturn_t pic32_uart_tx_interrupt(int irq, void *dev_id)
>> +{
>> +       struct uart_port *port = dev_id;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&port->lock, flags);
>> +       pic32_uart_do_tx(port);
>> +       spin_unlock_irqrestore(&port->lock, flags);
>> +
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +/* FAULT interrupt handler */
>> +static irqreturn_t pic32_uart_fault_interrupt(int irq, void *dev_id)
>> +{
>> +       /* do nothing: pic32_uart_do_rx() handles faults. */
>> +       return IRQ_HANDLED;
>> +}
>> +
>> +/* enable rx & tx operation on uart */
>> +static void pic32_uart_en_and_unmask(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +
>> +       pic32_uart_rset(PIC32_UART_STA_UTXEN | PIC32_UART_STA_URXEN,
>> +                       sport, PIC32_UART_STA);
>> +       pic32_uart_rset(PIC32_UART_MODE_ON, sport, PIC32_UART_MODE);
>> +}
>> +
>> +/* disable rx & tx operation on uart */
>> +static void pic32_uart_dsbl_and_mask(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +
>> +       pic32_uart_rclr(PIC32_UART_MODE_ON, sport, PIC32_UART_MODE);
>> +       pic32_uart_rclr(PIC32_UART_STA_UTXEN | PIC32_UART_STA_URXEN,
>> +                       sport, PIC32_UART_STA);
>> +}
>> +
>> +/* serial core request to initialize uart and start rx operation */
>> +static int pic32_uart_startup(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +       u32 dflt_baud = ((port->uartclk / PIC32_UART_DFLT_BRATE) / 16) - 1;
>
> Useless external parens.

Ack.

>
>> +       unsigned long flags;
>> +       int ret = 0;
>
> Useless assignment.

Ack.

>
>> +
>> +       local_irq_save(flags);
>> +
>> +       ret = pic32_enable_clock(sport);
>> +       if (ret)
>> +               goto out_unlock;
>> +
>> +       /* clear status and mode registers */
>> +       pic32_uart_write(0, sport, PIC32_UART_MODE);
>> +       pic32_uart_write(0, sport, PIC32_UART_STA);
>> +
>> +       /* disable uart and mask all interrupts */
>> +       pic32_uart_dsbl_and_mask(port);
>> +
>> +       /* set default baud */
>> +       pic32_uart_write(dflt_baud, sport, PIC32_UART_BRG);
>> +
>> +       local_irq_restore(flags);
>> +
>> +       /* Each UART of a PIC32 has three interrupts therefore,
>> +        * we setup driver to register the 3 irqs for the device.
>> +        *
>> +        * For each irq request_irq() is called with interrupt disabled.
>> +        * And the irq is enabled as soon as we are ready to handle them.
>> +        */
>> +       tx_irq_enabled(sport) = 0;
>> +
>> +       sport->irq_fault_name = kasprintf(GFP_KERNEL, "%s%d-fault",
>> +                                         pic32_uart_type(port),
>> +                                         sport->idx);
>> +       irq_set_status_flags(sport->irq_fault, IRQ_NOAUTOEN);
>> +       ret = request_irq(sport->irq_fault, pic32_uart_fault_interrupt,
>> +                         sport->irqflags_fault, sport->irq_fault_name, port);
>> +       if (ret) {
>> +               dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
>> +                       __func__, sport->irq_fault, ret,
>> +                       pic32_uart_type(port));
>> +               goto out_done;
>> +       }
>> +
>> +       sport->irq_rx_name = kasprintf(GFP_KERNEL, "%s%d-rx",
>> +                                      pic32_uart_type(port),
>> +                                      sport->idx);
>> +       irq_set_status_flags(sport->irq_rx, IRQ_NOAUTOEN);
>> +       ret = request_irq(sport->irq_rx, pic32_uart_rx_interrupt,
>> +                         sport->irqflags_rx, sport->irq_rx_name, port);
>> +       if (ret) {
>> +               dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
>> +                       __func__, sport->irq_rx, ret,
>> +                       pic32_uart_type(port));
>> +               goto out_done;
>> +       }
>> +
>> +       sport->irq_tx_name = kasprintf(GFP_KERNEL, "%s%d-tx",
>> +                                      pic32_uart_type(port),
>> +                                      sport->idx);
>> +       irq_set_status_flags(sport->irq_tx, IRQ_NOAUTOEN);
>> +       ret = request_irq(sport->irq_tx, pic32_uart_tx_interrupt,
>> +                         sport->irqflags_tx, sport->irq_tx_name, port);
>> +       if (ret) {
>> +               dev_err(port->dev, "%s: request irq(%d) err! ret:%d name:%s\n",
>> +                       __func__, sport->irq_tx, ret,
>> +                       pic32_uart_type(port));
>> +               goto out_done;
>> +       }
>> +
>> +       local_irq_save(flags);
>> +
>> +       /* set rx interrupt on first receive */
>> +       pic32_uart_rclr(PIC32_UART_STA_URXISEL1 | PIC32_UART_STA_URXISEL0,
>> +                                                       sport, PIC32_UART_STA);
>> +
>> +       /* set interrupt on empty */
>> +       pic32_uart_rclr(PIC32_UART_STA_UTXISEL1, sport, PIC32_UART_STA);
>> +
>> +       /* enable all interrupts and eanable uart */
>> +       pic32_uart_en_and_unmask(port);
>> +
>> +       enable_irq(sport->irq_fault);
>> +       enable_irq(sport->irq_rx);
>> +
>> +out_unlock:
>> +       local_irq_restore(flags);
>> +
>> +out_done:
>> +       return ret;
>> +}
>> +
>> +/* serial core request to flush & disable uart */
>> +static void pic32_uart_shutdown(struct uart_port *port)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +       unsigned long flags;
>> +
>> +       /* disable uart */
>> +       spin_lock_irqsave(&port->lock, flags);
>> +       pic32_uart_dsbl_and_mask(port);
>> +       spin_unlock_irqrestore(&port->lock, flags);
>> +       pic32_disable_clock(sport);
>> +
>> +       /* free all 3 interrupts for this UART */
>> +       free_irq(sport->irq_fault, port);
>> +       free_irq(sport->irq_tx, port);
>> +       free_irq(sport->irq_rx, port);
>> +}
>> +
>> +/* serial core request to change current uart setting */
>> +static void pic32_uart_set_termios(struct uart_port *port,
>> +                                  struct ktermios *new,
>> +                                  struct ktermios *old)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +       unsigned int baud;
>> +       unsigned int quot;
>> +       unsigned long flags;
>> +
>> +       spin_lock_irqsave(&port->lock, flags);
>> +
>> +       /* disable uart and mask all interrupts while changing speed */
>> +       pic32_uart_dsbl_and_mask(port);
>> +
>> +       /* stop bit options */
>> +       if (new->c_cflag & CSTOPB)
>> +               pic32_uart_rset(PIC32_UART_MODE_STSEL, sport, PIC32_UART_MODE);
>> +       else
>> +               pic32_uart_rclr(PIC32_UART_MODE_STSEL, sport, PIC32_UART_MODE);
>> +
>> +       /* parity options */
>> +       if (new->c_cflag & PARENB) {
>> +               if (new->c_cflag & PARODD) {
>> +                       pic32_uart_rset(PIC32_UART_MODE_PDSEL1, sport,
>> +                                       PIC32_UART_MODE);
>> +                       pic32_uart_rclr(PIC32_UART_MODE_PDSEL0, sport,
>> +                                       PIC32_UART_MODE);
>> +               } else {
>> +                       pic32_uart_rset(PIC32_UART_MODE_PDSEL0, sport,
>> +                                       PIC32_UART_MODE);
>> +                       pic32_uart_rclr(PIC32_UART_MODE_PDSEL1, sport,
>> +                                       PIC32_UART_MODE);
>> +               }
>> +       } else {
>> +               pic32_uart_rclr(PIC32_UART_MODE_PDSEL1 | PIC32_UART_MODE_PDSEL0,
>> +                               sport, PIC32_UART_MODE);
>> +       }
>> +       /* if hw flow ctrl, then the pins must be specified in device tree */
>> +       if ((new->c_cflag & CRTSCTS) && sport->hw_flow_ctrl) {
>> +               /* enable hardware flow control */
>> +               pic32_uart_rset(PIC32_UART_MODE_UEN1, sport, PIC32_UART_MODE);
>> +               pic32_uart_rclr(PIC32_UART_MODE_UEN0, sport, PIC32_UART_MODE);
>> +               pic32_uart_rclr(PIC32_UART_MODE_RTSMD, sport, PIC32_UART_MODE);
>> +       } else {
>> +               /* disable hardware flow control */
>> +               pic32_uart_rclr(PIC32_UART_MODE_UEN1, sport, PIC32_UART_MODE);
>> +               pic32_uart_rclr(PIC32_UART_MODE_UEN0, sport, PIC32_UART_MODE);
>> +               pic32_uart_rclr(PIC32_UART_MODE_RTSMD, sport, PIC32_UART_MODE);
>> +       }
>> +
>> +       /* update baud */
>> +       baud = uart_get_baud_rate(port, new, old, 0, port->uartclk / 16);
>> +       quot = uart_get_divisor(port, baud) - 1;
>> +       pic32_uart_write(quot, sport, PIC32_UART_BRG);
>> +       uart_update_timeout(port, new->c_cflag, baud);
>> +
>> +       /* enable uart */
>> +       pic32_uart_en_and_unmask(port);
>> +
>> +       spin_unlock_irqrestore(&port->lock, flags);
>> +}
>> +
>> +/* serial core request to claim uart iomem */
>> +static int pic32_uart_request_port(struct uart_port *port)
>> +{
>> +       struct platform_device *pdev = to_platform_device(port->dev);
>> +       struct resource *res_mem;
>> +       unsigned int res_size;
>> +
>> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (unlikely(!res_mem))
>> +               return -EINVAL;
>> +       res_size = resource_size(res_mem);
>> +
>> +       if (!request_mem_region(port->mapbase, res_size, "pic32_uart_mem")) {
>> +               dev_err(port->dev, "Memory region busy\n");
>
> Looks a bit useless, return code will be converted to Resource is busy
> in userspace.

Ok. Will remove.

>
>> +               return -EBUSY;
>> +       }
>> +
>> +       port->membase = devm_ioremap_nocache(port->dev,
>> +                                            port->mapbase, res_size);
>
>> +       if (!port->membase) {
>> +               dev_err(port->dev, "Unable to map registers\n");
>> +               release_mem_region(port->mapbase, res_size);
>> +               return -ENOMEM;
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>> +/* serial core request to release uart iomem */
>> +static void pic32_uart_release_port(struct uart_port *port)
>> +{
>> +       struct platform_device *pdev = to_platform_device(port->dev);
>> +       struct resource *res_mem;
>> +       unsigned int res_size;
>> +
>> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (unlikely(!res_mem))
>> +               return;
>> +       res_size = resource_size(res_mem);
>> +
>> +       release_mem_region(port->mapbase, res_size);
>> +       devm_iounmap(port->dev, port->membase);
>
> And why do you need to do this explicitly?

Don't. Will remove.

>
>> +}
>> +
>> +/* serial core request to do any port required auto-configuration */
>> +static void pic32_uart_config_port(struct uart_port *port, int flags)
>> +{
>> +       if (flags & UART_CONFIG_TYPE) {
>> +               if (pic32_uart_request_port(port))
>> +                       return;
>> +               port->type = PORT_PIC32;
>> +       }
>> +}
>> +
>> +/* serial core request to check that port information in serinfo are suitable */
>> +static int pic32_uart_verify_port(struct uart_port *port,
>> +                                 struct serial_struct *serinfo)
>> +{
>> +       if (port->type != PORT_PIC32)
>> +               return -EINVAL;
>> +       if (port->irq != serinfo->irq)
>> +               return -EINVAL;
>> +       if (port->iotype != serinfo->io_type)
>> +               return -EINVAL;
>> +       if (port->mapbase != (unsigned long)serinfo->iomem_base)
>> +               return -EINVAL;
>> +
>> +       return 0;
>> +}
>> +
>> +/* serial core callbacks */
>> +static const struct uart_ops pic32_uart_ops = {
>> +       .tx_empty       = pic32_uart_tx_empty,
>> +       .get_mctrl      = pic32_uart_get_mctrl,
>> +       .set_mctrl      = pic32_uart_set_mctrl,
>> +       .start_tx       = pic32_uart_start_tx,
>> +       .stop_tx        = pic32_uart_stop_tx,
>> +       .stop_rx        = pic32_uart_stop_rx,
>> +       .break_ctl      = pic32_uart_break_ctl,
>> +       .startup        = pic32_uart_startup,
>> +       .shutdown       = pic32_uart_shutdown,
>> +       .set_termios    = pic32_uart_set_termios,
>> +       .type           = pic32_uart_type,
>> +       .release_port   = pic32_uart_release_port,
>> +       .request_port   = pic32_uart_request_port,
>> +       .config_port    = pic32_uart_config_port,
>> +       .verify_port    = pic32_uart_verify_port,
>> +};
>> +
>> +#ifdef CONFIG_SERIAL_PIC32_CONSOLE
>> +/* output given char */
>> +static void pic32_console_putchar(struct uart_port *port, int ch)
>> +{
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +
>> +       if (!(pic32_uart_read(sport, PIC32_UART_MODE) & PIC32_UART_MODE_ON))
>> +               return;
>> +
>> +       if (!(pic32_uart_read(sport, PIC32_UART_STA) & PIC32_UART_STA_UTXEN))
>> +               return;
>> +
>> +       /* wait for tx empty */
>> +       while (!(pic32_uart_read(sport, PIC32_UART_STA) & PIC32_UART_STA_TRMT))
>> +               udelay(1);
>> +
>> +       pic32_uart_write(ch & 0xff, sport, PIC32_UART_TX);
>> +}
>> +
>> +/* console core request to output given string */
>> +static void pic32_console_write(struct console *co, const char *s,
>> +                               unsigned int count)
>> +{
>> +       struct pic32_sport *sport = pic32_sports[co->index];
>> +       struct uart_port *port = pic32_get_port(sport);
>> +
>> +       /* call uart helper to deal with \r\n */
>> +       uart_console_write(port, s, count, pic32_console_putchar);
>> +}
>> +
>> +/* console core request to setup given console, find matching uart
>> + * port and setup it.
>> + */
>> +static int pic32_console_setup(struct console *co, char *options)
>> +{
>> +       struct pic32_sport *sport;
>> +       struct uart_port *port = NULL;
>> +       int baud = 115200;
>> +       int bits = 8;
>> +       int parity = 'n';
>> +       int flow = 'n';
>> +       int ret = 0;
>> +
>> +       if (unlikely(co->index < 0 || co->index >= PIC32_MAX_UARTS))
>> +               return -ENODEV;
>> +
>> +       sport = pic32_sports[co->index];
>> +       if (!sport)
>> +               return -ENODEV;
>> +       port = pic32_get_port(sport);
>> +
>> +       ret = pic32_enable_clock(sport);
>> +       if (ret)
>> +               return ret;
>> +
>> +       if (options)
>> +               uart_parse_options(options, &baud, &parity, &bits, &flow);
>> +
>> +       return uart_set_options(port, co, baud, parity, bits, flow);
>> +}
>> +
>> +static struct uart_driver pic32_uart_driver;
>> +static struct console pic32_console = {
>> +       .name           = PIC32_SDEV_NAME,
>> +       .write          = pic32_console_write,
>> +       .device         = uart_console_device,
>> +       .setup          = pic32_console_setup,
>> +       .flags          = CON_PRINTBUFFER,
>> +       .index          = -1,
>> +       .data           = &pic32_uart_driver,
>> +};
>> +#define PIC32_SCONSOLE (&pic32_console)
>> +
>> +static int __init pic32_console_init(void)
>> +{
>> +       register_console(&pic32_console);
>> +       return 0;
>> +}
>> +console_initcall(pic32_console_init);
>> +
>> +static inline bool is_pic32_console_port(struct uart_port *port)
>> +{
>> +       return (port->cons && port->cons->index == port->line);
>
> Useless parens.

Ack.

>
>> +}
>> +
>> +/*
>> + * Late console initialization.
>> + */
>> +static int __init pic32_late_console_init(void)
>> +{
>> +       if (!(pic32_console.flags & CON_ENABLED))
>> +               register_console(&pic32_console);
>> +
>> +       return 0;
>> +}
>> +
>> +core_initcall(pic32_late_console_init);
>> +
>> +#else
>> +#define PIC32_SCONSOLE NULL
>> +#endif
>> +
>> +static struct uart_driver pic32_uart_driver = {
>> +       .owner                  = THIS_MODULE,
>> +       .driver_name            = PIC32_DEV_NAME,
>> +       .dev_name               = PIC32_SDEV_NAME,
>> +       .major                  = PIC32_SDEV_MAJOR,
>> +       .minor                  = PIC32_SDEV_MINOR,
>> +       .nr                     = PIC32_MAX_UARTS,
>> +       .cons                   = PIC32_SCONSOLE,
>> +};
>> +
>> +static int pic32_uart_probe(struct platform_device *pdev)
>> +{
>> +       struct device_node *np = pdev->dev.of_node;
>> +       struct pic32_sport *sport;
>> +       int uart_idx = 0;
>> +       struct resource *res_mem;
>> +       struct uart_port *port;
>
>> +       int ret = 0;
>
> Unneeded assignment.

Ack.

>
>> +
>> +       uart_idx = of_alias_get_id(np, "serial");
>> +       if (uart_idx < 0 || uart_idx >= PIC32_MAX_UARTS)
>> +               return -EINVAL;
>> +
>> +       res_mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>> +       if (!res_mem)
>> +               return -EINVAL;
>> +
>> +       sport = devm_kzalloc(&pdev->dev, sizeof(*sport), GFP_KERNEL);
>> +       if (!sport)
>> +               return -ENOMEM;
>> +
>> +       sport->idx              = uart_idx;
>> +       sport->irq_fault        = irq_of_parse_and_map(np, 0);
>> +       sport->irqflags_fault   = IRQF_NO_THREAD;
>> +       sport->irq_rx           = irq_of_parse_and_map(np, 1);
>> +       sport->irqflags_rx      = IRQF_NO_THREAD;
>> +       sport->irq_tx           = irq_of_parse_and_map(np, 2);
>> +       sport->irqflags_tx      = IRQF_NO_THREAD;
>> +       sport->clk              = devm_clk_get(&pdev->dev, NULL);
>> +       sport->cts_gpio         = -EINVAL;
>> +       sport->dev              = &pdev->dev;
>> +
>> +       ret = pic32_enable_clock(sport);
>> +       if (ret) {
>> +               dev_err(&pdev->dev, "clk enable ?\n");
>> +               goto err;
>> +       }
>> +
>> +       /* Hardware flow control: gpios
>> +        * !Note: Basically, CTS is needed for reading the status.
>> +        */
>> +       sport->hw_flow_ctrl = false;
>> +       sport->cts_gpio = of_get_named_gpio(np, "cts-gpios", 0);
>> +       if (gpio_is_valid(sport->cts_gpio)) {
>> +               sport->hw_flow_ctrl = true;
>> +
>> +               ret = devm_gpio_request(sport->dev,
>> +                                       sport->cts_gpio, "CTS");
>> +               if (ret) {
>> +                       dev_err(&pdev->dev,
>> +                               "error requesting CTS GPIO\n");
>> +                       goto err_disable_clk;
>> +               }
>> +
>> +               ret = gpio_direction_input(sport->cts_gpio);
>> +               if (ret) {
>> +                       dev_err(&pdev->dev, "error setting CTS GPIO\n");
>> +                       goto err_disable_clk;
>> +               }
>> +       }
>> +
>> +       pic32_sports[uart_idx] = sport;
>> +       port = &sport->port;
>> +       memset(port, 0, sizeof(*port));
>> +       port->iotype    = UPIO_MEM;
>> +       port->mapbase   = res_mem->start;
>> +       port->ops       = &pic32_uart_ops;
>> +       port->flags     = UPF_BOOT_AUTOCONF;
>> +       port->dev       = &pdev->dev;
>> +       port->fifosize  = PIC32_UART_TX_FIFO_DEPTH;
>> +       port->uartclk   = clk_get_rate(sport->clk);
>> +       port->line      = uart_idx;
>> +
>> +       ret = uart_add_one_port(&pic32_uart_driver, port);
>> +       if (ret) {
>> +               port->membase = NULL;
>> +               dev_err(port->dev, "%s: uart add port error!\n", __func__);
>> +               goto err_disable_clk;
>> +       }
>> +
>> +#ifdef CONFIG_SERIAL_PIC32_CONSOLE
>> +       if (is_pic32_console_port(port) &&
>> +           (pic32_console.flags & CON_ENABLED)) {
>> +               /* The peripheral clock has been enabled by console_setup,
>> +                * so disable it till the port is used.
>> +                */
>> +               pic32_disable_clock(sport);
>
> (1)
>
>> +       }
>> +#endif
>> +
>> +       platform_set_drvdata(pdev, port);
>> +
>> +       dev_info(&pdev->dev, "%s: uart(%d) driver initialized.\n",
>> +                __func__, uart_idx);
>> +       ret = 0;
>> +
>
> (2)
>
>> +err_disable_clk:
>> +       /* disable clock till the port is used. */
>> +       pic32_disable_clock(sport);
>
> (3) double disable clock call?

Good catch. This will be fixed in the next patch set.

>
>> +err:
>> +       /* automatic unroll of sport and gpios */
>> +       return ret;
>> +}
>> +
>> +static int pic32_uart_remove(struct platform_device *pdev)
>> +{
>> +       struct uart_port *port = platform_get_drvdata(pdev);
>> +       struct pic32_sport *sport = to_pic32_sport(port);
>> +
>> +       uart_remove_one_port(&pic32_uart_driver, port);
>> +       pic32_disable_clock(sport);
>> +       platform_set_drvdata(pdev, NULL);
>> +       pic32_sports[sport->idx] = NULL;
>> +
>> +       /* automatic unroll of sport and gpios */
>> +       return 0;
>> +}
>> +
>> +static const struct of_device_id pic32_serial_dt_ids[] = {
>> +       { .compatible = "microchip,pic32mzda-uart" },
>> +       { /* sentinel */ }
>> +};
>> +MODULE_DEVICE_TABLE(of, pic32_serial_dt_ids);
>> +
>> +static struct platform_driver pic32_uart_platform_driver = {
>> +       .probe          = pic32_uart_probe,
>> +       .remove         = pic32_uart_remove,
>> +       .driver         = {
>> +               .name   = PIC32_DEV_NAME,
>
>> +               .owner  = THIS_MODULE,
>
> Shouldn't core set this?

Yes. Will remove.

>
>> +               .of_match_table = of_match_ptr(pic32_serial_dt_ids),
>> +       },
>> +};
>> +
>> +static int __init pic32_uart_init(void)
>> +{
>> +       int ret;
>> +
>> +       ret = uart_register_driver(&pic32_uart_driver);
>> +       if (ret) {
>> +               pr_err("failed to register %s:%d\n",
>> +                      pic32_uart_driver.driver_name, ret);
>> +               return ret;
>> +       }
>> +
>> +       ret = platform_driver_register(&pic32_uart_platform_driver);
>> +       if (ret) {
>> +               pr_err("fail to register pic32 uart\n");
>> +               uart_unregister_driver(&pic32_uart_driver);
>> +       }
>> +
>> +       return ret;
>> +}
>> +arch_initcall(pic32_uart_init);
>> +
>> +static void __exit pic32_uart_exit(void)
>> +{
>> +#ifdef CONFIG_SERIAL_PIC32_CONSOLE
>> +       unregister_console(&pic32_console);
>> +#endif
>> +       platform_driver_unregister(&pic32_uart_platform_driver);
>> +       uart_unregister_driver(&pic32_uart_driver);
>> +}
>> +module_exit(pic32_uart_exit);
>> +
>> +MODULE_AUTHOR("Steve Scott <steve.scott@microchip.com>");
>> +MODULE_DESCRIPTION("Microchip PIC32 integrated serial port driver");
>> +MODULE_LICENSE("GPL v2");
>> diff --git a/drivers/tty/serial/pic32_uart.h b/drivers/tty/serial/pic32_uart.h
>> new file mode 100644
>> index 0000000..b2f6960
>> --- /dev/null
>> +++ b/drivers/tty/serial/pic32_uart.h
>> @@ -0,0 +1,198 @@
>> +/*
>> + * PIC32 Integrated Serial Driver.
>> + *
>> + * Copyright (C) 2015 Microchip Technology, Inc.
>> + *
>> + * Authors:
>> + *   Sorin-Andrei Pistirica <andrei.pistirica@microchip.com>
>> + *
>> + * Licensed under GPLv2 or later.
>> + */
>> +#ifndef __DT_PIC32_UART_H__
>> +#define __DT_PIC32_UART_H__
>> +
>> +#define PIC32_UART_DFLT_BRATE          (9600)
>> +#define PIC32_UART_TX_FIFO_DEPTH       (8)
>> +#define PIC32_UART_RX_FIFO_DEPTH       (8)
>> +
>> +struct pic32_console_opt {
>> +       int baud;
>> +       int parity;
>> +       int bits;
>> +       int flow;
>> +};
>
> + empty line

Ack.

>
>> +/* struct pic32_sport - pic32 serial port descriptor
>
> /**
>
>> + * @port: uart port descriptor
>> + * @idx: port index
>> + * @irq_fault: virtual fault interrupt number
>> + * @irqflags_fault: flags related to fault irq
>> + * @irq_fault_name: irq fault name
>> + * @irq_rx: virtual rx interrupt number
>> + * @irqflags_rx: flags related to rx irq
>> + * @irq_rx_name: irq rx name
>> + * @irq_tx: virtual tx interrupt number
>> + * @irqflags_tx: : flags related to tx irq
>> + * @irq_tx_name: irq tx name
>> + * @cts_gpio: clear to send gpio
>> + * @dev: device descriptor
>> + **/
>> +struct pic32_sport {
>> +       struct uart_port port;
>> +       struct pic32_console_opt opt;
>> +       int idx;
>> +
>> +       int irq_fault;
>> +       int irqflags_fault;
>> +       const char *irq_fault_name;
>> +       int irq_rx;
>> +       int irqflags_rx;
>> +       const char *irq_rx_name;
>> +       int irq_tx;
>> +       int irqflags_tx;
>> +       const char *irq_tx_name;
>> +       u8 enable_tx_irq;
>> +
>> +       bool hw_flow_ctrl;
>> +       int cts_gpio;
>> +
>> +       int ref_clk;
>> +       struct clk *clk;
>> +
>> +       struct device *dev;
>> +};
>> +#define to_pic32_sport(c) container_of(c, struct pic32_sport, port)
>> +#define pic32_get_port(sport) (&sport->port)
>> +#define pic32_get_opt(sport) (&sport->opt)
>> +#define tx_irq_enabled(sport) (sport->enable_tx_irq)
>> +
>> +struct pic32_reg {
>> +       u32 val;
>> +       u32 clr;
>> +       u32 set;
>> +       u32 inv;
>> +} __packed;
>> +#define PIC32_REGS 4
>> +#define PIC32_REG_SIZE 4
>> +
>> +enum pic32_uart_regs {
>> +       PIC32_UART_UNKNOWN      = 0,
>> +       PIC32_UART_MODE         = 1,
>> +       PIC32_UART_STA          = 2,
>> +       PIC32_UART_TX           = 3,
>> +       PIC32_UART_RX           = 4,
>> +       PIC32_UART_BRG          = 5,
>> +
>> +       /* add above this line */
>> +       PIC32_UART_LAST
>> +};
>> +
>> +/* uart register offsets */
>> +static u32 pic32_uart_lookup_reg[PIC32_UART_LAST] = {
>> +       [PIC32_UART_MODE]       = 0 * PIC32_REGS * PIC32_REG_SIZE,
>> +       [PIC32_UART_STA]        = 1 * PIC32_REGS * PIC32_REG_SIZE,
>> +       [PIC32_UART_TX]         = 2 * PIC32_REGS * PIC32_REG_SIZE,
>> +       [PIC32_UART_RX]         = 3 * PIC32_REGS * PIC32_REG_SIZE,
>> +       [PIC32_UART_BRG]        = 4 * PIC32_REGS * PIC32_REG_SIZE,
>> +};
>> +
>> +static inline void __iomem *pic32_uart_get_reg(struct pic32_sport *sport,
>> +                                              enum pic32_uart_regs reg)
>> +{
>> +       struct uart_port *port = pic32_get_port(sport);
>> +
>> +       return port->membase + pic32_uart_lookup_reg[reg];
>> +}
>> +
>> +static inline u32 pic32_uart_rval(struct pic32_sport *sport,
>> +                                 enum pic32_uart_regs reg)
>> +{
>> +       void __iomem *addr = pic32_uart_get_reg(sport, reg);
>> +       struct pic32_reg __iomem *reg_addr = (struct pic32_reg __iomem *)addr;
>> +
>> +       return readl(&reg_addr->val);
>> +}
>> +
>> +static inline void pic32_uart_rset(u32 val,
>> +                                  struct pic32_sport *sport,
>> +                                  enum pic32_uart_regs reg)
>
> Better to use more logical way for this, i.e.
> (sport, regs, value)
>
> Same for below.

The way the registers are accessed will be reworked and simplified for 
the next patch set. There will be a single read and single write function.

>
>> +{
>> +       void __iomem *addr = pic32_uart_get_reg(sport, reg);
>> +       struct pic32_reg __iomem *reg_addr = (struct pic32_reg __iomem *)addr;
>
> struct pic32_reg __iomem *reg = pic32_uart_get_reg(sport, regs);
> writel(value, &reg->set);
>
> looks much better, does it?
>
>> +
>> +       writel(val, &reg_addr->set);
>> +}
>> +
>> +static inline void pic32_uart_rclr(u32 val,
>> +                                  struct pic32_sport *sport,
>> +                                  enum pic32_uart_regs reg)
>> +{
>> +       void __iomem *addr = pic32_uart_get_reg(sport, reg);
>> +       struct pic32_reg __iomem *reg_addr = (struct pic32_reg __iomem *)addr;
>> +
>> +       writel(val, &reg_addr->clr);
>> +}
>> +
>> +static inline void pic32_uart_rinv(u32 val,
>> +                                  struct pic32_sport *sport,
>> +                                  enum pic32_uart_regs reg)
>> +{
>> +       void __iomem *addr = pic32_uart_get_reg(sport, reg);
>> +       struct pic32_reg __iomem *reg_addr = (struct pic32_reg __iomem *)addr;
>> +
>> +       writel(val, &reg_addr->inv);
>> +}
>> +
>> +static inline void pic32_uart_write(u32 val,
>> +                                   struct pic32_sport *sport,
>> +                                   enum pic32_uart_regs reg)
>> +{
>> +       void __iomem *addr = pic32_uart_get_reg(sport, reg);
>> +
>> +       writel(val, addr);
>> +}
>> +
>> +static inline u32 pic32_uart_read(struct pic32_sport *sport,
>> +                                 enum pic32_uart_regs reg)
>> +{
>> +       void __iomem *addr = pic32_uart_get_reg(sport, reg);
>> +
>> +       return readl(addr);
>> +}
>> +
>> +/* pic32 uart mode register bits */
>> +#define PIC32_UART_MODE_ON        (1 << 15)
>
> BIT() ?

Ack.

>
>> +#define PIC32_UART_MODE_FRZ       (1 << 14)
>> +#define PIC32_UART_MODE_SIDL      (1 << 13)
>> +#define PIC32_UART_MODE_IREN      (1 << 12)
>> +#define PIC32_UART_MODE_RTSMD     (1 << 11)
>> +#define PIC32_UART_MODE_RESV1     (1 << 10)
>> +#define PIC32_UART_MODE_UEN1      (1 << 9)
>> +#define PIC32_UART_MODE_UEN0      (1 << 8)
>> +#define PIC32_UART_MODE_WAKE      (1 << 7)
>> +#define PIC32_UART_MODE_LPBK      (1 << 6)
>> +#define PIC32_UART_MODE_ABAUD     (1 << 5)
>> +#define PIC32_UART_MODE_RXINV     (1 << 4)
>> +#define PIC32_UART_MODE_BRGH      (1 << 3)
>> +#define PIC32_UART_MODE_PDSEL1    (1 << 2)
>> +#define PIC32_UART_MODE_PDSEL0    (1 << 1)
>> +#define PIC32_UART_MODE_STSEL     (1 << 0)
>> +
>> +/* pic32 uart status register bits */
>> +#define PIC32_UART_STA_UTXISEL1   (1 << 15)
>> +#define PIC32_UART_STA_UTXISEL0   (1 << 14)
>> +#define PIC32_UART_STA_UTXINV     (1 << 13)
>> +#define PIC32_UART_STA_URXEN      (1 << 12)
>> +#define PIC32_UART_STA_UTXBRK     (1 << 11)
>> +#define PIC32_UART_STA_UTXEN      (1 << 10)
>> +#define PIC32_UART_STA_UTXBF      (1 << 9)
>> +#define PIC32_UART_STA_TRMT       (1 << 8)
>> +#define PIC32_UART_STA_URXISEL1   (1 << 7)
>> +#define PIC32_UART_STA_URXISEL0   (1 << 6)
>> +#define PIC32_UART_STA_ADDEN      (1 << 5)
>> +#define PIC32_UART_STA_RIDLE      (1 << 4)
>> +#define PIC32_UART_STA_PERR       (1 << 3)
>> +#define PIC32_UART_STA_FERR       (1 << 2)
>> +#define PIC32_UART_STA_OERR       (1 << 1)
>> +#define PIC32_UART_STA_URXDA      (1 << 0)
>> +
>> +#endif /* __DT_PIC32_UART_H__ */
>> diff --git a/include/uapi/linux/serial_core.h b/include/uapi/linux/serial_core.h
>> index 93ba148..9df0a98 100644
>> --- a/include/uapi/linux/serial_core.h
>> +++ b/include/uapi/linux/serial_core.h
>> @@ -261,4 +261,7 @@
>>   /* STM32 USART */
>>   #define PORT_STM32     113
>>
>> +/* Microchip PIC32 UART */
>> +#define PORT_PIC32     114
>> +
>>   #endif /* _UAPILINUX_SERIAL_CORE_H */
>> --
>> 1.7.9.5

Thanks,
Paul
