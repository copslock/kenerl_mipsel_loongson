Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2014 17:54:02 +0200 (CEST)
Received: from mail-bl2lp0211.outbound.protection.outlook.com ([207.46.163.211]:33090
        "EHLO na01-bl2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6837586AbaEFPwnRih-j (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 May 2014 17:52:43 +0200
Received: from CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) by
 CO1PR07MB847.namprd07.prod.outlook.com (10.242.162.156) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:18 +0000
Received: from alberich.caveonetworks.com (2.171.87.122) by
 CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19) with Microsoft SMTP
 Server (TLS) id 15.0.929.12; Tue, 6 May 2014 15:52:16 +0000
From:   Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
To:     Pekka Enberg <penberg@kernel.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <kvm@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 02/11] kvm tools: Fix print format warnings
Date:   Tue, 6 May 2014 17:51:22 +0200
Message-ID: <1399391491-5021-3-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
References: <1399391491-5021-1-git-send-email-andreas.herrmann@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [2.171.87.122]
X-ClientProxiedBy: DBXPR07CA010.eurprd07.prod.outlook.com (10.255.191.168)
 To CO1PR07MB396.namprd07.prod.outlook.com (10.141.74.19)
X-Forefront-PRVS: 0203C93D51
X-Forefront-Antispam-Report: SFV:NSPM;SFS:(10019001)(6009001)(428001)(199002)(189002)(77982001)(83072002)(85852003)(89996001)(92566001)(31966008)(77156001)(99396002)(20776003)(47776003)(83322001)(19580405001)(74662001)(74502001)(19580395003)(92726001)(80022001)(33646001)(53416003)(66066001)(2009001)(4396001)(36756003)(88136002)(81542001)(101416001)(50226001)(42186004)(93916002)(86362001)(81342001)(46102001)(79102001)(62966002)(50466002)(76482001)(87976001)(87286001)(50986999)(48376002)(76176999);DIR:OUT;SFP:1102;SCL:1;SRVR:CO1PR07MB396;H:alberich.caveonetworks.com;FPR:3ACFD85D.9AE2D78A.70D7295E.ECDB4D22.204BF;MLV:sfv;PTR:InfoNoRecords;A:1;MX:1;LANG:en;
Received-SPF: None (: caviumnetworks.com does not designate permitted sender
 hosts)
X-OriginatorOrg: caviumnetworks.com
Return-Path: <Andreas.Herrmann@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40029
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

This should fix following warnings

 builtin-stat.c:93:3: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 2 has type '__u64' [-Wformat]
 builtin-run.c:188:4: warning: format '%Lu' expects argument of type 'long long unsigned int', but argument 3 has type '__u64' [-Wformat]
 builtin-run.c:554:3: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 2 has type 'u64' [-Wformat]
 builtin-run.c:554:3: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 3 has type 'u64' [-Wformat]
 builtin-run.c:645:3: warning: format '%Lu' expects argument of type 'long long unsigned int', but argument 4 has type 'u64' [-Wformat]
 disk/core.c:330:4: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 4 has type '__dev_t' [-Wformat]
 disk/core.c:330:4: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 5 has type '__dev_t' [-Wformat]
 disk/core.c:330:4: warning: format '%llu' expects argument of type 'long long unsigned int', but argument 6 has type '__ino64_t' [-Wformat]
 mmio.c:134:5: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 4 has type 'u64' [-Wformat]
 util/util.c:101:7: warning: format '%lld' expects argument of type 'long long int', but argument 3 has type 'u64' [-Wformat]
 util/util.c:113:7: warning: format '%lld' expects argument of type 'long long int', but argument 2 has type 'u64' [-Wformat]
 hw/pci-shmem.c:339:3: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'u64' [-Wformat]
 hw/pci-shmem.c:340:3: warning: format '%llx' expects argument of type 'long long unsigned int', but argument 2 has type 'u64' [-Wformat]

as observed when compiling on mips64.

Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
---
 tools/kvm/builtin-run.c  |   12 ++++++++----
 tools/kvm/builtin-stat.c |    2 +-
 tools/kvm/disk/core.c    |    4 +++-
 tools/kvm/hw/pci-shmem.c |    5 +++--
 tools/kvm/mmio.c         |    5 +++--
 tools/kvm/util/util.c    |    4 ++--
 6 files changed, 20 insertions(+), 12 deletions(-)

diff --git a/tools/kvm/builtin-run.c b/tools/kvm/builtin-run.c
index da95d71..1ee75ad 100644
--- a/tools/kvm/builtin-run.c
+++ b/tools/kvm/builtin-run.c
@@ -184,8 +184,8 @@ panic_kvm:
 		current_kvm_cpu->kvm_run->exit_reason,
 		kvm_exit_reasons[current_kvm_cpu->kvm_run->exit_reason]);
 	if (current_kvm_cpu->kvm_run->exit_reason == KVM_EXIT_UNKNOWN)
-		fprintf(stderr, "KVM exit code: 0x%Lu\n",
-			current_kvm_cpu->kvm_run->hw.hardware_exit_reason);
+		fprintf(stderr, "KVM exit code: 0x%llu\n",
+			(unsigned long long)current_kvm_cpu->kvm_run->hw.hardware_exit_reason);
 
 	kvm_cpu__set_debug_fd(STDOUT_FILENO);
 	kvm_cpu__show_registers(current_kvm_cpu);
@@ -551,7 +551,9 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 		kvm->cfg.ram_size = get_ram_size(kvm->cfg.nrcpus);
 
 	if (kvm->cfg.ram_size > host_ram_size())
-		pr_warning("Guest memory size %lluMB exceeds host physical RAM size %lluMB", kvm->cfg.ram_size, host_ram_size());
+		pr_warning("Guest memory size %lluMB exceeds host physical RAM size %lluMB",
+			(unsigned long long)kvm->cfg.ram_size,
+			(unsigned long long)host_ram_size());
 
 	kvm->cfg.ram_size <<= MB_SHIFT;
 
@@ -639,7 +641,9 @@ static struct kvm *kvm_cmd_run_init(int argc, const char **argv)
 	kvm->cfg.real_cmdline = real_cmdline;
 
 	printf("  # %s run -k %s -m %Lu -c %d --name %s\n", KVM_BINARY_NAME,
-		kvm->cfg.kernel_filename, kvm->cfg.ram_size / 1024 / 1024, kvm->cfg.nrcpus, kvm->cfg.guest_name);
+		kvm->cfg.kernel_filename,
+		(unsigned long long)kvm->cfg.ram_size / 1024 / 1024,
+		kvm->cfg.nrcpus, kvm->cfg.guest_name);
 
 	if (init_list__init(kvm) < 0)
 		die ("Initialisation failed");
diff --git a/tools/kvm/builtin-stat.c b/tools/kvm/builtin-stat.c
index ffd72e8..5d6407e 100644
--- a/tools/kvm/builtin-stat.c
+++ b/tools/kvm/builtin-stat.c
@@ -90,7 +90,7 @@ static int do_memstat(const char *name, int sock)
 			printf("The total amount of memory available (in bytes):");
 			break;
 		}
-		printf("%llu\n", stats[i].val);
+		printf("%llu\n", (unsigned long long)stats[i].val);
 	}
 	printf("\n");
 
diff --git a/tools/kvm/disk/core.c b/tools/kvm/disk/core.c
index 4e9bda0..309e16c 100644
--- a/tools/kvm/disk/core.c
+++ b/tools/kvm/disk/core.c
@@ -327,7 +327,9 @@ ssize_t disk_image__get_serial(struct disk_image *disk, void *buffer, ssize_t *l
 		return r;
 
 	*len = snprintf(buffer, *len, "%llu%llu%llu",
-			(u64)st.st_dev, (u64)st.st_rdev, (u64)st.st_ino);
+			(unsigned long long)st.st_dev,
+			(unsigned long long)st.st_rdev,
+			(unsigned long long)st.st_ino);
 	return *len;
 }
 
diff --git a/tools/kvm/hw/pci-shmem.c b/tools/kvm/hw/pci-shmem.c
index 34de747..d769e432 100644
--- a/tools/kvm/hw/pci-shmem.c
+++ b/tools/kvm/hw/pci-shmem.c
@@ -336,8 +336,9 @@ int shmem_parser(const struct option *opt, const char *arg, int unset)
 		strcpy(handle, default_handle);
 	}
 	if (verbose) {
-		pr_info("shmem: phys_addr = %llx", phys_addr);
-		pr_info("shmem: size      = %llx", size);
+		pr_info("shmem: phys_addr = %llx",
+			(unsigned long long)phys_addr);
+		pr_info("shmem: size      = %llx", (unsigned long long)size);
 		pr_info("shmem: handle    = %s", handle);
 		pr_info("shmem: create    = %d", create);
 	}
diff --git a/tools/kvm/mmio.c b/tools/kvm/mmio.c
index 5d65d28..786c3eb 100644
--- a/tools/kvm/mmio.c
+++ b/tools/kvm/mmio.c
@@ -130,8 +130,9 @@ bool kvm__emulate_mmio(struct kvm *kvm, u64 phys_addr, u8 *data, u32 len, u8 is_
 		mmio->mmio_fn(phys_addr, data, len, is_write, mmio->ptr);
 	else {
 		if (kvm->cfg.mmio_debug)
-			fprintf(stderr, "Warning: Ignoring MMIO %s at %016llx (length %u)\n",
-				to_direction(is_write), phys_addr, len);
+			fprintf(stderr,	"Warning: Ignoring MMIO %s at %016llx (length %u)\n",
+				to_direction(is_write),
+				(unsigned long long)phys_addr, len);
 	}
 	br_read_unlock();
 
diff --git a/tools/kvm/util/util.c b/tools/kvm/util/util.c
index c11a15a..1877105 100644
--- a/tools/kvm/util/util.c
+++ b/tools/kvm/util/util.c
@@ -98,7 +98,7 @@ void *mmap_hugetlbfs(struct kvm *kvm, const char *htlbfs_path, u64 size)
 	blk_size = (unsigned long)sfs.f_bsize;
 	if (sfs.f_bsize == 0 || blk_size > size) {
 		die("Can't use hugetlbfs pagesize %ld for mem size %lld\n",
-		    blk_size, size);
+			blk_size, (unsigned long long)size);
 	}
 
 	kvm->ram_pagesize = blk_size;
@@ -110,7 +110,7 @@ void *mmap_hugetlbfs(struct kvm *kvm, const char *htlbfs_path, u64 size)
 	unlink(mpath);
 	if (ftruncate(fd, size) < 0)
 		die("Can't ftruncate for mem mapping size %lld\n",
-		    size);
+			(unsigned long long)size);
 	addr = mmap(NULL, size, PROT_RW, MAP_PRIVATE, fd, 0);
 	close(fd);
 
-- 
1.7.9.5
