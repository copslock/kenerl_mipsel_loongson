Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Jul 2003 02:33:18 +0100 (BST)
Received: from janus.foobazco.org ([IPv6:::ffff:198.144.194.226]:15236 "EHLO
	mail.foobazco.org") by linux-mips.org with ESMTP
	id <S8225215AbTGTBdP>; Sun, 20 Jul 2003 02:33:15 +0100
Received: from fallout.sjc.foobazco.org (fallout.sjc.foobazco.org [192.168.21.20])
	by mail.foobazco.org (Postfix) with ESMTP
	id 65B1AFA36; Sat, 19 Jul 2003 18:33:11 -0700 (PDT)
Received: by fallout.sjc.foobazco.org (Postfix, from userid 1014)
	id EBE4C2C; Sat, 19 Jul 2003 18:33:10 -0700 (PDT)
Date: Sat, 19 Jul 2003 18:33:10 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: PATCH: mips64 bogus setsockopt translation
Message-ID: <20030720013310.GB3093@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <wesolows@foobazco.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2829
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wesolows@foobazco.org
Precedence: bulk
X-list: linux-mips

DaveM recently nuked this translation that breaks icmpv6 filters from
sparc64.  We have a copy of it, and ours is surely just as wrong.
Here's a patch.

--- arch/mips64/kernel/linux32.c.orig	2003-07-19 18:30:24.167408364 -0700
+++ arch/mips64/kernel/linux32.c	2003-07-19 18:30:52.686564580 -0700
@@ -1511,42 +1511,12 @@
 	return ret;
 }
 
-static int do_set_icmpv6_filter(int fd, int level, int optname,
-				char *optval, int optlen)
-{
-	struct icmp6_filter kfilter;
-	mm_segment_t old_fs;
-	int ret, i;
-
-	if (copy_from_user(&kfilter, optval, sizeof(kfilter)))
-		return -EFAULT;
-
-
-	for (i = 0; i < 8; i += 2) {
-		u32 tmp = kfilter.data[i];
-
-		kfilter.data[i] = kfilter.data[i + 1];
-		kfilter.data[i + 1] = tmp;
-	}
-
-	old_fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = sys_setsockopt(fd, level, optname,
-			     (char *) &kfilter, sizeof(kfilter));
-	set_fs(old_fs);
-
-	return ret;
-}
-
 asmlinkage int sys32_setsockopt(int fd, int level, int optname,
 				char *optval, int optlen)
 {
 	if (optname == SO_ATTACH_FILTER)
 		return do_set_attach_filter(fd, level, optname,
 					    optval, optlen);
-	if (level == SOL_ICMPV6 && optname == ICMPV6_FILTER)
-		return do_set_icmpv6_filter(fd, level, optname,
-					    optval, optlen);
 
 	return sys_setsockopt(fd, level, optname, optval, optlen);
 }


-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"May Buddha bless all stubborn people!"
				-- Uliassutai Karakorum Blake
