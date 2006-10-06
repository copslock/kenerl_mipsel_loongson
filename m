Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2006 13:33:54 +0100 (BST)
Received: from pne-smtpout1-sn2.hy.skanova.net ([81.228.8.83]:46591 "EHLO
	pne-smtpout1-sn2.hy.skanova.net") by ftp.linux-mips.org with ESMTP
	id S20037810AbWJFMdt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 6 Oct 2006 13:33:49 +0100
Received: from mail.ferretporn.se (83.250.8.219) by pne-smtpout1-sn2.hy.skanova.net (7.2.075)
        id 4516FC4100327629 for linux-mips@linux-mips.org; Fri, 6 Oct 2006 14:33:44 +0200
Received: from www.ferretporn.se (unknown [192.168.0.3])
	by mail.ferretporn.se (Postfix) with ESMTP id 7399CCADC
	for <linux-mips@linux-mips.org>; Fri,  6 Oct 2006 14:33:43 +0200 (CEST)
Received: from 136.163.203.3
        (SquirrelMail authenticated user creideiki)
        by www.ferretporn.se with HTTP;
        Fri, 6 Oct 2006 14:33:43 +0200 (CEST)
Message-ID: <34353.136.163.203.3.1160138023.squirrel@www.ferretporn.se>
Date:	Fri, 6 Oct 2006 14:33:43 +0200 (CEST)
Subject: /proc/cpuinfo makes false assumptions of uniformity on IP27
From:	"Karl-Johan Karlsson" <creideiki+linux-mips@ferretporn.se>
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.8
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <creideiki+linux-mips@ferretporn.se>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: creideiki+linux-mips@ferretporn.se
Precedence: bulk
X-list: linux-mips

The code in arch/mips/kernel/proc.c:show_cpuinfo() for showing
/proc/cpuinfo makes the assumption that all CPU:s are equal, and show
NR_CPUS copies of the information for whatever CPU we happen to be running
on. This leads to confusing output on SGI Origin 2000, since it can have
CPU:s of different types.

Here's a sample of what it looks like on my Origin 2000 with 16 R12000 and
16 R10000 CPU:s:

   creideiki@viggen ~ $ for i in `seq 0 2`; do echo -n "$i: "; grep ^cpu <
/proc/cpuinfo | uniq; done
   0: cpu model            : R12000 V2.3  FPU V0.0
   1: cpu model            : R10000 V3.4  FPU V0.0
   2: cpu model            : R12000 V2.3  FPU V0.0

The obvious fix would be to change "current_cpu_data" to "cpu_data[n]" in
arch/mips/kernel/proc.c:show_cpuinfo(), but two things remain:

0. I haven't actually tried it yet, since the only Origin 2000 I have is
in production. I should be able to reboot to a patched kernel sometime
during this weekend.

1. What about the CPU feature test macros in
include/asm-mips/cpu-features.h? They claim
  /*
   * SMP assumption: Options of CPU 0 are a superset of all processors.
   * This is true for all known MIPS systems.
   */
but is that really true, even on a mixed R12k/R10k system?

-- 
Karl-Johan Karlsson
