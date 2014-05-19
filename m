Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 May 2014 18:56:12 +0200 (CEST)
Received: from mail-bl2lp0204.outbound.protection.outlook.com ([207.46.163.204]:32149
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6854798AbaESQzBfuMJH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 May 2014 18:55:01 +0200
Received: from alberich.caveonetworks.com (46.78.192.208) by
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21) with Microsoft SMTP
 Server (TLS) id 15.0.944.11; Mon, 19 May 2014 16:54:53 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 05/12] kvm tools: Introduce weak (default) load_bzimage function
Date:   Mon, 19 May 2014 18:53:24 +0200
Message-ID: <1400518411-9759-6-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1400518411-9759-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [46.78.192.208]
X-ClientProxiedBy: AM2PR06CA006.eurprd06.prod.outlook.com (10.255.61.23) To
 DM2PR07MB398.namprd07.prod.outlook.com (10.141.104.21)
X-Forefront-PRVS: 021670B4D2
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(6009001)(428001)(189002)(199002)(81542001)(33646001)(92566001)(46102001)(21056001)(81156002)(87976001)(87286001)(4396001)(53416003)(62966002)(99396002)(50986999)(36756003)(77156001)(76482001)(93916002)(92726001)(88136002)(86362001)(81342001)(42186004)(79102001)(50466002)(20776003)(69596002)(47776003)(102836001)(31966008)(80022001)(74502001)(83322001)(77982001)(19580405001)(76176999)(19580395003)(50226001)(85852003)(83072002)(66066001)(64706001)(48376002)(89996001)(101416001);DIR:OUT;SFP:;SCL:1;SRVR:DM2PR07MB398;H:alberich.caveonetworks.com;FPR:;MLV:sfv;PTR:InfoNoRecords;MX:1;A:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
Authentication-Results: spf=none (sender IP is )
 smtp.mailfrom=Andreas.Herrmann@caviumnetworks.com; 
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40146
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
 tools/kvm/powerpc/kvm.c |    7 -------
 3 files changed, 6 insertions(+), 14 deletions(-)

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
index cfc0693..6046434 100644
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
