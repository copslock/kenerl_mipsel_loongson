Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:08:42 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.187]:62740 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013487AbaKLJIkyo1VI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:08:40 +0100
Received: from wuerfel.localnet (HSI-KBW-149-172-15-242.hsi13.kabel-badenwuerttemberg.de [149.172.15.242])
        by mrelayeu.kundenserver.de (node=mreue003) with ESMTP (Nemesis)
        id 0MhPvC-1XaogH3S42-00MeHG; Wed, 12 Nov 2014 10:08:24 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Kevin Cernekee <cernekee@gmail.com>, gregkh@linuxfoundation.org,
        robh@kernel.org, tushar.behera@linaro.org, daniel@zonque.org,
        haojian.zhuang@gmail.com, robert.jarzmik@free.fr,
        grant.likely@linaro.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH/RFC 4/8] serial: pxa: Add fifo-size and {big,native}-endian properties
Date:   Wed, 12 Nov 2014 10:08:22 +0100
Message-ID: <1644326.y4vtt1W8M2@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <5463227E.9050304@suse.cz>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com> <1415781993-7755-5-git-send-email-cernekee@gmail.com> <5463227E.9050304@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:QzcqeCfkSfbpg488g9R8bUTqEApdZ6xda7xgc7Ery+T
 qoz9Nu0y+rZX8dmA7vSy9o8jNtZCTNADAnoYO5PtglWVCvIaMD
 549OZ5V5oPx6K9YGMDXEMf/X7tu0Lt6FsbZQKa7oFbI0xhXlbb
 zvoA1YbjclX2R3YOx84eLj1UYeKbMcJwWzTY+N40qX52/CnWur
 Q7bW94i+D0j6RHdkfReXjUx1RDP3OmTMavmI3HcHpkRdgsmuwm
 7ynkOuyabD0kIEnWMP1ePdWXu4bScvZjqrtuEX/o6N/V10dDYX
 Y6gU0GV9sXK+xBnYiCFDyKe6rW1VaMPR3GJtgccfRtVD01Aupk
 GcAIppMCendXPJ/14jtE=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44042
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 12 November 2014 10:03:58 Jiri Slaby wrote:
> On 11/12/2014, 09:46 AM, Kevin Cernekee wrote:
> > With a few tweaks, the PXA serial driver can handle other 16550A clones.
> > Add a fifo-size DT property to override the FIFO depth (BCM7xxx uses 32),
> > and {native,big}-endian properties similar to regmap to support SoCs that
> > have BE or "automagic endian" registers.
> > 
> > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > ---
> >  drivers/tty/serial/pxa.c | 16 ++++++++++++++--
> >  1 file changed, 14 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/tty/serial/pxa.c b/drivers/tty/serial/pxa.c
> > index 21b7d8b..78ed7ee 100644
> > --- a/drivers/tty/serial/pxa.c
> > +++ b/drivers/tty/serial/pxa.c
> > @@ -60,13 +60,19 @@ struct uart_pxa_port {
> >  static inline unsigned int serial_in(struct uart_pxa_port *up, int offset)
> >  {
> >       offset <<= 2;
> > -     return readl(up->port.membase + offset);
> > +     if (!up->port.big_endian)
> > +             return readl(up->port.membase + offset);
> > +     else
> > +             return ioread32be(up->port.membase + offset);
> 
> This needn't fly IMO, unless you map the space using iomap (not ioremap).

For all I know, the ioread family is required to work with tokens returned
from ioremap on all architectures. The difference to readl is that it
also works on tokens returned from ioport_map or one of the wrappers
around it.

	Arnd
