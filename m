Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA2583369 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Apr 1998 10:26:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id KAA6463842
	for linux-list;
	Wed, 1 Apr 1998 10:24:14 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA6505601
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 1 Apr 1998 10:24:12 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id KAA19072
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 10:24:09 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (dali.uni-koblenz.de [141.26.5.1])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id UAA09421
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Apr 1998 20:24:05 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id UAA06046;
	Wed, 1 Apr 1998 20:23:57 +0200
Message-ID: <19980401202356.29041@uni-koblenz.de>
Date: Wed, 1 Apr 1998 20:23:56 +0200
To: Ulf Carlsson <grimsy@ballyhoo.ml.org>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: new to sgi linux
References: <19980401192600.33372@uni-koblenz.de> <Pine.LNX.3.96.980401194246.21805A-100000@ballyhoo.ml.org> <19980401200419.40942@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <19980401200419.40942@uni-koblenz.de>; from ralf@uni-koblenz.de on Wed, Apr 01, 1998 at 08:04:19PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Apr 01, 1998 at 08:04:19PM +0200, ralf@uni-koblenz.de wrote:

> On Wed, Apr 01, 1998 at 07:47:35PM +0200, Ulf Carlsson wrote:
> 
> > Does this mean that It's possible for me to give you more information?
> 
> I already have everything that is needed to fix the problem.

Below the patch.  Oliver is going to build a kernel to test the fix
for you.

  Ralf

--- linux-sgi/arch/mips/mm/r4xx0.c-orig	Wed Apr  1 20:09:18 1998
+++ linux-sgi/arch/mips/mm/r4xx0.c	Wed Apr  1 20:11:07 1998
@@ -1951,7 +1951,7 @@
 	a = addr & ~(sc_lsize - 1);
 	end = (addr + size) & ~(sc_lsize - 1);
 	while (1) {
-		flush_scache_line(addr); /* Hit_Writeback_Inv_SD */
+		flush_scache_line(a);	/* Hit_Writeback_Inv_SD */
 		if (addr == end) break;
 		addr += sc_lsize;
 	}
@@ -2006,7 +2006,7 @@
 	a = addr & ~(sc_lsize - 1);
 	end = (addr + size) & ~(sc_lsize - 1);
 	while (1) {
-		flush_scache_line(addr); /* Hit_Writeback_Inv_SD */
+		flush_scache_line(a); /* Hit_Writeback_Inv_SD */
 		if (addr == end) break;
 		addr += sc_lsize;
 	}
Apr  1 20:16:47 lappi sendmail[5998]: UAA05998: from=ralf, size=1155, class=0, pri=31155, nrcpts=1, msgid=<19980401201645.29785@uni-koblenz.de>, relay=ralf@localhost
Apr  1 20:16:49 lappi sendmail[6000]: UAA05998: to=oliver@zero.aec.at, ctladdr=ralf (500/500), delay=00:00:02, xdelay=00:00:02, mailer=esmtp, relay=mailhost.uni-koblenz.de [141.26.4.1], stat=Sent (UAA09136 Message accepted for delivery)
Apr  1 20:17:12 lappi sendmail[6004]: UAA06004: from=<owner-linux@cthulhu.engr.sgi.com>, size=2521, class=-60, pri=140521, nrcpts=1, msgid=<19980401195424.58369@uni-koblenz.de>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:13 lappi sendmail[6006]: UAA06006: from=<owner-linux-smp-outgoing@vger.rutgers.edu>, size=6343, class=-60, pri=144343, nrcpts=1, msgid=<Pine.LNX.3.96.980401125139.1077A-100000@ganesh.phy.duke.edu>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:13 lappi sendmail[6009]: UAA06009: from=<MAILER-DAEMON@aec.at>, size=2680, class=0, pri=32680, nrcpts=1, msgid=<199804011803.UAA32054@aec.at>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:14 lappi sendmail[6005]: UAA06004: to=<ralf@localhost>, delay=00:00:02, xdelay=00:00:02, mailer=local, stat=Sent
Apr  1 20:17:14 lappi sendmail[6011]: UAA06009: to=<ralf@localhost>, delay=00:00:01, xdelay=00:00:00, mailer=local, stat=Sent
Apr  1 20:17:14 lappi sendmail[6013]: UAA06013: from=<MAILER-DAEMON>, size=2688, class=0, pri=32688, nrcpts=1, msgid=<199804011803.UAA08654@informatik.uni-koblenz.de>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:15 lappi sendmail[6014]: UAA06013: to=<ralf@localhost>, delay=00:00:01, xdelay=00:00:00, mailer=local, stat=Sent
Apr  1 20:17:15 lappi sendmail[6015]: UAA06015: from=<MAILER-DAEMON>, size=2668, class=0, pri=32668, nrcpts=1, msgid=<199804011804.UAA08690@informatik.uni-koblenz.de>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:15 lappi sendmail[6017]: UAA06015: to=<ralf@localhost>, delay=00:00:01, xdelay=00:00:00, mailer=local, stat=Sent
Apr  1 20:17:15 lappi sendmail[6018]: UAA06018: from=<MAILER-DAEMON>, size=2681, class=0, pri=32681, nrcpts=1, msgid=<199804011804.UAA08701@informatik.uni-koblenz.de>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:15 lappi sendmail[6020]: UAA06018: to=<ralf@localhost>, delay=00:00:00, xdelay=00:00:00, mailer=local, stat=Sent
Apr  1 20:17:16 lappi sendmail[6022]: UAA06022: from=<owner-linux-kernel-outgoing@vger.rutgers.edu>, size=3507, class=-60, pri=141507, nrcpts=1, msgid=<35227F56.5303EC92@radiks.net>, bodytype=7BIT, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:16 lappi sendmail[6023]: UAA06022: to=<ralf@localhost>, delay=00:00:01, xdelay=00:00:00, mailer=local, stat=Sent
Apr  1 20:17:16 lappi sendmail[6025]: UAA06025: from=<owner-linux-kernel-outgoing@vger.rutgers.edu>, size=2748, class=-60, pri=140748, nrcpts=1, msgid=<Pine.LNX.3.91.980401125523.13920A-100000@mhw.OIT.IUPUI.EDU>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:17 lappi sendmail[6026]: UAA06025: to=<ralf@localhost>, delay=00:00:01, xdelay=00:00:00, mailer=local, stat=Sent
Apr  1 20:17:17 lappi sendmail[6027]: UAA06027: from=<MAILER-DAEMON>, size=2315, class=0, pri=32315, nrcpts=1, msgid=<199804011816.UAA09139@informatik.uni-koblenz.de>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:17:17 lappi sendmail[6029]: UAA06027: to=<ralf@localhost>, delay=00:00:01, xdelay=00:00:00, mailer=local, stat=Sent
Apr  1 20:17:21 lappi sendmail[6008]: UAA06006: to=<ralf@localhost>, delay=00:00:09, xdelay=00:00:08, mailer=local, stat=Sent
Apr  1 20:17:49 lappi in.fingerd[6031]: connect from 141.26.5.28
Apr  1 20:20:58 lappi in.fingerd[6034]: connect from 141.26.4.29
Apr  1 20:21:57 lappi sendmail[6038]: UAA06038: from=<owner-linux@cthulhu.engr.sgi.com>, size=2362, class=-60, pri=140362, nrcpts=1, msgid=<19980401200419.40942@uni-koblenz.de>, proto=ESMTP, relay=localhost [127.0.0.1]
Apr  1 20:21:58 lappi sendmail[6039]: UAA06038: to=<ralf@localhost>, delay=00:00:02, xdelay=00:00:00, mailer=local, stat=Sent
