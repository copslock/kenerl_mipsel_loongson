Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:43:01 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56109 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006209AbbHNRm74xQb1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:42:59 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id A8ABB323;
        Fri, 14 Aug 2015 17:42:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Cowgill <James.Cowgill@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 01/84] MIPS: unaligned: Fix build error on big endian R6 kernels
Date:   Fri, 14 Aug 2015 10:41:29 -0700
Message-Id: <20150814174210.260199305@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174210.214822912@linuxfoundation.org>
References: <20150814174210.214822912@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48897
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

From: James Cowgill <James.Cowgill@imgtec.com>

commit 531a6d599f4304156236ebdd531aaa80be61868d upstream.

Commit eeb538950367 ("MIPS: unaligned: Prevent EVA instructions on kernel
unaligned accesses") renamed the Load* and Store* defines in unaligned.c
to _Load* and _Store* as part of its fix. One define was missed out which
causes big endian R6 kernels to fail to build.

arch/mips/kernel/unaligned.c:880:35:
error: implicit declaration of function '_StoreDW'
 #define StoreDW(addr, value, res) _StoreDW(addr, value, res)
                                   ^

Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
Fixes: eeb538950367 ("MIPS: unaligned: Prevent EVA instructions on kernel unaligned accesses")
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10575/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/unaligned.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -438,7 +438,7 @@ do {
 		: "memory");                                \
 } while(0)
 
-#define     StoreDW(addr, value, res) \
+#define     _StoreDW(addr, value, res) \
 do {                                                        \
 		__asm__ __volatile__ (                      \
 			".set\tpush\n\t"		    \
