Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 18:13:55 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:40409 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991258AbdL1RN2TdH0B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 18:13:28 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eUbkD-0005gY-KH; Thu, 28 Dec 2017 17:13:25 +0000
Received: from ben by deadeye with local (Exim 4.90_RC3)
        (envelope-from <ben@decadent.org.uk>)
        id 1eUbk9-0007ga-Dy; Thu, 28 Dec 2017 17:13:21 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Matt Redfearn" <matt.redfearn@mips.com>,
        "James Hogan" <jhogan@kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Paul Burton" <paul.burton@mips.com>
Date:   Thu, 28 Dec 2017 17:05:44 +0000
Message-ID: <lsq.1514480744.561600054@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 154/204] MIPS: Fix CM region target definitions
In-Reply-To: <lsq.1514480743.579539031@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61676
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.52-rc1 review patch.  If anyone has any objections, please let me know.

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
Patchwork: https://patchwork.linux-mips.org/patch/17562/
Signed-off-by: James Hogan <jhogan@kernel.org>
[bwh: Backported to 3.16: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/mips-cm.h | 4 ++--
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
 
