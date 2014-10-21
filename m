Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Oct 2014 06:29:01 +0200 (CEST)
Received: from mail-pd0-f182.google.com ([209.85.192.182]:34104 "EHLO
        mail-pd0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011982AbaJUE2nBm5FX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Oct 2014 06:28:43 +0200
Received: by mail-pd0-f182.google.com with SMTP id y10so502812pdj.13
        for <multiple recipients>; Mon, 20 Oct 2014 21:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8i5f+Sxh6hTo3I7177+kv0TAT5QNH8t3Otz1CXlRAuE=;
        b=zI+JPWR5dbcWFOMDs7GuDXIlWnxZbveOiIArbKjz3oP1/TLTfdkplW98fnJc6r7iG0
         4iw2uc8S/VvOsYcTRDy61opJUTItq8LuUOQrzvWpuGjacJbC/vFsP496GvEUxNBLj5qC
         0MNt/zNP34LeY/zecVz+znKNv3VEXqAZm5pObtN/B+DoAa1Dq7F71CRW7Ju2Dbomjeek
         OxzJ56RVB9GN40xedxbXMF5qGPCX/6cgZtiofAZ2Rd8MxFfY7ejj0ieQweE9435/ACAg
         nJoZg9VGD4OW2pYk58m8Vop1FlJRrje3htqGO/YrQ0K+GOKyPyGwO2JdMU8dMkFb8em+
         o/8g==
X-Received: by 10.70.5.164 with SMTP id t4mr32537108pdt.48.1413865716739;
        Mon, 20 Oct 2014 21:28:36 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id b2sm10498181pbu.42.2014.10.20.21.28.35
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 21:28:36 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        jfraser@broadcom.com, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
Subject: [PATCH/RFC 01/17] MIPS: BMIPS: Fix ".previous without corresponding .section" warnings
Date:   Mon, 20 Oct 2014 21:27:51 -0700
Message-Id: <1413865687-15255-2-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
References: <1413865687-15255-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Commit 078a55fc824c1 ("Delete __cpuinit/__CPUINIT usage from MIPS code")
removed our __CPUINIT directives, so now the ".previous" directives
are superfluous.  Remove them.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/bmips_vec.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index 290c23b..8649507 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -208,7 +208,6 @@ bmips_reset_nmi_vec_end:
 END(bmips_reset_nmi_vec)
 
 	.set	pop
-	.previous
 
 /***********************************************************************
  * CPU1 warm restart vector (used for second and subsequent boots).
@@ -281,5 +280,3 @@ LEAF(bmips_enable_xks01)
 	jr	ra
 
 END(bmips_enable_xks01)
-
-	.previous
-- 
2.1.1
