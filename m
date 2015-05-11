Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 May 2015 19:59:53 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:35747 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27027479AbbEKRzvCUOkb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 May 2015 19:55:51 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 9BF36BC2;
        Mon, 11 May 2015 17:55:45 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.0 26/72] MIPS: Kconfig: Disable SMP/CPS for 64-bit
Date:   Mon, 11 May 2015 10:54:32 -0700
Message-Id: <20150511175437.895870173@linuxfoundation.org>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <20150511175437.112151861@linuxfoundation.org>
References: <20150511175437.112151861@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47325
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

Commit 6ca716f2e5571d25a3899c6c5c91ff72ea6d6f5e upstream.

A 64-bit build for Malta produces far too many build problems
when SMP/CPS is selected. Moreover, there is currently no 64-bit
product with SMP/CPS so we disable SMP/CPS when building for
64-bit until it is properly supported.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/8573/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2142,7 +2142,7 @@ config MIPS_CMP
 
 config MIPS_CPS
 	bool "MIPS Coherent Processing System support"
-	depends on SYS_SUPPORTS_MIPS_CPS
+	depends on SYS_SUPPORTS_MIPS_CPS && !64BIT
 	select MIPS_CM
 	select MIPS_CPC
 	select MIPS_CPS_PM if HOTPLUG_CPU
