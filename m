Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Nov 2004 14:18:46 +0000 (GMT)
Received: from fed1rmmtao07.cox.net ([IPv6:::ffff:68.230.241.32]:13697 "EHLO
	fed1rmmtao07.cox.net") by linux-mips.org with ESMTP
	id <S8225257AbUKEOSl>; Fri, 5 Nov 2004 14:18:41 +0000
Received: from liberty.homelinux.org ([68.2.41.86]) by fed1rmmtao07.cox.net
          (InterMail vM.6.01.04.00 201-2131-117-20041022) with ESMTP
          id <20041105141829.FAWP3261.fed1rmmtao07.cox.net@liberty.homelinux.org>;
          Fri, 5 Nov 2004 09:18:29 -0500
Received: (from mmporter@localhost)
	by liberty.homelinux.org (8.9.3/8.9.3/Debian 8.9.3-21) id HAA19358;
	Fri, 5 Nov 2004 07:18:17 -0700
Date: Fri, 5 Nov 2004 07:18:17 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
Cc: Pete Popov <ppopov@embeddedalley.com>, linux-mips@linux-mips.org
Subject: Re: ohci-au1xxx.c cleanups and fix for 2.6.10-rc1
Message-ID: <20041105071817.A19291@home.com>
References: <1099642775.9984.16.camel@s052.inso.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1099642775.9984.16.camel@s052.inso.tuwien.ac.at>; from hvr@inso.tuwien.ac.at on Fri, Nov 05, 2004 at 09:19:34AM +0100
Return-Path: <mmporter@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6271
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mporter@kernel.crashing.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 05, 2004 at 09:19:34AM +0100, Herbert Valerio Riedel wrote:
> 
> below just a patch to have usb working again for 2.6.10-rc1 and
> some minor cleanups...
> (alas usb still doesn't work on big endian...)

The patches to support BE OHCI operation were posted months ago on
the USB list.  GregKH recently picked them up and I just saw the
first of them merged to the mainline tree. You should have better
luck with BE OHCI soon. :)

-Matt
