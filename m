Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2004 13:57:14 +0000 (GMT)
Received: from tiu.fh-brandenburg.de ([IPv6:::ffff:195.37.0.8]:27391 "EHLO
	tiu.fh-brandenburg.de") by linux-mips.org with ESMTP
	id <S8225594AbUCON5N>; Mon, 15 Mar 2004 13:57:13 +0000
Received: from localhost ([127.0.0.1])
	by tiu.fh-brandenburg.de with esmtp (Exim 4.30)
	id 1B2sac-00074l-V1
	for linux-mips@linux-mips.org; Mon, 15 Mar 2004 14:57:11 +0100
Received: from tiu.fh-brandenburg.de ([127.0.0.1])
 by localhost (tiu [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 27020-10 for <linux-mips@linux-mips.org>;
 Mon, 15 Mar 2004 14:57:09 +0100 (MET)
Received: from zeus.fh-brandenburg.de ([195.37.1.35])
	by tiu.fh-brandenburg.de with esmtp (Exim 4.30)
	id 1B2sab-00074f-7i
	for linux-mips@linux-mips.org; Mon, 15 Mar 2004 14:57:09 +0100
Received: (from dahms@localhost)
	by zeus.fh-brandenburg.de (8.11.7p1+Sun/8.11.7) id i2FDv8707891
	for linux-mips@linux-mips.org; Mon, 15 Mar 2004 14:57:08 +0100 (MET)
Date: Mon, 15 Mar 2004 14:57:08 +0100
From: Markus Dahms <dahms@fh-brandenburg.de>
To: linux-mips <linux-mips@linux-mips.org>
Subject: newport console fixes
Message-ID: <20040315135708.GA7861@fh-brandenburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FL5UXtIhxfXey3p5"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
X-Virus-Scanned: by amavisd-new at fh-brandenburg.de
Return-Path: <dahms@zeus.fh-brandenburg.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dahms@fh-brandenburg.de
Precedence: bulk
X-list: linux-mips


--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello list,

I patched the newport console driver to have the correct colormap
when exiting X11 / switching from X11 to console.
This problem doesn't affect all versions of the newport, the old
revision in my very old indy doesn't show these effects.
Some revision information of my (different) newports is written in
the header of the attached diff.
Could someone please apply the patch to cvs (2.4 branch, 2.6 isn't
very usable for me), if there are no objections?

Markus

-- 
No RISC - No fun!

--FL5UXtIhxfXey3p5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-newport_con-switchvt.diff"

#### old newport, works w/o patch
#
# NG1: Revision 3, 8 bitplanes, REX3 revision B, VC2 revision A, 
#      xmap9 revision A, cmap revision C, bt445 revision A
# NG1: Screensize 1296x1024
#
## (strange resolution, isn't it? - X does 1280x1024 anyway)

#### new newport, works w/ patch
#
# NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A,
#      xmap9 revision A, cmap revision D, bt445 revision D
# NG1: Screensize 1280x1024

--- drivers/video/newport_con.c.orig	Mon Mar 15 10:28:08 2004
+++ drivers/video/newport_con.c	Mon Mar 15 09:55:24 2004
@@ -448,6 +448,8 @@
 {
 	static int logo_drawn = 0;
 
+	newport_init_cmap();
+
 	topscan = 0;
 	npregs->cset.topscan = 0x3ff;
 

--FL5UXtIhxfXey3p5--
