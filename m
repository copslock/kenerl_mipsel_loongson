Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 12:15:12 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55874 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993883AbeE1KOcjRh-l (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 12:14:32 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F07BD20883;
        Mon, 28 May 2018 10:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527502466;
        bh=UJTX5F0YNSTuCS+grZ0QKbaxnzUs2HtjCTRB5PqDPo0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ehm5smlKN71ob2ymhT6oWBsT7d42Up04cLD0WwnOLXL3xnLIDXdZq//Y6j8tDEeSL
         KvX3Xda8AkYVDkpEVNNoOqTftXuTt/gVOfc46rGSOxA/qJiT7LvBV6YRrOoU++/0K+
         g6gz93BtgqYlgRVxBV3TtNcdSP1llsOckf90oPIk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.4 003/268] KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
Date:   Mon, 28 May 2018 11:59:37 +0200
Message-Id: <20180528100202.419352505@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100202.045206534@linuxfoundation.org>
References: <20180528100202.045206534@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64090
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
@@ -40,7 +40,7 @@ struct kvm_stats_debugfs_item debugfs_en
 	{ "cache",	  VCPU_STAT(cache_exits),	 KVM_STAT_VCPU },
 	{ "signal",	  VCPU_STAT(signal_exits),	 KVM_STAT_VCPU },
 	{ "interrupt",	  VCPU_STAT(int_exits),		 KVM_STAT_VCPU },
-	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
+	{ "cop_unusable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
 	{ "tlbmod",	  VCPU_STAT(tlbmod_exits),	 KVM_STAT_VCPU },
 	{ "tlbmiss_ld",	  VCPU_STAT(tlbmiss_ld_exits),	 KVM_STAT_VCPU },
 	{ "tlbmiss_st",	  VCPU_STAT(tlbmiss_st_exits),	 KVM_STAT_VCPU },
