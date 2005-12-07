Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2005 11:13:47 +0000 (GMT)
Received: from krt.tmd.ns.ac.yu ([147.91.177.65]:16267 "EHLO krt.neobee.net")
	by ftp.linux-mips.org with ESMTP id S8133413AbVLGLL0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 7 Dec 2005 11:11:26 +0000
Received: from localhost (localhost [127.0.0.1])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id jB7CSfuI003385
	for <linux-mips@linux-mips.org>; Wed, 7 Dec 2005 13:28:41 +0100
Received: from krt.neobee.net ([127.0.0.1])
 by localhost (krt.neobee.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 03262-01 for <linux-mips@linux-mips.org>;
 Wed,  7 Dec 2005 13:28:41 +0100 (CET)
Received: from had ([192.168.0.89])
	by krt.neobee.net (8.12.7/8.12.7/SuSE Linux 0.6) with ESMTP id jB7CSdti003380
	for <linux-mips@linux-mips.org>; Wed, 7 Dec 2005 13:28:40 +0100
Reply-To: <Mile.Davidovic@micronasnit.com>
From:	"Mile Davidovic" <Mile.Davidovic@micronasnit.com>
To:	<linux-mips@linux-mips.org>
Subject: List symbols from object files
Date:	Wed, 7 Dec 2005 12:11:04 +0100
Organization: MicronasNIT
Message-ID: <001701c5fb1e$ea5e33c0$5900a8c0@niit.micronasnit.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2670
Thread-Index: AcX7HugZYIpsBZpnQ+ClTHjv6CrQ5Q==
X-Virus-Scanned: by amavisd-new at krt.neobee.net
Return-Path: <Mile.Davidovic@micronasnit.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Mile.Davidovic@micronasnit.com
Precedence: bulk
X-list: linux-mips

Hello all

I am not shure that this question is for this list, if I made mistake, I am
so sorry.
My question is about usage of mips-linux-nm on Linux kernel with debugging
information. 

mips-linux-nm -la vmlinux does not show line number information.
Is this expected bahavioure or I am missing something?

This is part of my .config file:
CONFIG_DEBUG_KERNEL=y
# CONFIG_MAGIC_SYSRQ is not set
CONFIG_LOG_BUF_SHIFT=14
# CONFIG_SCHEDSTATS is not set
# CONFIG_DEBUG_SLAB is not set
CONFIG_DEBUG_PREEMPT=y
# CONFIG_DEBUG_SPINLOCK is not set
# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
# CONFIG_DEBUG_KOBJECT is not set
CONFIG_DEBUG_INFO=y
# CONFIG_DEBUG_FS is not set
CONFIG_CROSSCOMPILE=y
CONFIG_CMDLINE=""
# CONFIG_DEBUG_STACK_USAGE is not set
# CONFIG_KGDB is not set
CONFIG_RUNTIME_DEBUG=y
# CONFIG_MIPS_UNCACHED is not set


Best regards Mile
