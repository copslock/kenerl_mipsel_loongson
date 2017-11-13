Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2017 13:56:39 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:51694 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbdKMM4cQ7iDS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2017 13:56:32 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id B5AF9AAC;
        Mon, 13 Nov 2017 12:56:25 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 3.18 24/28] MIPS: Fix CM region target definitions
Date:   Mon, 13 Nov 2017 13:55:18 +0100
Message-Id: <20171113125403.054604675@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171113125400.803506921@linuxfoundation.org>
References: <20171113125400.803506921@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60853
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

3.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@mips.com>

commit 6a6cba1d945a7511cdfaf338526871195e420762 upstream.

The default CM target field in the GCR_BASE register is encoded with 0
meaning memory & 1 being reserved. However the definitions we use for
those bits effectively get these two values backwards - likely because
they were copied from the definitions for the CM regions where the
target is encoded differently. This results in use setting up GCR_BASE
with the reserved target value by default, rather than targeting memory
as intended. Although we currently seem to get away with this it's not a
great idea to rely upon.

Fix this by changing our macros to match the documentated target values.

The incorrect encoding became used as of commit 9f98f3dd0c51 ("MIPS: Add
generic CM probe & access code") in the Linux v3.15 cycle, and was
likely carried forwards from older but unused code introduced by
commit 39b8d5254246 ("[MIPS] Add support for MIPS CMP platform.") in the
v2.6.26 cycle.

Fixes: 9f98f3dd0c51 ("MIPS: Add generic CM probe & access code")
Signed-off-by: Paul Burton <paul.burton@mips.com>
Reported-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: James Hogan <jhogan@kernel.org>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # v3.15+
Patchwork: https://patchwork.linux-mips.org/patch/17562/
Signed-off-by: James Hogan <jhogan@kernel.org>
[jhogan@kernel.org: Backported 3.15..4.13]
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/include/asm/mips-cm.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/include/asm/mips-cm.h
+++ b/arch/mips/include/asm/mips-cm.h
@@ -173,8 +173,8 @@ BUILD_CM_Cx_R_(tcid_8_priority,	0x80)
 #define CM_GCR_BASE_GCRBASE_MSK			(_ULCAST_(0x1ffff) << 15)
 #define CM_GCR_BASE_CMDEFTGT_SHF		0
 #define CM_GCR_BASE_CMDEFTGT_MSK		(_ULCAST_(0x3) << 0)
-#define  CM_GCR_BASE_CMDEFTGT_DISABLED		0
-#define  CM_GCR_BASE_CMDEFTGT_MEM		1
+#define  CM_GCR_BASE_CMDEFTGT_MEM		0
+#define  CM_GCR_BASE_CMDEFTGT_RESERVED		1
 #define  CM_GCR_BASE_CMDEFTGT_IOCU0		2
 #define  CM_GCR_BASE_CMDEFTGT_IOCU1		3
 
