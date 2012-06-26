Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2012 06:59:31 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55038 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903798Ab2FZEv7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jun 2012 06:51:59 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SjNbT-0002zj-3k; Mon, 25 Jun 2012 23:42:15 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH 21/33] MIPS: Netlogic: Cleanup firmware support for the XLR platform.
Date:   Mon, 25 Jun 2012 23:41:36 -0500
Message-Id: <1340685708-14408-22-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10.3
In-Reply-To: <1340685708-14408-1-git-send-email-sjhill@mips.com>
References: <1340685708-14408-1-git-send-email-sjhill@mips.com>
X-archive-position: 33841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/netlogic/xlr/setup.c |   48 +++++++++-------------------------------
 1 file changed, 10 insertions(+), 38 deletions(-)

diff --git a/arch/mips/netlogic/xlr/setup.c b/arch/mips/netlogic/xlr/setup.c
index c9d066d..54ca3fc 100644
--- a/arch/mips/netlogic/xlr/setup.c
+++ b/arch/mips/netlogic/xlr/setup.c
@@ -31,14 +31,13 @@
  * OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
  * IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
  */
-
 #include <linux/kernel.h>
 #include <linux/serial_8250.h>
 #include <linux/pm.h>
 
 #include <asm/reboot.h>
 #include <asm/time.h>
-#include <asm/bootinfo.h>
+#include <asm/fw/fw.h>
 
 #include <asm/netlogic/interrupt.h>
 #include <asm/netlogic/psb-bootinfo.h>
@@ -113,45 +112,21 @@ void __init prom_free_prom_memory(void)
 	/* Nothing yet */
 }
 
-static void __init build_arcs_cmdline(int *argv)
+static void __init build_arcs_cmdline(void)
 {
-	int i, remain, len;
-	char *arg;
-
-	remain = sizeof(arcs_cmdline) - 1;
-	arcs_cmdline[0] = '\0';
-	for (i = 0; argv[i] != 0; i++) {
-		arg = (char *)(long)argv[i];
-		len = strlen(arg);
-		if (len + 1 > remain)
-			break;
-		strcat(arcs_cmdline, arg);
-		strcat(arcs_cmdline, " ");
-		remain -=  len + 1;
-	}
+	fw_init_cmdline();
 
 	/* Add the default options here */
-	if ((strstr(arcs_cmdline, "console=")) == NULL) {
-		arg = "console=ttyS0,38400 ";
-		len = strlen(arg);
-		if (len > remain)
-			goto fail;
-		strcat(arcs_cmdline, arg);
-		remain -= len;
+	if ((strstr(fw_getcmdline(), "console=")) == NULL) {
+		strlcat(fw_getcmdline(), "console=ttyS0,38400 ",
+			COMMAND_LINE_SIZE);
 	}
 #ifdef CONFIG_BLK_DEV_INITRD
-	if ((strstr(arcs_cmdline, "rdinit=")) == NULL) {
-		arg = "rdinit=/sbin/init ";
-		len = strlen(arg);
-		if (len > remain)
-			goto fail;
-		strcat(arcs_cmdline, arg);
-		remain -= len;
+	if ((strstr(fw_getcmdline(), "rdinit=")) == NULL) {
+		strlcat(fw_getcmdline(), "rdinit=/sbin/init ",
+			COMMAND_LINE_SIZE);
 	}
 #endif
-	return;
-fail:
-	panic("Cannot add %s, command line too big!", arg);
 }
 
 static void prom_add_memory(void)
@@ -178,19 +153,16 @@ static void prom_add_memory(void)
 
 void __init prom_init(void)
 {
-	int *argv, *envp;		/* passed as 32 bit ptrs */
 	struct psb_info *prom_infop;
 
 	/* truncate to 32 bit and sign extend all args */
-	argv = (int *)(long)(int)fw_arg1;
-	envp = (int *)(long)(int)fw_arg2;
 	prom_infop = (struct psb_info *)(long)(int)fw_arg3;
 
 	nlm_prom_info = *prom_infop;
 	nlm_pic_base = nlm_mmio_base(NETLOGIC_IO_PIC_OFFSET);
 
 	nlm_early_serial_setup();
-	build_arcs_cmdline(argv);
+	build_arcs_cmdline();
 	nlm_common_ebase = read_c0_ebase() & (~((1 << 12) - 1));
 	prom_add_memory();
 
-- 
1.7.10.3
