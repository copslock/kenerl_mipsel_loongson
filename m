Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 23:39:29 +0200 (CEST)
Received: from mail-pb0-f48.google.com ([209.85.160.48]:63708 "EHLO
        mail-pb0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835029Ab3FSVhpcSeNT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 23:37:45 +0200
Received: by mail-pb0-f48.google.com with SMTP id ma3so5460784pbc.7
        for <multiple recipients>; Wed, 19 Jun 2013 14:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=cF1ZjKy9PshMzDLCmTTjK+6q+YhiWkrOjT5q3DhAmEQ=;
        b=eqmZ3z9QAPzUCSxnuP8JnOmequk92CHN6BlBwK4CzIarDZIA2Tm2H30XPHHoQY/R2T
         EgWmckZ/GGr+m1hd0AuNBVH8pqZAWujU6GDfjuZgjaxB2fXI1/hOaxFzFmag0Ja/X7Qb
         j+3k/2RohYajxZY14SAgTbL+InG1f+tWy4aqzhOYXueKMcaupjfIaFZNb11RMxs4Y1cS
         rDTcVxdeAnNEWk+kBdmXS/Y3jYA1vPTZv1z39/00vQeBM7022Sg/pbxXhEY/2k8447eW
         qC/9yZwA1/4bKPGwVU4QgToImCbsaD2YANH241+Om85MfqylooU2D+Eg/0TGYcs3ZDez
         /iQQ==
X-Received: by 10.66.122.67 with SMTP id lq3mr6907409pab.147.1371677858316;
        Wed, 19 Jun 2013 14:37:38 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p2sm26359261pag.22.2013.06.19.14.37.36
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 14:37:37 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5JLbZDN023968;
        Wed, 19 Jun 2013 14:37:35 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5JLbZp1023967;
        Wed, 19 Jun 2013 14:37:35 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Jamie Iles <jamie@jamieiles.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, linux-serial@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2 4/4] MIPS: Update cavium_octeon_defconfig
Date:   Wed, 19 Jun 2013 14:37:29 -0700
Message-Id: <1371677849-23912-5-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com>
References: <1371677849-23912-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37024
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
