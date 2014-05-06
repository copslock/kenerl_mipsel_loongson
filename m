Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 17:53:20 +0200 (CEST)
Received: from mail-bn1blp0185.outbound.protection.outlook.com ([207.46.163.185]:32734
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837585AbaEFPwcwh0R3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 May 2014 17:52:32 +0200
Received: from CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) by
 CO1PR07MB377.namprd07.prod.outlook.com (10.141.74.156) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:25 +0000
Received: from alberich.caveonetworks.com (2.171.87.122) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:24 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 04/11] kvm tools: Allow to load ELF binary
Date:   Tue, 6 May 2014 17:51:24 +0200
Message-ID: <1399391491-5021-5-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.171.87.122]
X-ClientProxiedBy: DBXPR07CA010.eurprd07.prod.outlook.com (10.255.191.168)
 To CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
X-Forefront-PRVS: 0203C93D51
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(77982001)(83072002)(85852003)(89996001)(92566001)(31966008)(77156001)(99396002)(20776003)(47776003)(83322001)(19580405001)(74662001)(74502001)(19580395003)(92726001)(80022001)(33646001)(53416003)(66066001)(2009001)(4396001)(36756003)(88136002)(81542001)(101416001)(50226001)(42186004)(93916002)(86362001)(81342001)(46102001)(79102001)(62966002)(50466002)(76482001)(87976001)(87286001)(50986999)(48376002)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR07MB396;H:alberich.caveonetworks.com;FPR:F09BFDD2.A9D5A58A.B9676397.29FBE64D.201A9;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40027
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

Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/include/kvm/kvm.h |    1 +
 tools/kvm/kvm.c             |   11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/tools/kvm/include/kvm/kvm.h b/tools/kvm/include/kvm/kvm.h
index d05b936..3643fe3 100644
--- a/tools/kvm/include/kvm/kvm.h
+++ b/tools/kvm/include/kvm/kvm.h
@@ -109,6 +109,7 @@ void *guest_flat_to_host(struct kvm *kvm, u64 offset);
 u64 host_to_guest_flat(struct kvm *kvm, void *ptr);
 
 int load_flat_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *kernel_cmdline);
+int load_elf_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *kernel_cmdline);
 bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *kernel_cmdline);
 
 /*
diff --git a/tools/kvm/kvm.c b/tools/kvm/kvm.c
index 7bd20d3..cfc0693 100644
--- a/tools/kvm/kvm.c
+++ b/tools/kvm/kvm.c
@@ -349,6 +349,12 @@ static bool initrd_check(int fd)
 		!memcmp(id, CPIO_MAGIC, 4);
 }
 
+int __attribute__((__weak__)) load_elf_binary(struct kvm *kvm, int fd_kernel,
+				int fd_initrd, const char *kernel_cmdline)
+{
+	return false;
+}
+
 bool kvm__load_kernel(struct kvm *kvm, const char *kernel_filename,
 		const char *initrd_filename, const char *kernel_cmdline)
 {
@@ -375,6 +381,11 @@ bool kvm__load_kernel(struct kvm *kvm, const char *kernel_filename,
 
 	pr_warning("%s is not a bzImage. Trying to load it as a flat binary...", kernel_filename);
 
+	ret = load_elf_binary(kvm, fd_kernel, fd_initrd, kernel_cmdline);
+
+	if (ret)
+		goto found_kernel;
+
 	ret = load_flat_binary(kvm, fd_kernel, fd_initrd, kernel_cmdline);
 
 	if (ret)
-- 
1.7.9.5
