Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jul 2017 21:33:56 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:37916 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994874AbdGYTW11Gbun (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jul 2017 21:22:27 +0200
Received: from localhost (rrcs-64-183-28-114.west.biz.rr.com [64.183.28.114])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A509A82;
        Tue, 25 Jul 2017 19:22:21 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.9 096/125] MIPS: Fix a typo: s/preset/present/ in r2-to-r6 emulation error message
Date:   Tue, 25 Jul 2017 12:20:11 -0700
Message-Id: <20170725192019.690507452@linuxfoundation.org>
X-Mailer: git-send-email 2.13.3
In-Reply-To: <20170725192014.314851996@linuxfoundation.org>
References: <20170725192014.314851996@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59263
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

From: Maciej W. Rozycki <macro@imgtec.com>

commit 27fe2200dad2de8207a694024a7b9037dff1b280 upstream.

This is a user-visible message, so we want it to be spelled correctly.

Fixes: 5f9f41c474be ("MIPS: kernel: Prepare the JR instruction for emulation on MIPS R6")
Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/16400/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/branch.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -823,7 +823,7 @@ sigill_dsp:
 	force_sig(SIGILL, current);
 	return -EFAULT;
 sigill_r2r6:
-	pr_info("%s: R2 branch but r2-to-r6 emulator is not preset - sending SIGILL.\n",
+	pr_info("%s: R2 branch but r2-to-r6 emulator is not present - sending SIGILL.\n",
 		current->comm);
 	force_sig(SIGILL, current);
 	return -EFAULT;
