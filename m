Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 17:55:25 +0200 (CEST)
Received: from mail-bn1blp0186.outbound.protection.outlook.com ([207.46.163.186]:29158
        "EHLO na01-bn1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6838763AbaEFPxAE0ed- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 May 2014 17:53:00 +0200
Received: from CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) by
 CO1PR07MB300.namprd07.prod.outlook.com (10.141.69.13) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:51 +0000
Received: from alberich.caveonetworks.com (2.171.87.122) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:50 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH 09/11] kvm tools, mips: Add support for loading elf binaries
Date:   Tue, 6 May 2014 17:51:29 +0200
Message-ID: <1399391491-5021-10-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.171.87.122]
X-ClientProxiedBy: DBXPR07CA010.eurprd07.prod.outlook.com (10.255.191.168)
 To CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
X-Forefront-PRVS: 0203C93D51
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(77982001)(83072002)(85852003)(89996001)(92566001)(31966008)(77156001)(99396002)(20776003)(47776003)(83322001)(19580405001)(74662001)(74502001)(19580395003)(92726001)(80022001)(33646001)(53416003)(66066001)(2009001)(4396001)(36756003)(88136002)(81542001)(101416001)(50226001)(42186004)(93916002)(86362001)(81342001)(46102001)(79102001)(62966002)(50466002)(76482001)(87976001)(87286001)(50986999)(48376002)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR07MB396;H:alberich.caveonetworks.com;FPR:B87FF370.AC2A88FC.6EF75B7F.A618F8ED.203FC;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40033
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

From: David Daney <david.daney@cavium.com>

[andreas.herrmann:
       * Fixed compile warnings]

Signed-off-by: David Daney <david.daney@cavium.com>
Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/mips/kvm.c |  200 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 200 insertions(+)

diff --git a/tools/kvm/mips/kvm.c b/tools/kvm/mips/kvm.c
index 2b73785..09192c8 100644
--- a/tools/kvm/mips/kvm.c
+++ b/tools/kvm/mips/kvm.c
@@ -6,6 +6,7 @@
 
 #include <ctype.h>
 #include <unistd.h>
+#include <elf.h>
 
 struct kvm_ext kvm_req_ext[] = {
 	{ 0, 0 }
@@ -99,6 +100,43 @@ int kvm__arch_setup_firmware(struct kvm *kvm)
 	return 0;
 }
 
+static void kvm__mips_install_cmdline(struct kvm *kvm)
+{
+	char *p = kvm->ram_start;
+	u64 cmdline_offset = 0x2000;
+	u64 argv_start = 0x3000;
+	u64 argv_offset = argv_start;
+	u64 argc = 0;
+
+	sprintf(p + cmdline_offset, "mem=0x%llx@0 ",
+		 (unsigned long long)kvm->ram_size);
+
+	strcat(p + cmdline_offset, kvm->cfg.real_cmdline); /* maximum size is 2K */
+
+	while (p[cmdline_offset]) {
+		if (!isspace(p[cmdline_offset])) {
+			if (kvm->arch.is64bit) {
+				*(u64 *)(p + argv_offset) = 0xffffffff80000000ull + cmdline_offset;
+				argv_offset += sizeof(u64);
+			} else {
+				*(u32 *)(p + argv_offset) = 0x80000000u + cmdline_offset;
+				argv_offset += sizeof(u32);
+			}
+			argc++;
+			while(p[cmdline_offset] && !isspace(p[cmdline_offset]))
+				cmdline_offset++;
+			continue;
+		}
+		/* Must be a space character skip over these*/
+		while(p[cmdline_offset] && isspace(p[cmdline_offset])) {
+			p[cmdline_offset] = 0;
+			cmdline_offset++;
+		}
+	}
+	kvm->arch.argc = argc;
+	kvm->arch.argv = 0xffffffff80000000ull + argv_start;
+}
+
 /* Load at the 1M point. */
 #define KERNEL_LOAD_ADDR 0x1000000
 int load_flat_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *kernel_cmdline)
@@ -123,6 +161,168 @@ int load_flat_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *
 	return true;
 }
 
+struct kvm__arch_elf_info {
+	u64 load_addr;
+	u64 entry_point;
+	size_t len;
+	size_t offset;
+};
+
+static bool kvm__arch_get_elf_64_info(Elf64_Ehdr *ehdr, int fd_kernel,
+				      struct kvm__arch_elf_info *ei)
+{
+	int i;
+	size_t nr;
+	Elf64_Phdr phdr;
+
+	if (ehdr->e_phentsize != sizeof(phdr)) {
+		pr_info("Incompatible ELF PHENTSIZE %d", ehdr->e_phentsize);
+		return false;
+	}
+
+	ei->entry_point = ehdr->e_entry;
+
+	if (lseek(fd_kernel, ehdr->e_phoff, SEEK_SET) < 0)
+		die_perror("lseek");
+
+	phdr.p_type = PT_NULL;
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		nr = read(fd_kernel, &phdr, sizeof(phdr));
+		if (nr != sizeof(phdr)) {
+			pr_info("Couldn't read %d bytes for ELF PHDR.", (int)sizeof(phdr));
+			return false;
+		}
+		if (phdr.p_type == PT_LOAD)
+			break;
+	}
+	if (phdr.p_type != PT_LOAD) {
+		pr_info("No PT_LOAD Program Header found.");
+		return false;
+	}
+
+	ei->load_addr = phdr.p_paddr;
+
+	if ((ei->load_addr & 0xffffffffc0000000ull) == 0xffffffff80000000ull)
+		ei->load_addr &= 0x1ffffffful; /* Convert KSEG{0,1} to physical. */
+	if ((ei->load_addr & 0xc000000000000000ull) == 0x8000000000000000ull)
+		ei->load_addr &= 0x07ffffffffffffffull; /* Convert XKPHYS to pysical */
+
+
+	ei->len = phdr.p_filesz;
+	ei->offset = phdr.p_offset;
+
+	return true;
+}
+
+static bool kvm__arch_get_elf_32_info(Elf32_Ehdr *ehdr, int fd_kernel,
+				      struct kvm__arch_elf_info *ei)
+{
+	int i;
+	size_t nr;
+	Elf32_Phdr phdr;
+
+	if (ehdr->e_phentsize != sizeof(phdr)) {
+		pr_info("Incompatible ELF PHENTSIZE %d", ehdr->e_phentsize);
+		return false;
+	}
+
+	ei->entry_point = (s64)((s32)ehdr->e_entry);
+
+	if (lseek(fd_kernel, ehdr->e_phoff, SEEK_SET) < 0)
+		die_perror("lseek");
+
+	phdr.p_type = PT_NULL;
+	for (i = 0; i < ehdr->e_phnum; i++) {
+		nr = read(fd_kernel, &phdr, sizeof(phdr));
+		if (nr != sizeof(phdr)) {
+			pr_info("Couldn't read %d bytes for ELF PHDR.", (int)sizeof(phdr));
+			return false;
+		}
+		if (phdr.p_type == PT_LOAD)
+			break;
+	}
+	if (phdr.p_type != PT_LOAD) {
+		pr_info("No PT_LOAD Program Header found.");
+		return false;
+	}
+
+	ei->load_addr = (s64)((s32)phdr.p_paddr);
+
+	if ((ei->load_addr & 0xffffffffc0000000ull) == 0xffffffff80000000ull)
+		ei->load_addr &= 0x1fffffffull; /* Convert KSEG{0,1} to physical. */
+
+	ei->len = phdr.p_filesz;
+	ei->offset = phdr.p_offset;
+
+	return true;
+}
+
+int load_elf_binary(struct kvm *kvm, int fd_kernel, int fd_initrd, const char *kernel_cmdline)
+{
+	union {
+		Elf64_Ehdr ehdr;
+		Elf32_Ehdr ehdr32;
+	} eh;
+
+	size_t nr;
+	char *p;
+	struct kvm__arch_elf_info ei;
+
+	if (lseek(fd_kernel, 0, SEEK_SET) < 0)
+		die_perror("lseek");
+
+	nr = read(fd_kernel, &eh, sizeof(eh));
+	if (nr != sizeof(eh)) {
+		pr_info("Couldn't read %d bytes for ELF header.", (int)sizeof(eh));
+		return false;
+	}
+
+	if (eh.ehdr.e_ident[EI_MAG0] != ELFMAG0 ||
+	    eh.ehdr.e_ident[EI_MAG1] != ELFMAG1 ||
+	    eh.ehdr.e_ident[EI_MAG2] != ELFMAG2 ||
+	    eh.ehdr.e_ident[EI_MAG3] != ELFMAG3 ||
+	    (eh.ehdr.e_ident[EI_CLASS] != ELFCLASS64 && eh.ehdr.e_ident[EI_CLASS] != ELFCLASS32) ||
+	    eh.ehdr.e_ident[EI_VERSION] != EV_CURRENT) {
+		pr_info("Incompatible ELF header.");
+		return false;
+	}
+	if (eh.ehdr.e_type != ET_EXEC || eh.ehdr.e_machine != EM_MIPS) {
+		pr_info("Incompatible ELF not MIPS EXEC.");
+		return false;
+	}
+
+	if (eh.ehdr.e_ident[EI_CLASS] == ELFCLASS64) {
+		if (!kvm__arch_get_elf_64_info(&eh.ehdr, fd_kernel, &ei))
+			return false;
+		kvm->arch.is64bit = true;
+	} else {
+		if (!kvm__arch_get_elf_32_info(&eh.ehdr32, fd_kernel, &ei))
+			return false;
+		kvm->arch.is64bit = false;
+	}
+
+	kvm->arch.entry_point = ei.entry_point;
+
+	if (lseek(fd_kernel, ei.offset, SEEK_SET) < 0)
+		die_perror("lseek");
+
+	p = guest_flat_to_host(kvm, ei.load_addr);
+
+	pr_info("ELF Loading 0x%lx bytes from 0x%llx to 0x%llx",
+		(unsigned long)ei.len, (unsigned long long)ei.offset, (unsigned long long)ei.load_addr);
+	do {
+		nr = read(fd_kernel, p, ei.len);
+		if (nr < 0)
+			die_perror("read");
+		p += nr;
+		ei.len -= nr;
+	} while (ei.len);
+
+	kvm__mips_install_cmdline(kvm);
+
+	return true;
+}
+
 bool load_bzimage(struct kvm *kvm, int fd_kernel, int fd_initrd,
 		  const char *kernel_cmdline)
 {
-- 
1.7.9.5
