Received:  by oss.sgi.com id <S42247AbQHFPNj>;
	Sun, 6 Aug 2000 08:13:39 -0700
Received: from [204.94.214.10] ([204.94.214.10]:8272 "EHLO deliverator.sgi.com")
	by oss.sgi.com with ESMTP id <S42228AbQHFPNL>;
	Sun, 6 Aug 2000 08:13:11 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id HAA14152
	for <linux-mips@oss.sgi.com>; Sun, 6 Aug 2000 07:41:07 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA56089
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 6 Aug 2000 07:48:15 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA04331
	for <linux@cthulhu.engr.sgi.com>; Sun, 6 Aug 2000 07:48:13 -0700 (PDT)
	mail_from (flo@rfc822.org)
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 64ADF7F4; Sun,  6 Aug 2000 16:50:13 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 0C4D58FF5; Fri,  4 Aug 2000 20:56:08 +0200 (CEST)
Date:   Fri, 4 Aug 2000 20:56:08 +0200
From:   Florian Lohoff <flo@rfc822.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     =?iso-8859-1?Q?=B1=E8=C7=D1=BC=BA?= <khs@digital-digital.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: Re: IGS5050 Driver
Message-ID: <20000804205608.A313@paradigm.rfc822.org>
References: <000001bff6fe$34021120$8d19ebcb@khs> <Pine.LNX.4.10.10007271423280.434-100000@cassiopeia.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.0.1i
In-Reply-To: <Pine.LNX.4.10.10007271423280.434-100000@cassiopeia.home>; from geert@linux-m68k.org on Thu, Jul 27, 2000 at 02:26:02PM +0200
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 27, 2000 at 02:26:02PM +0200, Geert Uytterhoeven wrote:
> On Wed, 26 Jul 2000, [ks_c_5601-1987] ±èÇÑ?º wrote:
> > I want to know that there is a IGS5050 Grpahic chip driver for linux-mips.
> > If yes, where is the driver files?
> 
> linux/drivers/video/cyber2000fb.c is a driver for the IGS CyberPro 2000, 2010
> and 5000 in the NetWinder, which has an ARM CPU. If the 5050 is sufficient
> compatible with the 5000 it should not be too difficult to get cyber2000fb to
> work on the 5050 on the MIPS.

When back from Canada i will start working on that beast - I have 100
SetTopBoxes with the 5000/5050 Combination (Video and Audio Controller).
(These are x86 based)

The IGS People seem to be quiet helpful - I mailed them concerning
Documentation and got a LARGE pdf back for this Chip.

Flo
-- 
Florian Lohoff		flo@rfc822.org		      	+49-5201-669912
     "If you're not having fun right now, you're wasting your time."
