Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 18:34:03 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58872 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994676AbeC0QdzGHWIe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 18:33:55 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 7B5FD11C0;
        Tue, 27 Mar 2018 16:33:48 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, NeilBrown <neil@brown.name>,
        John Crispin <john@phrozen.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 001/101] MIPS: ralink: Remove ralink_halt()
Date:   Tue, 27 Mar 2018 18:26:33 +0200
Message-Id: <20180327162750.092111711@linuxfoundation.org>
X-Mailer: git-send-email 2.16.3
In-Reply-To: <20180327162749.993880276@linuxfoundation.org>
References: <20180327162749.993880276@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63254
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: NeilBrown <neil@brown.name>

commit 891731f6a5dbe508d12443175a7e166a2fba616a upstream.

ralink_halt() does nothing that machine_halt() doesn't already do, so it
adds no value.

It actually causes incorrect behaviour due to the "unreachable()" at the
end. This tells the compiler that the end of the function will never be
reached, which isn't true. The compiler responds by not adding a
'return' instruction, so control simply moves on to whatever bytes come
afterwards in memory. In my tested, that was the ralink_restart()
function. This means that an attempt to 'halt' the machine would
actually cause a reboot.

So remove ralink_halt() so that a 'halt' really does halt.

Fixes: c06e836ada59 ("MIPS: ralink: adds reset code")
Signed-off-by: NeilBrown <neil@brown.name>
Cc: John Crispin <john@phrozen.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 3.9+
Patchwork: https://patchwork.linux-mips.org/patch/18851/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/ralink/reset.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/arch/mips/ralink/reset.c
+++ b/arch/mips/ralink/reset.c
@@ -96,16 +96,9 @@ static void ralink_restart(char *command
 	unreachable();
 }
 
-static void ralink_halt(void)
-{
-	local_irq_disable();
-	unreachable();
-}
-
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = ralink_restart;
-	_machine_halt = ralink_halt;
 
 	return 0;
 }
