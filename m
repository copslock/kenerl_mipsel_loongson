Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:30:25 +0200 (CEST)
Received: from mail-pf0-x22d.google.com ([IPv6:2607:f8b0:400e:c00::22d]:54616
        "EHLO mail-pf0-x22d.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992592AbdJDX2GVNqHm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:06 +0200
Received: by mail-pf0-x22d.google.com with SMTP id m28so2101579pfi.11
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=/ksN2ZTyxjVi30ahu5yOG0nmZU/Q9UuZafn+U1M1r/c=;
        b=Ln53AfsKt/2WSRI6s2jdpSFttXU4i13lQjS7Y8g5U4v7m3FIwjhyfYG2pIW+oOpGTe
         gozWeW1BVaH5FnLotcROt31ojMKg9NDyUW64wD6C0LDbJm/Ggw8FMTRAxdY+oeKsWOQL
         YrW+Pf6/hE9U1sF+w/dsUzhdBuhdQp8nDkMEA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=/ksN2ZTyxjVi30ahu5yOG0nmZU/Q9UuZafn+U1M1r/c=;
        b=Ur/1P8mYKeWDlDMJ3teO7+yTisd9eh8qIyb6GKIa+OiU4FKEJE5Pwx8lqzPYNoUbVK
         Fji2etwqLpxpPEAqYL9IglygHvjG9PaexrGuYz4/caGLoAPOPZ/J/T8TY/W9oAKxxpZV
         LtuUspFSUnCRPMxsuf0pQSqZBM/7jyaGzRvVxPSWdEjCjmD+yDc7K3JSK7Yn/YK3X7W3
         BClLOV0DR/Bzv2fXGcXmoX5EoZgaYS5iS/+ZjoECHPWxJ76FmmoGxM/53nyCzl8fuMyq
         gPndG4r+fdoIL41pOQVJv8RHQt6iPy/zIQ+lEKpspTRZynhuSH7ZB3GBNWuPAC8pKe/f
         /Knw==
X-Gm-Message-State: AMCzsaUIJ3kY3OoGpVfOtcek9NIVkjlAUpsfV0E2A/n89/li4spq/X+j
        WMYBuBRLdkZs0kICNwrLhRtDsA==
X-Google-Smtp-Source: AOwi7QA7ZIT2W2pn4IAh1qFg59HD9EWLLSYN/5pw9+jMhHUx8uB24XiVjwas+6RWJ9sSYp+dTelWsA==
X-Received: by 10.98.166.86 with SMTP id t83mr302025pfe.345.1507159680293;
        Wed, 04 Oct 2017 16:28:00 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id i84sm31216391pfj.105.2017.10.04.16.27.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:27:57 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Ralf Baechle <ralf@linux-mips.org>,
        Sebastian Reichel <sre@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Wim Van Sebroeck <wim@iguana.be>,
        linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 08/13] timer: Remove unused static initializer macros
Date:   Wed,  4 Oct 2017 16:27:02 -0700
Message-Id: <1507159627-127660-9-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60261
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

This removes the now unused TIMER_*INITIALIZER macros:

TIMER_INITIALIZER
TIMER_PINNED_INITIALIZER
TIMER_DEFERRED_INITIALIZER
TIMER_PINNED_DEFERRED_INITIALIZER

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/timer.h | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 4f7476e4a727..a33220311361 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -73,18 +73,6 @@ struct timer_list {
 			__FILE__ ":" __stringify(__LINE__))	\
 	}
 
-#define TIMER_INITIALIZER(_function, _expires, _data)		\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), 0)
-
-#define TIMER_PINNED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_PINNED)
-
-#define TIMER_DEFERRED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_DEFERRABLE)
-
-#define TIMER_PINNED_DEFERRED_INITIALIZER(_function, _expires, _data)	\
-	__TIMER_INITIALIZER((_function), (_expires), (_data), TIMER_DEFERRABLE | TIMER_PINNED)
-
 #define DEFINE_TIMER(_name, _function, _expires, _data)		\
 	struct timer_list _name =				\
 		__TIMER_INITIALIZER(_function, _expires, _data, 0)
-- 
2.7.4
