Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jan 2014 18:07:02 +0100 (CET)
Received: from hall.aurel32.net ([195.154.112.97]:43310 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6826484AbaAERFxa5Byh (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Jan 2014 18:05:53 +0100
Received: from [2001:470:d4ed:0:ea11:32ff:fea1:831a] (helo=ohm.rr44.fr)
        by hall.aurel32.net with esmtpsa (TLS1.2:DHE_RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vzr95-0006GX-TM; Sun, 05 Jan 2014 18:05:52 +0100
Received: from aurel32 by ohm.rr44.fr with local (Exim 4.80)
        (envelope-from <aurelien@aurel32.net>)
        id 1Vzr93-0004S7-LW; Sun, 05 Jan 2014 18:05:49 +0100
Date:   Sun, 5 Jan 2014 18:05:49 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V15 07/12] MIPS: Loongson 3: Add serial port support
Message-ID: <20140105170549.GA14707@ohm.rr44.fr>
References: <1387109676-540-1-git-send-email-chenhc@lemote.com>
 <1387109676-540-8-git-send-email-chenhc@lemote.com>
 <20140104225441.GA20873@hall.aurel32.net>
 <CAAhV-H55m3B-sVtArQELOeF-TDGRk9j2SQk8o5J7RS5oaD4M7g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAAhV-H55m3B-sVtArQELOeF-TDGRk9j2SQk8o5J7RS5oaD4M7g@mail.gmail.com>
X-Mailer: Mutt 1.5.21 (2010-09-15)
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
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

On Sun, Jan 05, 2014 at 05:37:01PM +0800, Huacai Chen wrote:
> On Sun, Jan 5, 2014 at 6:54 AM, Aurelien Jarno <aurelien@aurel32.net> wrote:
> 
> > On Sun, Dec 15, 2013 at 08:14:31PM +0800, Huacai Chen wrote:
> > > Loongson family machines has three types of serial port: PCI UART, LPC
> > > UART and CPU internal UART. Loongson-2E and parts of Loongson-2F based
> > > machines use PCI UART; most Loongson-2F based machines use LPC UART;
> > > Loongson-2G/3A has both LPC and CPU UART but usually use CPU UART.
> > >
> > > Port address of UARTs:
> > > CPU UART: REG_BASE + OFFSET;
> > > LPC UART: LIO1_BASE + OFFSET;
> > > PCI UART: PCIIO_BASE + OFFSET.
> > >
> > > Since LPC UART are linked in "Local Bus", both CPU UART and LPC UART
> > > are called "CPU provided serial port".
> > >
> > > Signed-off-by: Huacai Chen <chenhc@lemote.com>
> > > Signed-off-by: Hongliang Tao <taohl@lemote.com>
> > > Signed-off-by: Hua Yan <yanh@lemote.com>
> > > ---
> > >  arch/mips/loongson/common/serial.c    |   26 +++++++++++++++-----------
> > >  arch/mips/loongson/common/uart_base.c |    9 ++++++++-
> > >  2 files changed, 23 insertions(+), 12 deletions(-)
> > >
> > > diff --git a/arch/mips/loongson/common/serial.c
> > b/arch/mips/loongson/common/serial.c
> > > index 5f2b78a..bd2b709 100644
> > > --- a/arch/mips/loongson/common/serial.c
> > > +++ b/arch/mips/loongson/common/serial.c
> > > @@ -19,19 +19,19 @@
> > >  #include <loongson.h>
> > >  #include <machine.h>
> > >
> > > -#define PORT(int)                    \
> > > +#define PORT(int, clk)                       \
> > >  {                                                            \
> > >       .irq            = int,                                  \
> > > -     .uartclk        = 1843200,                              \
> > > +     .uartclk        = clk,                                  \
> > >       .iotype         = UPIO_PORT,                            \
> > >       .flags          = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,    \
> > >       .regshift       = 0,                                    \
> > >  }
> > >
> > > -#define PORT_M(int)                          \
> > > +#define PORT_M(int, clk)                             \
> > >  {                                                            \
> > >       .irq            = MIPS_CPU_IRQ_BASE + (int),            \
> > > -     .uartclk        = 3686400,                              \
> > > +     .uartclk        = clk,                                  \
> > >       .iotype         = UPIO_MEM,                             \
> > >       .membase        = (void __iomem *)NULL,                 \
> > >       .flags          = UPF_BOOT_AUTOCONF | UPF_SKIP_TEST,    \
> > > @@ -40,13 +40,17 @@
> > >
> > >  static struct plat_serial8250_port uart8250_data[][2] = {
> > >       [MACH_LOONGSON_UNKNOWN]         {},
> > > -     [MACH_LEMOTE_FL2E]              {PORT(4), {} },
> > > -     [MACH_LEMOTE_FL2F]              {PORT(3), {} },
> > > -     [MACH_LEMOTE_ML2F7]             {PORT_M(3), {} },
> > > -     [MACH_LEMOTE_YL2F89]            {PORT_M(3), {} },
> > > -     [MACH_DEXXON_GDIUM2F10]         {PORT_M(3), {} },
> > > -     [MACH_LEMOTE_NAS]               {PORT_M(3), {} },
> > > -     [MACH_LEMOTE_LL2F]              {PORT(3), {} },
> > > +     [MACH_LEMOTE_FL2E]              {PORT(4, 1843200), {} },
> > > +     [MACH_LEMOTE_FL2F]              {PORT(3, 1843200), {} },
> > > +     [MACH_LEMOTE_ML2F7]             {PORT_M(3, 3686400), {} },
> > > +     [MACH_LEMOTE_YL2F89]            {PORT_M(3, 3686400), {} },
> > > +     [MACH_DEXXON_GDIUM2F10]         {PORT_M(3, 3686400), {} },
> > > +     [MACH_LEMOTE_NAS]               {PORT_M(3, 3686400), {} },
> > > +     [MACH_LEMOTE_LL2F]              {PORT(3, 1843200), {} },
> > > +     [MACH_LEMOTE_A1004]             {PORT_M(2, 33177600), {} },
> > > +     [MACH_LEMOTE_A1101]             {PORT_M(2, 25000000), {} },
> > > +     [MACH_LEMOTE_A1201]             {PORT_M(2, 25000000), {} },
> > > +     [MACH_LEMOTE_A1205]             {PORT_M(2, 25000000), {} },
> > >       [MACH_LOONGSON_END]             {},
> > >  };
> > >
> > > diff --git a/arch/mips/loongson/common/uart_base.c
> > b/arch/mips/loongson/common/uart_base.c
> > > index e192ad0..1e1eeea 100644
> > > --- a/arch/mips/loongson/common/uart_base.c
> > > +++ b/arch/mips/loongson/common/uart_base.c
> > > @@ -35,9 +35,16 @@ void prom_init_loongson_uart_base(void)
> > >       case MACH_DEXXON_GDIUM2F10:
> > >       case MACH_LEMOTE_NAS:
> > >       default:
> > > -             /* The CPU provided serial port */
> > > +             /* The CPU provided serial port (LPC) */
> > >               loongson_uart_base = LOONGSON_LIO1_BASE + 0x3f8;
> > >               break;
> > > +     case MACH_LEMOTE_A1004:
> > > +     case MACH_LEMOTE_A1101:
> > > +     case MACH_LEMOTE_A1201:
> > > +     case MACH_LEMOTE_A1205:
> > > +             /* The CPU provided serial port (CPU) */
> > > +             loongson_uart_base = LOONGSON_REG_BASE + 0x1e0;
> >
> > LOONGSON_REG_BASE corresponds to the value of the 2E machine. I guess
> > the correct value is LOONGSON3_REG_BASE here.
> >
> No,  LOONGSON_REG_BASE is used for all Loongson processors,
> LOONGSON3_REG_BASE is
> used for Loongson-3 specific registers.

Ok, it was not clear to me that LOONGSON_REG_BASE is common to both
Loongson 2 and Loongson 3 and that LOONGSON3_REG_BASE is Loongson 3
specific. Maybe a comment about that might be useful where they are
defined.

> >
> > > +             break;
> > >       }
> > >
> > >       _loongson_uart_base =
> > > --
> > > 1.7.7.3
> > >
> > >
> > >
> >
> > --
> > Aurelien Jarno                          GPG: 1024D/F1BCDB73
> > aurelien@aurel32.net                 http://www.aurel32.net
> >
> >

-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
