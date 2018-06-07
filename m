Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Jun 2018 17:02:44 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:48987 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994585AbeFGPCgQqXff (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 7 Jun 2018 17:02:36 +0200
Received: from [148.252.241.226] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvbm-0005hL-Pl; Thu, 07 Jun 2018 15:09:46 +0100
Received: from ben by deadeye with local (Exim 4.91)
        (envelope-from <ben@decadent.org.uk>)
        id 1fQvb3-0002tC-8v; Thu, 07 Jun 2018 15:09:01 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, "James Hogan" <jhogan@kernel.org>,
        linux-mips@linux-mips.org, "Ralf Baechle" <ralf@linux-mips.org>
Date:   Thu, 07 Jun 2018 15:05:21 +0100
Message-ID: <lsq.1528380321.538040447@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 144/410] MIPS: Fix clean of vmlinuz.{32,ecoff,bin,srec}
In-Reply-To: <lsq.1528380320.647747352@decadent.org.uk>
X-SA-Exim-Connect-IP: 148.252.241.226
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64211
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

3.16.57-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit 5f2483eb2423152445b39f2db59d372f523e664e upstream.

Make doesn't expand shell style "vmlinuz.{32,ecoff,bin,srec}" to the 4
separate files, so none of these files get cleaned up by make clean.
List the files separately instead.

Fixes: ec3352925b74 ("MIPS: Remove all generated vmlinuz* files on "make clean"")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/18491/
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/boot/compressed/Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

--- a/arch/mips/boot/compressed/Makefile
+++ b/arch/mips/boot/compressed/Makefile
@@ -117,4 +117,8 @@ OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFL
 vmlinuz.srec: vmlinuz
 	$(call cmd,objcopy)
 
-clean-files := $(objtree)/vmlinuz $(objtree)/vmlinuz.{32,ecoff,bin,srec}
+clean-files += $(objtree)/vmlinuz
+clean-files += $(objtree)/vmlinuz.32
+clean-files += $(objtree)/vmlinuz.ecoff
+clean-files += $(objtree)/vmlinuz.bin
+clean-files += $(objtree)/vmlinuz.srec
