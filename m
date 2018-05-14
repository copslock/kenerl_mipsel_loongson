From: Colin Ian King <colin.king@canonical.com>
Date: Mon, 14 May 2018 18:23:50 +0100
Subject: KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
Message-ID: <20180514172350.1RJxjC3Kj_N3Srhrfyo807mXR_0jQn_Vx0GymF8FuFg@z>

From: Colin Ian King <colin.king@canonical.com>

commit ba3696e94d9d590d9a7e55f68e81c25dba515191 upstream.

Trivial fix to spelling mistake in debugfs_entries text.

Fixes: 669e846e6c4e ("KVM/MIPS32: MIPS arch specific APIs for KVM")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kernel-janitors@vger.kernel.org
Cc: <stable@vger.kernel.org> # 3.10+
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kvm/mips.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -39,7 +39,7 @@ struct kvm_stats_debugfs_item debugfs_en
 	{ "cache",	  VCPU_STAT(cache_exits),	 KVM_STAT_VCPU },
 	{ "signal",	  VCPU_STAT(signal_exits),	 KVM_STAT_VCPU },
 	{ "interrupt",	  VCPU_STAT(int_exits),		 KVM_STAT_VCPU },
-	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
+	{ "cop_unusable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
 	{ "tlbmod",	  VCPU_STAT(tlbmod_exits),	 KVM_STAT_VCPU },
 	{ "tlbmiss_ld",	  VCPU_STAT(tlbmiss_ld_exits),	 KVM_STAT_VCPU },
 	{ "tlbmiss_st",	  VCPU_STAT(tlbmiss_st_exits),	 KVM_STAT_VCPU },


Patches currently in stable-queue which might be from colin.king@canonical.com are

queue-3.18/kvm-fix-spelling-mistake-cop_unsuable-cop_unusable.patch
