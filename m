Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 17:55:46 +0200 (CEST)
Received: from mail-bn1blp0184.outbound.protection.outlook.com ([207.46.163.184]:26351
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837168AbaEFPxIfn21q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 May 2014 17:53:08 +0200
Received: from CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) by
 CO1PR07MB363.namprd07.prod.outlook.com (10.141.75.22) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:53:00 +0000
Received: from alberich.caveonetworks.com (2.171.87.122) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:57 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 10/11] kvm tools: Introduce weak (default) load_bzimage function
Date:   Tue, 6 May 2014 17:51:30 +0200
Message-ID: <1399391491-5021-11-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.171.87.122]
X-ClientProxiedBy: DBXPR07CA010.eurprd07.prod.outlook.com (10.255.191.168)
 To CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
X-Forefront-PRVS: 0203C93D51
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(77982001)(83072002)(85852003)(89996001)(92566001)(31966008)(77156001)(99396002)(20776003)(47776003)(83322001)(19580405001)(74662001)(74502001)(19580395003)(92726001)(80022001)(33646001)(53416003)(66066001)(2009001)(4396001)(36756003)(88136002)(81542001)(101416001)(50226001)(42186004)(93916002)(86362001)(81342001)(46102001)(79102001)(62966002)(50466002)(76482001)(87976001)(87286001)(50986999)(48376002)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR07MB396;H:alberich.caveonetworks.com;FPR:D4DBFB7F.21DB95AB.80EB6B56.8308FEFE.201E1;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40034
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andreas.herrmann@caviumnetworks.com
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

... to get rid of its function definition from archs that don't
support it.

Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/arm/fdt.c     |    7 -------
 tools/kvm/kvm.c         |    6 ++++++
 tools/kvm/mips/kvm.c    |    6 ------
 tools/kvm/powerpc/kvm.c |    7 -------
 4 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/tools/kvm/arm/fdt.c b/tools/kvm/arm/fdt.c
index 30cd75a..186a718 100644
--- a/tools/kvm/arm/fdt.c
+++ b/tools/kvm/arm/fdt.c
@@ -276,10 +276,3 @@ int load_flat_binary(struct kvm *kvm, int fd_kernel, int fd_initrd,
 
 	return true;
 }
-
-bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
-		  const char *kernel_cmdline)
-{
-	/* To b or not to b? That is the zImage. */
-	return false;
-}
diff --git a/tools/kvm/kvm.c b/tools/kvm/kvm.c
index 278b915..e1b9f6c 100644
--- a/tools/kvm/kvm.c
+++ b/tools/kvm/kvm.c
@@ -355,6 +355,12 @@ int __attribute__((__weak__)) load_elf_binary(struct kvm *kvm, int fd_kernel,
 	return false;
 }
 
+bool __attribute__((__weak__)) load_bzimage(struct kvm *kvm, int fd_kernel,
+				int fd_initrd, const char *kernel_cmdline)
+{
+	return false;
+}
+
 bool kvm__load_kernel(struct kvm *kvm, const char *kernel_filename,
 		const char *initrd_filename, const char *kernel_cmdline)
 {
diff --git a/tools/kvm/mips/kvm.c b/tools/kvm/mips/kvm.c
index 09192c8..fc0428b 100644
--- a/tools/kvm/mips/kvm.c
+++ b/tools/kvm/mips/kvm.c
@@ -323,12 +323,6 @@ int load_elf_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *k
 	return true;
 }
 
-bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
-		  const char *kernel_cmdline)
-{
-	return false;
-}
-
 void ioport__map_irq(u8 *irq)
 {
 }
diff --git a/tools/kvm/powerpc/kvm.c b/tools/kvm/powerpc/kvm.c
index c1712cf..2b03a12 100644
--- a/tools/kvm/powerpc/kvm.c
+++ b/tools/kvm/powerpc/kvm.c
@@ -204,13 +204,6 @@ int load_flat_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *
 	return true;
 }
 
-bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
-		  const char *kernel_cmdline)
-{
-	/* We don't support bzImages. */
-	return false;
-}
-
 struct fdt_prop {
 	void *value;
 	int size;
-- 
1.7.9.5
