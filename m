Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Feb 2003 04:15:04 +0000 (GMT)
Received: from rj.SGI.COM ([IPv6:::ffff:192.82.208.96]:33976 "EHLO rj.sgi.com")
	by linux-mips.org with ESMTP id <S8224939AbTBCEPD>;
	Mon, 3 Feb 2003 04:15:03 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by rj.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h132FAG8032001
	for <@external-mail-relay.sgi.com:linux-mips@linux-mips.org>; Sun, 2 Feb 2003 18:15:11 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id PAA06009 for <linux-mips@linux-mips.org>; Mon, 3 Feb 2003 15:14:59 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h134EXMd018235
	for <linux-mips@linux-mips.org>; Mon, 3 Feb 2003 15:14:34 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h134EWIe018233
	for linux-mips@linux-mips.org; Mon, 3 Feb 2003 15:14:32 +1100
Date: Mon, 3 Feb 2003 15:14:32 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: debian installer on mips64 (origin 200)
Message-ID: <20030203041432.GF967@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1292
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

I've got Debian running smoothly on an Origin 200 :)

I've also got it booting off a CD, by putting a dvh partition table,
containing an xfs partition with a kernel on it.  Unfortunately,
I couldn't get dvhtool to put sash on it.  (It complained the volume
header was too small, which it wasn't)
I had to use the sash off the hard disk.

Anyway, in principle, I should be able write a shell script to
create the above image, and add an isofs partition containing the debian
mips install cd.  Just, I bet it can't deal with sash / the prom
properly - it's probably dependent on arcboot.  Also, it would need
different kernel packages.

So, I guess an arcboot port would be the nicest solution?

Perhaps a better approach is to get the kernel to prompt users to
change disks, and stick in the vanilla debian CD?  i.e. have a
"mips64-bootstrap.img" CD image, which prompts for install-1 afterwards.

Cheers,
Andrew

PS: I don't speak for SGI
