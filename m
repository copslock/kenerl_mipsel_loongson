Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 15:34:00 +0100 (CET)
Received: from demumfd002.nsn-inter.net ([93.183.12.31]:54824 "EHLO
        demumfd002.nsn-inter.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013392AbaKKOd0CmcZQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 15:33:26 +0100
Received: from demuprx017.emea.nsn-intra.net ([10.150.129.56])
        by demumfd002.nsn-inter.net (8.14.3/8.14.3) with ESMTP id sABEXKeB001177
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Tue, 11 Nov 2014 14:33:20 GMT
Received: from localhost.localdomain ([10.144.45.144])
        by demuprx017.emea.nsn-intra.net (8.12.11.20060308/8.12.11) with ESMTP id sABEXIgS032128;
        Tue, 11 Nov 2014 15:33:19 +0100
From:   Aaro Koskinen <aaro.koskinen@nsn.com>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aaro Koskinen <aaro.koskinen@nsn.com>
Subject: [PATCH RESEND 2/3] MIPS: oprofile: enable backtrace on timer-based profiling
Date:   Tue, 11 Nov 2014 16:30:42 +0200
Message-Id: <1415716243-1303-2-git-send-email-aaro.koskinen@nsn.com>
X-Mailer: git-send-email 2.1.2
In-Reply-To: <1415716243-1303-1-git-send-email-aaro.koskinen@nsn.com>
References: <1415716243-1303-1-git-send-email-aaro.koskinen@nsn.com>
X-purgate-type: clean
X-purgate-Ad: Categorized by eleven eXpurgate (R) http://www.eleven.de
X-purgate: clean
X-purgate: This mail is considered clean (visit http://www.eleven.de for further information)
X-purgate-size: 1279
X-purgate-ID: 151667::1415716400-00001FC1-6AC1E620/0/0
Return-Path: <aaro.koskinen@nsn.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44004
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
2.1.2
