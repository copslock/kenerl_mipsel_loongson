Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2003 23:56:56 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:34691
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225201AbTDBW4z>; Wed, 2 Apr 2003 23:56:55 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 016642BC30; Thu,  3 Apr 2003 00:56:53 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 06070-05;
 Thu,  3 Apr 2003 00:56:51 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb5515.pool.mediaWays.net [217.187.85.21])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 998E72BC2D; Thu,  3 Apr 2003 00:56:51 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 4F03A1735C; Thu,  3 Apr 2003 00:54:21 +0200 (CEST)
Date: Thu, 3 Apr 2003 00:54:21 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: [PATCH] r4k_blast_dcache_page compile fix
Message-ID: <20030402225421.GA1721@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org, ralf@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1903
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
the attached patch moves the opening brace out of the the
R4600_V1_HIT_DCACHE_WAR ifdef to make things compile again (good old
egcs 1.1.2 thinks this is even worth an ICE). Patch is against 2.5 but
should apply against 2.4 as well. Please apply.
Regards,
 -- Guido

--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="r4k_blast_dcache_page.diff"

Index: arch/mips/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips/mm/c-r4k.c,v
retrieving revision 1.31
diff -u -p -r1.31 c-r4k.c
--- arch/mips/mm/c-r4k.c	31 Mar 2003 23:32:17 -0000	1.31
+++ arch/mips/mm/c-r4k.c	2 Apr 2003 22:51:33 -0000
@@ -73,8 +73,8 @@ dc_32:
 	return;
 
 dc_32_r4600:
-#ifdef R4600_V1_HIT_DCACHE_WAR
 	{
+#ifdef R4600_V1_HIT_DCACHE_WAR
 	unsigned long flags;
 
 	local_irq_save(flags);
Index: arch/mips64/mm/c-r4k.c
===================================================================
RCS file: /home/cvs/linux/arch/mips64/mm/c-r4k.c,v
retrieving revision 1.18
diff -u -p -r1.18 c-r4k.c
--- arch/mips64/mm/c-r4k.c	31 Mar 2003 23:32:17 -0000	1.18
+++ arch/mips64/mm/c-r4k.c	2 Apr 2003 22:51:46 -0000
@@ -73,8 +73,8 @@ dc_32:
 	return;
 
 dc_32_r4600:
-#ifdef R4600_V1_HIT_DCACHE_WAR
 	{
+#ifdef R4600_V1_HIT_DCACHE_WAR
 	unsigned long flags;
 
 	local_irq_save(flags);

--liOOAslEiF7prFVr--
