Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Oct 2004 22:37:56 +0000 (GMT)
Received: from quechua.inka.de ([IPv6:::ffff:193.197.184.2]:44674 "EHLO
	mail.inka.de") by linux-mips.org with ESMTP id <S8225213AbUJaWhu>;
	Sun, 31 Oct 2004 22:37:50 +0000
Received: from pcde.inka.de (uucp@[127.0.0.1])
	by mail.inka.de with uucp (rmailwrap 0.5) 
	id 1COOKa-0004VG-00; Sun, 31 Oct 2004 23:37:48 +0100
Received: by aton.pcde.inka.de (Postfix, from userid 1001)
	id 6F1BF1E5C7; Sun, 31 Oct 2004 23:36:12 +0100 (CET)
Date: Sun, 31 Oct 2004 23:36:12 +0100
From: Dennis Grevenstein <dennis@pcde.inka.de>
To: linux-mips@linux-mips.org
Subject: Re: unable to handle kernel paging request
Message-ID: <20041031223612.GA15091@aton.pcde.inka.de>
References: <20041031184233.GA11120@aton.pcde.inka.de> <Pine.GSO.4.10.10410311947570.9753-100000@helios.et.put.poznan.pl> <20041031191631.GB11681@aton.pcde.inka.de> <20041031192653.GG2094@lug-owl.de> <20041031195550.GA12397@aton.pcde.inka.de> <20041031201335.GH2094@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041031201335.GH2094@lug-owl.de>
User-Agent: Mutt/1.4.2.1i
Return-Path: <dennis@pcde.inka.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dennis@pcde.inka.de
Precedence: bulk
X-list: linux-mips

On Sun, Oct 31, 2004 at 09:13:35PM +0100, Jan-Benedict Glaw wrote:
> 
> So now, find out what v0 belongs to. Maybe compiling the kernel with
> debug infos (-g) and using objdump -S (for intermixing sources) will
> help you.

recompiling the kernel will take another few hours, but
I may try later. Using "objdump -S" I don't get any more info.

Building a kernel without the driver for the serial port 
seems not so good for a Challenge S.
 
> "objdump -S" for starters, but it seems quite straight forward. Maybe
> paste the code of ip22zilog_receive_chars, I don't  have that at hands
> right now...
 
Okay, here it is:

static void ip22zilog_receive_chars(struct uart_ip22zilog_port *up,
                                   struct zilog_channel *channel,
                                   struct pt_regs *regs)
{
        struct tty_struct *tty = up->port.info->tty;    /* XXX info==NULL? */

        while (1) {
                unsigned char ch, r1;

                if (unlikely(tty->flip.count >= TTY_FLIPBUF_SIZE)) {
                        tty->flip.work.func((void *)tty);
                        if (tty->flip.count >= TTY_FLIPBUF_SIZE)
                                return;         /* XXX Ignores SysRq when we nee
d it most. Fix. */
                }

                r1 = read_zsreg(channel, R1);
                if (r1 & (PAR_ERR | Rx_OVR | CRC_ERR)) {
                        writeb(ERR_RES, &channel->control);
                        ZSDELAY();
                        ZS_WSYNC(channel);
                }

                ch = readb(&channel->control);
                ZSDELAY();

                /* This funny hack depends upon BRK_ABRT not interfering
                 * with the other bits we care about in R1.
                 */
                if (ch & BRK_ABRT)
                        r1 |= BRK_ABRT;

                ch = readb(&channel->data);
                ZSDELAY();

                ch &= up->parity_mask;

                if (ZS_IS_CONS(up) && (r1 & BRK_ABRT)) {
                        /* Wait for BREAK to deassert to avoid potentially
                         * confusing the PROM.
                         */
                        while (1) {
                                ch = readb(&channel->control);
                                ZSDELAY();
                                if (!(ch & BRK_ABRT))
                                        break;
                        }
                        ip22_do_break();
                        return;
                }

                /* A real serial line, record the character and status.  */
                *tty->flip.char_buf_ptr = ch;
                *tty->flip.flag_buf_ptr = TTY_NORMAL;
                up->port.icount.rx++;
                if (r1 & (BRK_ABRT | PAR_ERR | Rx_OVR | CRC_ERR)) {
                        if (r1 & BRK_ABRT) {
                                r1 &= ~(PAR_ERR | CRC_ERR);
                                up->port.icount.brk++;
                                if (uart_handle_break(&up->port))
                                        goto next_char;
                        }
                        else if (r1 & PAR_ERR)
                                up->port.icount.parity++;
                        else if (r1 & CRC_ERR)
                                up->port.icount.frame++;
                        if (r1 & Rx_OVR)
                                up->port.icount.overrun++;
                        r1 &= up->port.read_status_mask;
                        if (r1 & BRK_ABRT)
                                *tty->flip.flag_buf_ptr = TTY_BREAK;
                        else if (r1 & PAR_ERR)
                                *tty->flip.flag_buf_ptr = TTY_PARITY;
                        else if (r1 & CRC_ERR)
                                *tty->flip.flag_buf_ptr = TTY_FRAME;
                }
                if (uart_handle_sysrq_char(&up->port, ch, regs))
                        goto next_char;

                if (up->port.ignore_status_mask == 0xff ||
                    (r1 & up->port.ignore_status_mask) == 0) {
                        tty->flip.flag_buf_ptr++;
                        tty->flip.char_buf_ptr++;
                        tty->flip.count++;
                }
                if ((r1 & Rx_OVR) &&
                    tty->flip.count < TTY_FLIPBUF_SIZE) {
                        *tty->flip.flag_buf_ptr = TTY_OVERRUN;
                        tty->flip.flag_buf_ptr++;
                        tty->flip.char_buf_ptr++;
                        tty->flip.count++;
                }
        next_char:
                ch = readb(&channel->control);
                ZSDELAY();
                if (!(ch & Rx_CH_AV))
                        break;
        }

        tty_flip_buffer_push(tty);
}


mfg
Dennis

-- 
There is certainly no purpose in remaining in the dark
except long enough to clear from the mind
the illusion of ever having been in the light.
                                        T.S. Eliot
