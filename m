Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Jun 2013 21:15:03 +0200 (CEST)
Received: from mail-pb0-f53.google.com ([209.85.160.53]:58787 "EHLO
        mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834873Ab3FRTNOSVGAt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Jun 2013 21:13:14 +0200
Received: by mail-pb0-f53.google.com with SMTP id xb12so4218819pbc.12
        for <multiple recipients>; Tue, 18 Jun 2013 12:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cF1ZjKy9PshMzDLCmTTjK+6q+YhiWkrOjT5q3DhAmEQ=;
        b=IuxodPb0oS9VbxTwBzZKWn7/LB1mlPO+X8AllNXPjDyRruiYgoOiwQbaooXxiGoxEN
         ujoufPmt/11YRRGoOc3NiCcXrdIQDQ1Z0hLXpLjrfeT5N8LSZW0ZwkJvB/R7/lnvcSP1
         04DRQyeHDy6RAD7zeKPedllw/THIIPHzsOE+JQa2Vt5qp6VaAitxp9OXkNl2KH2b8U/l
         BrOep/megB7QjRe0S/hClYACMgOfRVYDZTA44Lkt11djISpaSWl/htM+bSrfbzPoHsYu
         ns/xYvKW3F5bPlJ94VHBIByJtC6Y/a0DFeT7Lv89f/NPqncdceZUO8rr4naB5nGEi8r4
         78FQ==
X-Received: by 10.66.21.37 with SMTP id s5mr3296318pae.103.1371582787774;
        Tue, 18 Jun 2013 12:13:07 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id xd2sm20908950pac.15.2013.06.18.12.13.04
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 18 Jun 2013 12:13:06 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5IJD3WQ012200;
        Tue, 18 Jun 2013 12:13:03 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5IJD36R012199;
        Tue, 18 Jun 2013 12:13:03 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 5/5] MIPS: Update cavium_octeon_defconfig
Date:   Tue, 18 Jun 2013 12:12:55 -0700
Message-Id: <1371582775-12141-6-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371582775-12141-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

The serial port changes make it advisable to enable the proper UART
drivers.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/configs/cavium_octeon_defconfig | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/configs/cavium_octeon_defconfig b/arch/mips/configs/cavium_octeon_defconfig
index 1888e5f..dace582 100644
--- a/arch/mips/configs/cavium_octeon_defconfig
+++ b/arch/mips/configs/cavium_octeon_defconfig
@@ -1,13 +1,11 @@
 CONFIG_CAVIUM_OCTEON_SOC=y
 CONFIG_CAVIUM_CN63XXP1=y
 CONFIG_CAVIUM_OCTEON_CVMSEG_SIZE=2
-CONFIG_SPARSEMEM_MANUAL=y
 CONFIG_TRANSPARENT_HUGEPAGE=y
 CONFIG_SMP=y
 CONFIG_NR_CPUS=32
 CONFIG_HZ_100=y
 CONFIG_PREEMPT=y
-CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
 CONFIG_BSD_PROCESS_ACCT=y
@@ -50,7 +48,6 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 # CONFIG_FW_LOADER is not set
 CONFIG_MTD=y
 # CONFIG_MTD_OF_PARTS is not set
-CONFIG_MTD_CHAR=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
 CONFIG_MTD_CFI_AMDSTD=y
@@ -114,6 +111,7 @@ CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_8250_NR_UARTS=2
 CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_DW=y
 # CONFIG_HW_RANDOM is not set
 CONFIG_I2C=y
 CONFIG_I2C_OCTEON=y
-- 
1.7.11.7
