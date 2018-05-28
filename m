Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 12:27:38 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39290 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994784AbeE1K0rtwKx0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 May 2018 12:26:47 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 562722089E;
        Mon, 28 May 2018 10:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527503201;
        bh=fe65bwzeE5Y5wAzL5Cvd4Wio7wnYqpw4DOiDoimFEw4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VVWyHWX4GzX37H6+0JQrI8l+HsuUBgJ1cb0Sd6t+ifPmafWP/OkOH1hCqJR/5Zvv7
         56408nldgqKLzcmqrtklGhzVdqGUvR24i+M8RjMukhqWqT8zvs0Adl21Wq2OKt+zTG
         6sZ17jl3eK2gPnUi2KJgUZlW/LICOX4hvvRnnrwU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Colin Ian King <colin.king@canonical.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.9 004/329] KVM: Fix spelling mistake: "cop_unsuable" -> "cop_unusable"
Date:   Mon, 28 May 2018 11:58:53 +0200
Message-Id: <20180528100242.363386059@linuxfoundation.org>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180528100241.796630982@linuxfoundation.org>
References: <20180528100241.796630982@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <SRS0=WbIs=IP=linuxfoundation.org=gregkh@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64097
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

4.9-stable review patch.  If anyone has any objections, please let me know.

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
@@ -42,7 +42,7 @@ struct kvm_stats_debugfs_item debugfs_en
 	{ "cache",	  VCPU_STAT(cache_exits),	 KVM_STAT_VCPU },
 	{ "signal",	  VCPU_STAT(signal_exits),	 KVM_STAT_VCPU },
 	{ "interrupt",	  VCPU_STAT(int_exits),		 KVM_STAT_VCPU },
-	{ "cop_unsuable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
+	{ "cop_unusable", VCPU_STAT(cop_unusable_exits), KVM_STAT_VCPU },
 	{ "tlbmod",	  VCPU_STAT(tlbmod_exits),	 KVM_STAT_VCPU },
 	{ "tlbmiss_ld",	  VCPU_STAT(tlbmiss_ld_exits),	 KVM_STAT_VCPU },
 	{ "tlbmiss_st",	  VCPU_STAT(tlbmiss_st_exits),	 KVM_STAT_VCPU },
