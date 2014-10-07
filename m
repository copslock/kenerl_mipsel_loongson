Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:31:30 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:51217 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010669AbaJGFapHOWJD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:30:45 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=I3SR4Q/d4aHJTkUJ5Y3TcLRykrT2is/gOCrUpJykK/E=;
        b=2AVU1WSm5W7j+0O6Np81P10ByPdZ5awONROIedEfs8wY4bXEI844lwiNtZrzuMM5D7gbI6Z6ac32sJowU/I3p6tpafFWZMocKRX7+XlZVDaRh172hpVd1anq17NVZa5p9x4Mog6tiGhehLXD2P7BkpvHQwUH/mEoNJ/7HqM8rfE=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNM6-002gzP-Sq
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:30:38 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32896 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNKZ-002Zv6-0R; Tue, 07 Oct 2014 05:29:03 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Guenter Roeck <linux@roeck-us.net>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>
Subject: [PATCH 03/44] hibernate: Call have_kernel_poweroff instead of checking pm_power_off
Date:   Mon,  6 Oct 2014 22:28:05 -0700
Message-Id: <1412659726-29957-4-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=0.3
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.54337A7F.0031,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 737
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42997
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

Poweroff handlers may now be installed with register_poweroff_handler.
Use the new API function have_kernel_poweroff to determine if a poweroff
handler has been installed.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 kernel/power/hibernate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a9dfa79..20353c5 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -602,7 +602,7 @@ static void power_down(void)
 	case HIBERNATION_PLATFORM:
 		hibernation_platform_enter();
 	case HIBERNATION_SHUTDOWN:
-		if (pm_power_off)
+		if (have_kernel_poweroff())
 			kernel_power_off();
 		break;
 #ifdef CONFIG_SUSPEND
-- 
1.9.1
