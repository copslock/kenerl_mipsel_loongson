Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Jan 2004 12:39:53 +0000 (GMT)
Received: from dsl-144-120.resnet.purdue.edu ([IPv6:::ffff:128.211.144.120]:29570
	"EHLO mail.bstech.org") by linux-mips.org with ESMTP
	id <S8225539AbUA2Mjx>; Thu, 29 Jan 2004 12:39:53 +0000
Received: (qmail 14923 invoked from network); 29 Jan 2004 12:39:42 -0000
Received: from unknown (HELO gangstah) (192.168.1.220)
  by 192.168.1.222 with RC4-MD5 encrypted SMTP; 29 Jan 2004 12:39:42 -0000
Message-ID: <005a01c3e66d$44f9a120$dc01a8c0@gangstah>
From: "Brian Stratman" <bstratman@bstech.org>
To: =?iso-8859-1?Q?St=E9phane?= <stf@c-gix.com>,
	<linux-mips@linux-mips.org>
References: <4018EA65.40407@c-gix.com>
Subject: Re: Best kernel for a Cobalt Qube 2
Date: Thu, 29 Jan 2004 07:39:05 -0600
Organization: Brian Squared Technologies
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Return-Path: <bstratman@bstech.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bstratman@bstech.org
Precedence: bulk
X-list: linux-mips

Hi-
I've recently acquired a Cobalt Qube2.  After about 8 hours of monkeying
around with it the last couple days, I have successfully got 2.4.24 up and
running, I started with trying to get 2.6 on it, that was a huge mess.  I'm
also using Debian sarge distro.  2.4.24 has a few #define's that are missing
and a couple other small hangups during my cross compile.  So far so good.
I haven't had a chance to stress test it yet.  Hopefully I can have more
details about stability in a few days, as well as a quick log of the changes
that are needed in the 2.4.24 source.  I'm not sure what i'm gonna do with
it yet, maybe set it as my new router or do Web or Qmail.  I have the Debian
package for the kernel upgrade, if anyone is interested.  You'll need to
compress and move the kernel and map file to the appropriate names in the
/boot dir.

Brian Stratman
Managing Partner
Brian Squared Technologies
BStratman@bstech.org
www.bstech.org

----- Original Message ----- 
From: "Stéphane" <stf@c-gix.com>
To: <linux-mips@linux-mips.org>
Sent: Thursday, January 29, 2004 5:11 AM
Subject: Best kernel for a Cobalt Qube 2


> Hello,
>
> I'm using a Cobalt Qube 2 for a long time now, it's under a 2.4.14
> kernel working 24/24 7/7 without any problem (no weird hang, no tulip
> problems, both internal network cards used).
>
> It's appears that the new libc needs at least a 2.4.19 kernel, this is
> breaking all my debian updates. So I'll have to switch.
>
> Do you have any advice about which kernel to use  ?
>
> According to what I read here, 2.4.23 seems not ready and it's not clear
> to me if newest kernels still have problem whith the network/serial bug...
>
> Regards,
>
> Stephane
>
>
>
>
>
>
>
