Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Oct 2014 17:12:51 +0200 (CEST)
Received: from demumfd001.nsn-inter.net ([93.183.12.32]:55054 "EHLO
        demumfd001.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011606AbaJQPMui01NO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Oct 2014 17:12:50 +0200
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd001.nsn-inter.net (8.14.3/8.14.3) with ESMTP id s9HFCjvX011157
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 17 Oct 2014 15:12:45 GMT
Received: from localhost.localdomain ([10.144.45.144])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id s9HFCdwg023871;
        Fri, 17 Oct 2014 17:12:44 +0200
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH 2/3] MIPS: oprofile: enable backtrace on timer-based profiling
Date:   Fri, 17 Oct 2014 18:10:25 +0300
Message-Id: <1413558626-16364-2-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1413558626-16364-1-git-send-email-aaro.koskinen@nsn.com>
References: <1413558626-16364-1-git-send-email-aaro.koskinen@nsn.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1279
X-purgate-ID: 151667::1413558765-0000437E-3B452F20/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43329
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@nsn.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Allow unsupported CPU types to use backtrace with timer-based profiling.
Some CPUs (notably OCTEON) lack architecture-specific oprofile driver. In
such case oprofile can fallback to timer-based mode, and arch code can
still provide the backtrace functionality. So just set up the backtrace
hook always.

Signed-off-by: Aaro Koskinen <aaro.koskinen@nsn.com>
---
 arch/mips/oprofile/common.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/mips/oprofile/common.c b/arch/mips/oprofile/common.c
index e747324..6183d05 100644
--- a/arch/mips/oprofile/common.c
+++ b/arch/mips/oprofile/common.c
@@ -106,6 +106,12 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 		break;
 	};
 
+	/*
+	 * Always set the backtrace. This allows unsupported CPU types to still
+	 * use timer-based oprofile.
+	 */
+	ops->backtrace = op_mips_backtrace;
+
 	if (!lmodel)
 		return -ENODEV;
 
@@ -121,7 +127,6 @@ int __init oprofile_arch_init(struct oprofile_operations *ops)
 	ops->start		= op_mips_start;
 	ops->stop		= op_mips_stop;
 	ops->cpu_type		= lmodel->cpu_type;
-	ops->backtrace		= op_mips_backtrace;
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       lmodel->cpu_type);
-- 
1.9.1
