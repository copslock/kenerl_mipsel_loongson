Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2002 04:25:04 +0100 (CET)
Received: from p508B4A7D.dip.t-dialin.net ([80.139.74.125]:41424 "EHLO
	p508B4A7D.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1121744AbSKTDZD>; Wed, 20 Nov 2002 04:25:03 +0100
Received: from c135.h203149222.is.net.tw ([IPv6:::ffff:203.149.222.135]:31952
	"EHLO ms.gv.com.tw") by ralf.linux-mips.org with ESMTP
	id <S868489AbSKTDSy>; Wed, 20 Nov 2002 04:18:54 +0100
Received: from jmt (IDENT:root@[172.16.1.11])
	by ms.gv.com.tw (8.11.2/8.11.2) with SMTP id gAK3SxO09178;
	Wed, 20 Nov 2002 11:28:59 +0800
Message-ID: <00ba01c29044$707cd400$df0210ac@gv.com.tw>
From: "??" <kevin@gv.com.tw>
To: "Jun Sun" <jsun@mvista.com>
Cc: "Ralf Baechle" <ralf@linux-mips.org>, "Fang Li" <fanky@gv.com.tw>,
	<linux-mips@linux-mips.org>
References: <20021118144212.A12262@linux-mips.org> <00a901c28fc4$76ace700$df0210ac@gv.com.tw> <20021119132922.A15266@linux-mips.org> <20021119095444.C18134@mvista.com>
Subject: Re: usb hotplug function with linux mips kernel
Date: Wed, 20 Nov 2002 11:25:13 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 1
X-MSMail-Priority: High
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Return-Path: <kevin@gv.com.tw>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin@gv.com.tw
Precedence: bulk
X-list: linux-mips

dear jun,
do you have the patch to fix "non-coherent MIPS cache"?
thanks in advanced!:)

and thanks you all who reply to this so quickly:)
btw, i don't mean usb not function with linux mips kernel
i mean using the "hotplug"-usb
support(http://linux-hotplug.sourceforge.net/?selected=usb) with linux mips
kernel

for example, after we plug in usb cable with a mips board,
the mips kernel try to execute "/sbin/hotplug" shell script,
then kernel wait_for_complete() for "/sbin/hotplug" with spin_lock_irq(),
the do_execve() of "/sbin/hotplug" return 0(successfully),
however, wait_for_complete() never return,
then kernel is reseted by hardware watchdog(timeout 3 secs)

we already trace this problem over a month,
but still can't figure out is it a userland
problem(cross-compiler/shell(bash))
or a problem with linux mips kernel

best regards,

----- Original Message -----
From: "Jun Sun" <jsun@mvista.com>
To: "Ralf Baechle" <ralf@linux-mips.org>
Cc: "??" <kevin@gv.com.tw>; <linux-mips@linux-mips.org>; <jsun@mvista.com>
Sent: Wednesday, November 20, 2002 1:54 AM
Subject: Re: usb hotplug function with linux mips kernel


> On Tue, Nov 19, 2002 at 01:29:22PM +0100, Ralf Baechle wrote:
> > Hello double questionmark ;-)
> >
> > On Tue, Nov 19, 2002 at 08:09:07PM +0800, ?? wrote:
> >
> > > anyone successfully using usb hotplug function with linux mips kernel?
> > >
> > >
http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=102954820511328&w=2
> >
> > There is nothing in the USB code that should be MIPS specific.  Despite
> > what Tom suspects everything is fine.  32-bit kernel symbols always
start
> > with 0xffffffff and the value of usbdevfs_cleanup is an artefact of the
> > function having been discarded by the linker.
> >
>
> Additional info:
>
> USB has been working on MIPS for well over a year now.  There was a
problem
> early on due to non-coherent MIPS cache, but it was solved back then.
>
> We have been using USB on global span IVR successfully.  Maybe there are
> still some patches missing in linux-mips tree.  I will take a look later.
>
> Jun
