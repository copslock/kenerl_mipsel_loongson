Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2003 16:51:18 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:58609 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225397AbTLRQvR>;
	Thu, 18 Dec 2003 16:51:17 +0000
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id IAA26650;
	Thu, 18 Dec 2003 08:51:12 -0800
Message-ID: <3FE1DB05.1020702@mvista.com>
Date: Thu, 18 Dec 2003 08:51:17 -0800
From: Pete Popov <ppopov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.4) Gecko/20030624 Netscape/7.1 (ax)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: samavarthy c <samavarthy@hotmail.com>
CC: linux-mips@linux-mips.org
Subject: Re: USB on MIPS
References: <BAY7-F37p6I65awhyxk00043bd8@hotmail.com>
In-Reply-To: <BAY7-F37p6I65awhyxk00043bd8@hotmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


I haven't worked with that board, but on the AMD/Alchemy boards, the 
same errors have typically been associated with improper setup of the 
usb controller -- usually the clock that is routed internally to the 
controller.

Pete

samavarthy c wrote:

> Hi,
>
> I am working on a PDA based board which has a NEC MIPS VR4131
> processor.
> The board has a companion chip MediaQ 1132 which has OHCI support
> builtin.
> The kernel used is MontaVista HardHat 2.4.18. I am trying to configure
> MQ1132 for USB Host support. It looks like the Host controller
> (MQ1132) is initialized properly but not sure. When I plug in a USB
> stick on to the USB port, I get the following messages.
> -----------------------------------------------------------------
> hub.c: USB new device connect on bus1/1, assigned device number 2
> usb-ohci.c: unlink URB timeout
> usb.c: USB device not accepting new address=2 (error=-145)
>
> hub.c: USB new device connect on bus1/1, assigned device number 3
> usb_control/bulk_msg: timeout
> usb-ohci.c: unlink URB timeout
> usb.c: USB device not accepting new address=3 (error=-145)
> -------------------------------------------------------------------
> Has anyone experienced the same out there. Could any one suggest how
> to debug this error. What could be the problem?.
>
> Thanks in advance.
>
> Regards,
> aks
>
> _________________________________________________________________
> Add glamour to your desktop. Let your screen sizzle. 
> http://server1.msn.co.in/msnchannels/Entertainment/wallpaperhome.asp 
> Download the hottest wallpapers.
>
>
>
