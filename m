Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Dec 2016 19:14:58 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:44298 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993317AbcLTSMitXuA2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Dec 2016 19:12:38 +0100
From:   John Crispin <john@phrozen.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 6/7] arch: mips: ralink: add missing symbol for highmem support
Date:   Tue, 20 Dec 2016 19:12:45 +0100
Message-Id: <1482257566-61035-7-git-send-email-john@phrozen.org>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1482257566-61035-1-git-send-email-john@phrozen.org>
References: <1482257566-61035-1-git-send-email-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

MT7621 has highmem. this was previously not working as the required symbol
was not selected in the Kconfig file.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/ralink/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/ralink/Kconfig b/arch/mips/ralink/Kconfig
index 813826a..9825dee 100644
--- a/arch/mips/ralink/Kconfig
+++ b/arch/mips/ralink/Kconfig
@@ -46,6 +46,7 @@ choice
 		select SYS_SUPPORTS_MULTITHREADING
 		select SYS_SUPPORTS_SMP
 		select SYS_SUPPORTS_MIPS_CPS
+		select SYS_SUPPORTS_HIGHMEM
 		select MIPS_GIC
 		select COMMON_CLK
 		select CLKSRC_MIPS_GIC
-- 
1.7.10.4
