Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Nov 2002 04:50:35 +0100 (CET)
Received: from p508B4A7D.dip.t-dialin.net ([80.139.74.125]:46288 "EHLO
	p508B4A7D.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1121744AbSKTDuf>; Wed, 20 Nov 2002 04:50:35 +0100
Received: from c135.h203149222.is.net.tw ([IPv6:::ffff:203.149.222.135]:11221
	"EHLO ms.gv.com.tw") by ralf.linux-mips.org with ESMTP
	id <S868471AbSKTDo3>; Wed, 20 Nov 2002 04:44:29 +0100
Received: from jmt (IDENT:root@[172.16.1.11])
	by ms.gv.com.tw (8.11.2/8.11.2) with SMTP id gAK3sbO10732;
	Wed, 20 Nov 2002 11:54:37 +0800
Message-ID: <012e01c29048$0551fee0$df0210ac@gv.com.tw>
From: "??" <kevin@gv.com.tw>
To: "Yoichi Yuasa" <yoichi_yuasa@montavista.co.jp>
Cc: <jsun@mvista.com>, <ralf@linux-mips.org>,
	<linux-mips@linux-mips.org>, <ppopov@mvista.com>,
	"Fang Li" <fanky@gv.com.tw>
References: <20021118144212.A12262@linux-mips.org><00a901c28fc4$76ace700$df0210ac@gv.com.tw><20021119132922.A15266@linux-mips.org><20021119095444.C18134@mvista.com><1037729027.17678.112.camel@zeus.mvista.com> <20021120114930.117a78bb.yoichi_yuasa@montavista.co.jp>
Subject: Re: usb hotplug function with linux mips kernel
Date: Wed, 20 Nov 2002 11:50:51 +0800
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
X-archive-position: 676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevin@gv.com.tw
Precedence: bulk
X-list: linux-mips

dear Yoichi,

thanks for your reply & patch
we are using kernel 2.4.18, after reading your patch,

we found there is no following section:
- if (usb_hub_port_debounce(hub, port)) {
-  err("connect-debounce failed, port %d disabled", port+1);
-  usb_hub_port_disable(hub, port);
-  return;
- }

but a following section: (mentioned redhat bug #23670)
>        /* Some low speed devices have problems with the quick delay, so */
>        /*  be a bit pessimistic with those devices. RHbug #23670 */
>       if (portstatus & USB_PORT_STAT_LOW_SPEED) {
>                wait_ms(400);
>                delay = HUB_LONG_RESET_TIME;
>        }

can we safely remove the above section?

best regards,

----- Original Message -----
From: "Yoichi Yuasa" <yoichi_yuasa@montavista.co.jp>
To: <kevin@gv.com.tw>
Cc: <jsun@mvista.com>; <ralf@linux-mips.org>; <linux-mips@linux-mips.org>;
<ppopov@mvista.com>
Sent: Wednesday, November 20, 2002 10:49 AM
Subject: Re: usb hotplug function with linux mips kernel


> Hi,
>
> On 19 Nov 2002 10:03:47 -0800
> Pete Popov <ppopov@mvista.com> wrote:
>
> > On Tue, 2002-11-19 at 09:54, Jun Sun wrote:
> > > On Tue, Nov 19, 2002 at 01:29:22PM +0100, Ralf Baechle wrote:
> > > > Hello double questionmark ;-)
> > > >
> > > > On Tue, Nov 19, 2002 at 08:09:07PM +0800, ?? wrote:
> > > >
> > > > > anyone successfully using usb hotplug function with linux mips
kernel?
> > > > >
> > > > >
http://marc.theaimsgroup.com/?l=linux-hotplug-devel&m=102954820511328&w=2
> > > >
> > > > There is nothing in the USB code that should be MIPS specific.
Despite
> > > > what Tom suspects everything is fine.  32-bit kernel symbols always
start
> > > > with 0xffffffff and the value of usbdevfs_cleanup is an artefact of
the
> > > > function having been discarded by the linker.
> > > >
> > >
> > > Additional info:
> > >
> > > USB has been working on MIPS for well over a year now.  There was a
problem
> > > early on due to non-coherent MIPS cache, but it was solved back then.
> > >
> > > We have been using USB on global span IVR successfully.
> >
> > ... among many other mips boards.
> >
> > > Maybe there are still some patches missing in linux-mips tree.  I will
> > > take a look later.
>
> I don't have a problem with current CVS tree(linux_2_4 tag) and a small
patch.
>
> I tested by the following system.
> Hot plug is fine.
>
> NEC VR4122(Eagle)
> USB OCHI Controller
> SanDisk SDDR-31
> 128MB CF
>
> I attached a small patch.
>
> Yoichi
