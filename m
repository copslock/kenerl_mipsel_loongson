Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 May 2015 21:11:32 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:43750 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026380AbbEBTKrvAwZZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 May 2015 21:10:47 +0200
Received: from localhost (unknown [87.213.45.130])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 1ABB99F2;
        Sat,  2 May 2015 19:10:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 041/220] MIPS: unaligned: Fix regular load/store instruction emulation for EVA
Date:   Sat,  2 May 2015 20:59:16 +0200
Message-Id: <20150502185856.151918950@linuxfoundation.org>
X-Mailer: git-send-email 2.3.7
In-Reply-To: <20150502185854.333748961@linuxfoundation.org>
References: <20150502185854.333748961@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47205
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

4.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Markos Chandras <markos.chandras@imgtec.com>

commit 6eae35485b26f9e51ab896eb8a936bed9908fdf6 upstream.

When emulating a regular lh/lw/lhu/sh/sw we need to use the appropriate
instruction if we are in EVA mode. This is necessary for userspace
applications which trigger alignment exceptions. In such case, the
userspace load/store instruction needs to be emulated with the correct
eva/non-eva instruction by the kernel emulator.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: c1771216ab48 ("MIPS: kernel: unaligned: Handle unaligned accesses for EVA")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/9503/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/unaligned.c |   52 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 47 insertions(+), 5 deletions(-)

--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -1023,7 +1023,15 @@ static void emulate_load_store_insn(stru
 		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
 
-		LoadHW(addr, value, res);
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				LoadHW(addr, value, res);
+			else
+				LoadHWE(addr, value, res);
+		} else {
+			LoadHW(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -1034,7 +1042,15 @@ static void emulate_load_store_insn(stru
 		if (!access_ok(VERIFY_READ, addr, 4))
 			goto sigbus;
 
-		LoadW(addr, value, res);
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				LoadW(addr, value, res);
+			else
+				LoadWE(addr, value, res);
+		} else {
+			LoadW(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -1045,7 +1061,15 @@ static void emulate_load_store_insn(stru
 		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
 
-		LoadHWU(addr, value, res);
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				LoadHWU(addr, value, res);
+			else
+				LoadHWUE(addr, value, res);
+		} else {
+			LoadHWU(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -1104,7 +1128,16 @@ static void emulate_load_store_insn(stru
 
 		compute_return_epc(regs);
 		value = regs->regs[insn.i_format.rt];
-		StoreHW(addr, value, res);
+
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				StoreHW(addr, value, res);
+			else
+				StoreHWE(addr, value, res);
+		} else {
+			StoreHW(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		break;
@@ -1115,7 +1148,16 @@ static void emulate_load_store_insn(stru
 
 		compute_return_epc(regs);
 		value = regs->regs[insn.i_format.rt];
-		StoreW(addr, value, res);
+
+		if (config_enabled(CONFIG_EVA)) {
+			if (segment_eq(get_fs(), get_ds()))
+				StoreW(addr, value, res);
+			else
+				StoreWE(addr, value, res);
+		} else {
+			StoreW(addr, value, res);
+		}
+
 		if (res)
 			goto fault;
 		break;
