Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 14:55:07 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:52297 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992800AbdJIMy3ykihY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Oct 2017 14:54:29 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQl-0004v9-W8; Mon, 09 Oct 2017 13:45:12 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1e1XQP-0001za-KE; Mon, 09 Oct 2017 13:44:49 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "Paul Burton" <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date:   Mon, 09 Oct 2017 13:44:24 +0100
Message-ID: <lsq.1507553064.110822573@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 056/192] MIPS: module: Ensure we always clean up
 r_mips_hi16_list
In-Reply-To: <lsq.1507553063.449494954@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60340
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.49-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 351b0940d473146923711bc943fc881354a4c1f3 upstream.

If we hit an error whilst processing a reloc then we would return early
from apply_relocate & potentially not free entries in r_mips_hi16_list,
thereby leaking memory. Fix this by ensuring that we always run the code
to free r_mipps_hi16_list when errors occur.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 861667dc82f5 ("MIPS: Fix race condition in module relocation code.")
Fixes: 04211a574641 ("MIPS: Bail on unsupported module relocs")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15831/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/module.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

--- a/arch/mips/kernel/module.c
+++ b/arch/mips/kernel/module.c
@@ -202,7 +202,7 @@ int apply_relocate(Elf_Shdr *sechdrs, co
 	u32 *location;
 	unsigned int i, type;
 	Elf_Addr v;
-	int res;
+	int err = 0;
 
 	pr_debug("Applying relocate section %u to %u\n", relsec,
 	       sechdrs[relsec].sh_info);
@@ -221,7 +221,8 @@ int apply_relocate(Elf_Shdr *sechdrs, co
 				continue;
 			printk(KERN_WARNING "%s: Unknown symbol %s\n",
 			       me->name, strtab + sym->st_name);
-			return -ENOENT;
+			err = -ENOENT;
+			goto out;
 		}
 
 		type = ELF_MIPS_R_TYPE(rel[i]);
@@ -234,29 +235,32 @@ int apply_relocate(Elf_Shdr *sechdrs, co
 		if (!handler) {
 			pr_err("%s: Unknown relocation type %u\n",
 			       me->name, type);
-			return -EINVAL;
+			err = -EINVAL;
+			goto out;
 		}
 
 		v = sym->st_value;
-		res = handler(me, location, v);
-		if (res)
-			return res;
+		err = handler(me, location, v);
+		if (err)
+			goto out;
 	}
 
+out:
 	/*
-	 * Normally the hi16 list should be deallocated at this point.	A
+	 * Normally the hi16 list should be deallocated at this point. A
 	 * malformed binary however could contain a series of R_MIPS_HI16
-	 * relocations not followed by a R_MIPS_LO16 relocation.  In that
-	 * case, free up the list and return an error.
+	 * relocations not followed by a R_MIPS_LO16 relocation, or if we hit
+	 * an error processing a reloc we might have gotten here before
+	 * reaching the R_MIPS_LO16. In either case, free up the list and
+	 * return an error.
 	 */
 	if (me->arch.r_mips_hi16_list) {
 		free_relocation_chain(me->arch.r_mips_hi16_list);
 		me->arch.r_mips_hi16_list = NULL;
-
-		return -ENOEXEC;
+		err = err ?: -ENOEXEC;
 	}
 
-	return 0;
+	return err;
 }
 
 /* Given an address, look for it in the module exception tables. */
