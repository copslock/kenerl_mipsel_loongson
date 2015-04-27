Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 01:35:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8188 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011886AbbD0XfjT3bRK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 01:35:39 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id BEEB8472749B6;
        Tue, 28 Apr 2015 00:35:30 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 28 Apr
 2015 00:35:35 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 28 Apr
 2015 00:35:35 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Mon, 27 Apr
 2015 16:35:29 -0700
Subject: [PATCH] MIPS: R6: memcpy bugfix - zero length overwrites memory
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <markos.chandras@imgtec.com>,
        <ralf@linux-mips.org>, <linux-kernel@vger.kernel.org>
Date:   Mon, 27 Apr 2015 16:35:29 -0700
Message-ID: <20150427233529.4423.20839.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

MIPS R6 version of memcpy has bug - then length to copy is zero
and addresses are not aligned then it can overwrite a whole memory.

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/lib/memcpy.S |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index 9245e1705e69..7e0250f3aec8 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -514,6 +514,8 @@
 
 #ifdef CONFIG_CPU_MIPSR6
 .Lcopy_unaligned_bytes\@:
+	beqz    len, .Ldone\@
+	 nop
 1:
 	COPY_BYTE(0)
 	COPY_BYTE(1)
