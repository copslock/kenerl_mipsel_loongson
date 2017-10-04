Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:32:01 +0200 (CEST)
Received: from mail-pf0-x229.google.com ([IPv6:2607:f8b0:400e:c00::229]:50195
        "EHLO mail-pf0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993859AbdJDX2Kf78ym (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:10 +0200
Received: by mail-pf0-x229.google.com with SMTP id m63so7039176pfk.7
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BddrgKn31CpUTm0zCt4HsSBbX2xA8RuRn6feEHDmkJU=;
        b=edZ7Gqlo5CbT2/YHiDw3oNzCeKNS9SYrtSpKPx782ZlOCi5TplHxicDWy9NmXsHk56
         +zgRe1YnRpYztDqnJnw/YyyPp3y1p+xmyGjksWT+JzyvTuSRNaspcc5N8PWLr4qa4gk/
         iJvsF9R1TRJeV9vQV8Kn1lFm5CyNW0Q3kPQhE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BddrgKn31CpUTm0zCt4HsSBbX2xA8RuRn6feEHDmkJU=;
        b=EKU1tO4D7INuB5Wq9WM8f/urIkfIUxPRSU4Afhxxqge/ogRV5qJL7KDNmvBhUfZeBm
         hMIRcy5bxtS+idR2AeOODCL0QfqGu5MWDvWJsYQ/JDJ4kkJ2N64KLFNHj49Xp6K9/UXZ
         Qwb6KgeTVdLfduYNtxAFqfba+zgL++fD07jwSsWTxLIYw+L29egz5NTYzpEaS3qe1iUn
         gjXYz65zEU4P7JEJKOvE2RJ/EGUHUH4UQH2cOCdCEQSUl3H4JtloENyMzCf4zWGmxk5W
         /0cEGOJ0JvfI0wL8vQRX7ZkSCH2mTcLcGpxmr4fn/4PQnygPvenS1NhEQwYKiLpA+ThP
         mdbA==
X-Gm-Message-State: AMCzsaV+jUe2P0a4HataoqaBpbyFa1em9UsCId9uhNMMjoDPrz1pRjWW
        eNcNnNwzzgG4b0lG204umvLVmA==
X-Google-Smtp-Source: AOwi7QBk3SsXS7BnmvPyZvdJtWCOyHHVv8pmxn+ic6k3gJwYvubxFE2RE5SPY2c/hl/3PKPrZzAMtA==
X-Received: by 10.99.163.97 with SMTP id v33mr14451531pgn.206.1507159684527;
        Wed, 04 Oct 2017 16:28:04 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id r68sm26296107pfi.7.2017.10.04.16.27.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:27:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Harish Patil <harish.patil@cavium.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        John Stultz <john.stultz@linaro.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Kalle Valo <kvalo@qca.qualcomm.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Len Brown <len.brown@intel.com>,
        Manish Chopra <manish.chopra@cavium.com>,
        Mark Gross <mark.gross@intel.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org,
        Oleg Nesterov <oleg@redhat.com>,
        Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        linux1394-devel@lists.sourceforge.net, linux-pm@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 09/13] timer: Remove users of expire and data arguments to DEFINE_TIMER
Date:   Wed,  4 Oct 2017 16:27:03 -0700
Message-Id: <1507159627-127660-10-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60265
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

The expire and data arguments of DEFINE_TIMER are only used in two places
and are ignored by the code (malta-display.c only uses mod_timer(),
never add_timer(), so the preset expires value is ignored). Set both
sets of arguments to zero.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Wim Van Sebroeck <wim@iguana.be>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-mips@linux-mips.org
Cc: linux-watchdog@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/mips/mti-malta/malta-display.c | 6 +++---
 drivers/watchdog/alim7101_wdt.c     | 4 ++--
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/mti-malta/malta-display.c b/arch/mips/mti-malta/malta-display.c
index d4f807191ecd..ac813158b9b8 100644
--- a/arch/mips/mti-malta/malta-display.c
+++ b/arch/mips/mti-malta/malta-display.c
@@ -36,10 +36,10 @@ void mips_display_message(const char *str)
 	}
 }
 
-static void scroll_display_message(unsigned long data);
-static DEFINE_TIMER(mips_scroll_timer, scroll_display_message, HZ, 0);
+static void scroll_display_message(unsigned long unused);
+static DEFINE_TIMER(mips_scroll_timer, scroll_display_message, 0, 0);
 
-static void scroll_display_message(unsigned long data)
+static void scroll_display_message(unsigned long unused)
 {
 	mips_display_message(&display_string[display_count++]);
 	if (display_count == max_display_count)
diff --git a/drivers/watchdog/alim7101_wdt.c b/drivers/watchdog/alim7101_wdt.c
index 665e0e7dfe1e..3c1f6ac68ea9 100644
--- a/drivers/watchdog/alim7101_wdt.c
+++ b/drivers/watchdog/alim7101_wdt.c
@@ -71,7 +71,7 @@ MODULE_PARM_DESC(use_gpio,
 		"Use the gpio watchdog (required by old cobalt boards).");
 
 static void wdt_timer_ping(unsigned long);
-static DEFINE_TIMER(timer, wdt_timer_ping, 0, 1);
+static DEFINE_TIMER(timer, wdt_timer_ping, 0, 0);
 static unsigned long next_heartbeat;
 static unsigned long wdt_is_open;
 static char wdt_expect_close;
@@ -87,7 +87,7 @@ MODULE_PARM_DESC(nowayout,
  *	Whack the dog
  */
 
-static void wdt_timer_ping(unsigned long data)
+static void wdt_timer_ping(unsigned long unused)
 {
 	/* If we got a heartbeat pulse within the WDT_US_INTERVAL
 	 * we agree to ping the WDT
-- 
2.7.4
