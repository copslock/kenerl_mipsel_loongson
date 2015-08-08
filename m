Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Aug 2015 00:11:27 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41321 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011744AbbHHWKiik0cf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Aug 2015 00:10:38 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B53A6279;
        Sat,  8 Aug 2015 22:10:32 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 015/123] MIPS: fpu.h: Allow 64-bit FPU on a 64-bit MIPS R6 CPU
Date:   Sat,  8 Aug 2015 15:08:13 -0700
Message-Id: <20150808220718.380115999@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150808220717.771230091@linuxfoundation.org>
References: <20150808220717.771230091@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48739
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

4.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit fcc53b5f6c38acbf5d311ffc3e0da517491c6f7b upstream.

Commit 6134d94923d0 ("MIPS: asm: fpu: Allow 64-bit FPU on MIPS32 R6")
added support for 64-bit FPU on a 32-bit MIPS R6 processor but it missed
the 64-bit CPU case leading to FPU failures when requesting FR=1 mode
(which is always the case for MIPS R6 userland) when running a 32-bit
kernel on a 64-bit CPU. We also fix the MIPS R2 case.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: 6134d94923d0 ("MIPS: asm: fpu: Allow 64-bit FPU on MIPS32 R6")
Reviewed-by: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10734/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/fpu.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/include/asm/fpu.h
+++ b/arch/mips/include/asm/fpu.h
@@ -74,7 +74,7 @@ static inline int __enable_fpu(enum fpu_
 		goto fr_common;
 
 	case FPU_64BIT:
-#if !(defined(CONFIG_CPU_MIPS32_R2) || defined(CONFIG_CPU_MIPS32_R6) \
+#if !(defined(CONFIG_CPU_MIPSR2) || defined(CONFIG_CPU_MIPSR6) \
       || defined(CONFIG_64BIT))
 		/* we only have a 32-bit FPU */
 		return SIGFPE;
