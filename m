Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 Oct 2015 04:42:33 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:39053 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006195AbbJRCmamSrnd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 Oct 2015 04:42:30 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 221BD26C;
        Sun, 18 Oct 2015 02:42:24 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Huacai Chen <chenhc@lemote.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.2 203/258] MIPS: Fix console output for Fulong2e system
Date:   Sat, 17 Oct 2015 18:58:36 -0700
Message-Id: <20151018014739.609030397@linuxfoundation.org>
X-Mailer: git-send-email 2.6.1
In-Reply-To: <20151018014729.976101177@linuxfoundation.org>
References: <20151018014729.976101177@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49577
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

4.2-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

commit fc2ca674470bbfe11d72a20a3f19fd3dc43bfca0 upstream.

Commit 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
made the number of UARTs dynamic if LEFI_FIRMWARE_INTERFACE is configured.
Unfortunately, it did not initialize the number of UARTs if
LEFI_FIRMWARE_INTERFACE is not configured. As a result, the Fulong2e
system has no console.

Fixes: 3adeb2566b9b ("MIPS: Loongson: Improve LEFI firmware interface")
Acked-by: Huacai Chen <chenhc@lemote.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/11076/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/loongson64/common/env.c |    3 +++
 1 file changed, 3 insertions(+)

--- a/arch/mips/loongson64/common/env.c
+++ b/arch/mips/loongson64/common/env.c
@@ -64,6 +64,9 @@ void __init prom_init_env(void)
 	}
 	if (memsize == 0)
 		memsize = 256;
+
+	loongson_sysconf.nr_uarts = 1;
+
 	pr_info("memsize=%u, highmemsize=%u\n", memsize, highmemsize);
 #else
 	struct boot_params *boot_p;
