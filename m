Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Sep 2017 10:43:21 +0200 (CEST)
Received: from cpanel2.indieserve.net ([199.212.143.6]:40241 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdIBInJa8ht8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Sep 2017 10:43:09 +0200
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:47916 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1do418-0003C3-KV; Sat, 02 Sep 2017 04:43:02 -0400
Date:   Sat, 2 Sep 2017 04:43:00 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     devicetree@vger.kernel.org
cc:     linux-mips@linux-mips.org,
        Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>,
        monstr@monstr.eu
Subject: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
Message-ID: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
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


Since, according to a recent devicetree ML posting by Rob Herring,
the node "/chosen@0" is most likely for real Open Firmware and does
not apply to DTSpec, remove all remaining tests and references for
that node, of which there are very few left:

 arch/microblaze/kernel/prom.c | 3 +--
 arch/mips/generic/yamon-dt.c  | 4 ----
 arch/powerpc/boot/oflib.c     | 7 ++-----
 drivers/of/base.c             | 2 --
 drivers/of/fdt.c              | 5 +----
 5 files changed, 4 insertions(+), 17 deletions(-)

This should be innocuous as, in all of the three arch/ files above,
there is a test for "chosen" immediately before the test for
"chosen@0", so nothing should change.

Signed-off-by: Robert P. J. Day <rpjday@crashcourse.ca>

---

  if this patch is premature, then just ignore it, thanks.

diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
index 68f0999..c81bfd7 100644
--- a/arch/microblaze/kernel/prom.c
+++ b/arch/microblaze/kernel/prom.c
@@ -53,8 +53,7 @@ static int __init early_init_dt_scan_chosen_serial(unsigned long node,

 	pr_debug("%s: depth: %d, uname: %s\n", __func__, depth, uname);

-	if (depth == 1 && (strcmp(uname, "chosen") == 0 ||
-				strcmp(uname, "chosen@0") == 0)) {
+	if (depth == 1 && (strcmp(uname, "chosen") == 0)) {
 		p = of_get_flat_dt_prop(node, "linux,stdout-path", &l);
 		if (p != NULL && l > 0)
 			stdout = p; /* store pointer to stdout-path */
diff --git a/arch/mips/generic/yamon-dt.c b/arch/mips/generic/yamon-dt.c
index 6077bca..3a241b2 100644
--- a/arch/mips/generic/yamon-dt.c
+++ b/arch/mips/generic/yamon-dt.c
@@ -28,8 +28,6 @@ __init int yamon_dt_append_cmdline(void *fdt)
 	/* find or add chosen node */
 	chosen_off = fdt_path_offset(fdt, "/chosen");
 	if (chosen_off == -FDT_ERR_NOTFOUND)
-		chosen_off = fdt_path_offset(fdt, "/chosen@0");
-	if (chosen_off == -FDT_ERR_NOTFOUND)
 		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
 	if (chosen_off < 0) {
 		pr_err("Unable to find or add DT chosen node: %d\n",
@@ -221,8 +219,6 @@ __init int yamon_dt_serial_config(void *fdt)
 	/* find or add chosen node */
 	chosen_off = fdt_path_offset(fdt, "/chosen");
 	if (chosen_off == -FDT_ERR_NOTFOUND)
-		chosen_off = fdt_path_offset(fdt, "/chosen@0");
-	if (chosen_off == -FDT_ERR_NOTFOUND)
 		chosen_off = fdt_add_subnode(fdt, 0, "chosen");
 	if (chosen_off < 0) {
 		pr_err("Unable to find or add DT chosen node: %d\n",
diff --git a/arch/powerpc/boot/oflib.c b/arch/powerpc/boot/oflib.c
index 46c98a4..a01471f 100644
--- a/arch/powerpc/boot/oflib.c
+++ b/arch/powerpc/boot/oflib.c
@@ -131,11 +131,8 @@ static int check_of_version(void)
 		return 0;
 	chosen = of_finddevice("/chosen");
 	if (chosen == (phandle) -1) {
-		chosen = of_finddevice("/chosen@0");
-		if (chosen == (phandle) -1) {
-			printf("no chosen\n");
-			return 0;
-		}
+		printf("no chosen\n");
+		return 0;
 	}
 	if (of_getprop(chosen, "mmu", &chosen_mmu, sizeof(chosen_mmu)) <= 0) {
 		printf("no mmu\n");
diff --git a/drivers/of/base.c b/drivers/of/base.c
index 686628d..e0f636d 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -1659,8 +1659,6 @@ void of_alias_scan(void * (*dt_alloc)(u64 size, u64 align))

 	of_aliases = of_find_node_by_path("/aliases");
 	of_chosen = of_find_node_by_path("/chosen");
-	if (of_chosen == NULL)
-		of_chosen = of_find_node_by_path("/chosen@0");

 	if (of_chosen) {
 		/* linux,stdout-path and /aliases/stdout are for legacy compatibility */
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index ce30c9a..0b0a709 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -980,8 +980,6 @@ int __init early_init_dt_scan_chosen_stdout(void)

 	offset = fdt_path_offset(fdt, "/chosen");
 	if (offset < 0)
-		offset = fdt_path_offset(fdt, "/chosen@0");
-	if (offset < 0)
 		return -ENOENT;

 	p = fdt_getprop(fdt, offset, "stdout-path", &l);
@@ -1117,8 +1115,7 @@ int __init early_init_dt_scan_chosen(unsigned long node, const char *uname,

 	pr_debug("search \"chosen\", depth: %d, uname: %s\n", depth, uname);

-	if (depth != 1 || !data ||
-	    (strcmp(uname, "chosen") != 0 && strcmp(uname, "chosen@0") != 0))
+	if (depth != 1 || !data || (strcmp(uname, "chosen") != 0))
 		return 0;

 	early_init_dt_check_for_initrd(node);

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
