Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 23:19:43 +0000 (GMT)
Received: from zok.sgi.com ([IPv6:::ffff:204.94.215.101]:13288 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225240AbTBDXTn>;
	Tue, 4 Feb 2003 23:19:43 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h14MQZKp004980;
	Tue, 4 Feb 2003 14:26:36 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id KAA27549; Wed, 5 Feb 2003 10:19:36 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h14NJ9Md028916;
	Wed, 5 Feb 2003 10:19:10 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h14NJ9g5028914;
	Wed, 5 Feb 2003 10:19:09 +1100
Date: Wed, 5 Feb 2003 10:19:09 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030204231909.GE27302@pureza.melbourne.sgi.com>
References: <20030204061323.GA27302@pureza.melbourne.sgi.com> <20030204092417.GR16674@bogon.ms20.nix> <20030204223930.GD27302@pureza.melbourne.sgi.com> <20030204231203.GY16674@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204231203.GY16674@bogon.ms20.nix>
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1314
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 12:12:03AM +0100, Guido Guenther wrote:
> On Wed, Feb 05, 2003 at 09:39:30AM +1100, Andrew Clausen wrote:
> > It was blindly copying from the environment variable a string
> > looking like dksc(0,1,2).  This should be translated (somehow)
> > to something looking like /dev/sdb1.  This would have to be
> > done after the hard disk probes.
> If you set OSLoadPartition=/dev/sda1 (or whatever) - it allows you to
> boot from hard disk without any boot loader involved.

Huh?  The firmware uses something looking like OSLoadPartition=dksc(0,1,2),
not /dev/sda1.

>  If you have a
> bootloader (which is only true for IP22 [1]) it sets up the kernels
> commandline properly anyway - so where's the problem? nfsroot?

The problem is the firmware (on my IP27, anyway) uses a different
form to Linux for OSLoadPartition.  OSLoadPartition tells the
firmware / bootloader (sash here) where to find the kernel.

Cheers,
Andrew
