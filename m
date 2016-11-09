Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 12:09:05 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56546 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993064AbcKILIXPa4OA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 12:08:23 +0100
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id E990CB0B;
        Wed,  9 Nov 2016 11:08:16 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.8 075/138] MIPS: KASLR: Fix handling of NULL FDT
Date:   Wed,  9 Nov 2016 11:45:58 +0100
Message-Id: <20161109102848.289751780@linuxfoundation.org>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161109102844.808685475@linuxfoundation.org>
References: <20161109102844.808685475@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55737
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

4.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit 4736697963385e6257ee8e260e97347e858cd962 upstream.

If platform code returns a NULL pointer to the FDT, initial_boot_params
will not get set to a valid pointer and attempting to find the /chosen
node in it will cause a NULL pointer dereference and the kernel to crash
immediately on startup - with no output to the console.

Fix this by checking that initial_boot_params is valid before using it.

Fixes: 405bc8fd12f5 ("MIPS: Kernel: Implement KASLR using CONFIG_RELOCATABLE")
Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/14414/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/relocate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/relocate.c
+++ b/arch/mips/kernel/relocate.c
@@ -200,7 +200,7 @@ static inline __init unsigned long get_r
 
 #if defined(CONFIG_USE_OF)
 	/* Get any additional entropy passed in device tree */
-	{
+	if (initial_boot_params) {
 		int node, len;
 		u64 *prop;
 
