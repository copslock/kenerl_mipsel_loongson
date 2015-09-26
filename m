Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 26 Sep 2015 23:07:47 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59011 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008925AbbIZVHgMBnMg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 26 Sep 2015 23:07:36 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 03834111F;
        Sat, 26 Sep 2015 21:07:23 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.1 009/159] MIPS: math-emu: Allow m{f,t}hc emulation on MIPS R6
Date:   Sat, 26 Sep 2015 13:54:15 -0700
Message-Id: <20150926205313.922294049@linuxfoundation.org>
X-Mailer: git-send-email 2.5.3
In-Reply-To: <20150926205313.363686083@linuxfoundation.org>
References: <20150926205313.363686083@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49378
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

commit e8f80cc1a6d80587136b015e989a12827e1fcfe5 upstream.

The mfhc/mthc instructions are supported on MIPS R6 so emulate
them if needed.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10737/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/math-emu/cp1emu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -1137,7 +1137,7 @@ emul:
 			break;
 
 		case mfhc_op:
-			if (!cpu_has_mips_r2)
+			if (!cpu_has_mips_r2_r6)
 				goto sigill;
 
 			/* copregister rd -> gpr[rt] */
@@ -1148,7 +1148,7 @@ emul:
 			break;
 
 		case mthc_op:
-			if (!cpu_has_mips_r2)
+			if (!cpu_has_mips_r2_r6)
 				goto sigill;
 
 			/* copregister rd <- gpr[rt] */
