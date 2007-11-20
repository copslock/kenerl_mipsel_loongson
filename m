Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2007 02:02:18 +0000 (GMT)
Received: from DSL022.labridge.com ([206.117.136.22]:54536 "EHLO perches.com")
	by ftp.linux-mips.org with ESMTP id S20035091AbXKTCCJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2007 02:02:09 +0000
Received: from localhost.localdomain ([192.168.1.128])
	by perches.com (8.9.3/8.9.3) with ESMTP id SAA32368;
	Mon, 19 Nov 2007 18:01:19 -0800
From:	Joe Perches <joe@perches.com>
To:	linux-kernel@vger.kernel.org
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 02/59] arch/mips: Add missing "space"
Date:	Mon, 19 Nov 2007 17:47:54 -0800
Message-Id: <1195523331-15303-3-git-send-email-joe@perches.com>
X-Mailer: git-send-email 1.5.3.6.728.gea559
In-Reply-To: <1195523331-15303-2-git-send-email-joe@perches.com>
References: 1234567
 <1195523331-15303-1-git-send-email-joe@perches.com>
 <1195523331-15303-2-git-send-email-joe@perches.com>
Message-Id: <23f0badf8dab73294c2aa142fafb9301ca843e88.1195454434.git.joe@perches.com>
In-Reply-To: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
References: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17538
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips


Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/kernel/vpe.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
index 38bd33f..c06eb81 100644
--- a/arch/mips/kernel/vpe.c
+++ b/arch/mips/kernel/vpe.c
@@ -470,7 +470,7 @@ static int apply_r_mips_lo16(struct module *me, uint32_t *location,
 			 */
  			if (v != l->value) {
 				printk(KERN_DEBUG "VPE loader: "
-				       "apply_r_mips_lo16/hi16: 	"
+				       "apply_r_mips_lo16/hi16: \t"
 				       "inconsistent value information\n");
 				return -ENOEXEC;
 			}
@@ -629,7 +629,7 @@ static void simplify_symbols(Elf_Shdr * sechdrs,
 			break;
 
 		case SHN_MIPS_SCOMMON:
-			printk(KERN_DEBUG "simplify_symbols: ignoring SHN_MIPS_SCOMMON"
+			printk(KERN_DEBUG "simplify_symbols: ignoring SHN_MIPS_SCOMMON "
 			       "symbol <%s> st_shndx %d\n", strtab + sym[i].st_name,
 			       sym[i].st_shndx);
 			// .sbss section
-- 
1.5.3.5.652.gf192c
