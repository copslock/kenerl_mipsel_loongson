Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Oct 2017 01:28:55 +0200 (CEST)
Received: from mail-pg0-x229.google.com ([IPv6:2607:f8b0:400e:c05::229]:43114
        "EHLO mail-pg0-x229.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990499AbdJDX2BeJckm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Oct 2017 01:28:01 +0200
Received: by mail-pg0-x229.google.com with SMTP id s184so5664412pgc.0
        for <linux-mips@linux-mips.org>; Wed, 04 Oct 2017 16:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DyYNDBB0laFeIDrnpi0e1qdhqriC7jebETEUFT84ZEo=;
        b=IvyM6BrfaeNhg/VB32LcMZospbasPr2CyrR8bEhLvW6o4MdZI9xfFASG5l08isyNVi
         aPQDG7h69eFq4Y5/U+zBrlxvsO7shNFGFuJ1bahmb5TC+HjOKmokcChFmRrAq4HuYqDj
         Vjhx1Zd1qMBY+NljKqk6UXeo21hIMF6LuN0yw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DyYNDBB0laFeIDrnpi0e1qdhqriC7jebETEUFT84ZEo=;
        b=A1MQ7MV3qCPmsbVoCuhy2Lz5UGeU7oiLMAyM/2SW72N0flgLDDL+5TqpbEi70wf0lJ
         07xS35L0Sdcb/7GMp7G5bijw1+fk3qrxgPlKl4SqemdfbHUvIlklG/9jkNQeCvaF2993
         4aAKcYv7/aGUpkjQCwp/4V80VjhZG4MlCc1QHLW6sGZOGVCNohTLdJI24DK5XdEoOjbM
         lgcVME7hwOL2BpiTyZZUn6He6pjroTe5MMvGE1vWsyCRdnXjwWeA8TG958Zk8sX0N4p6
         wubO/9AEGYYTotfcOUEb28dVAc02NVsr+EELvnX7Ric7v8paBVKIm+QTDzJ1WvG5xiXh
         AwDQ==
X-Gm-Message-State: AHPjjUiWkjsoLd7L4081QpCWXDSNsGx7gKOO9nf8bFYsw1SbKAo1dk3A
        AZ2WCRjaFaPIt8SgSHgFXGYpzQ==
X-Google-Smtp-Source: AOwi7QBMAWkrUkoN3du1GXkkZX7IeAY0dkbCjGTtaxa5je9MS4QHOHA9mmq5mr3n12+Zm5W6WNuyQw==
X-Received: by 10.101.80.140 with SMTP id r12mr19437032pgp.267.1507159675209;
        Wed, 04 Oct 2017 16:27:55 -0700 (PDT)
Received: from www.outflux.net (173-164-112-133-Oregon.hfc.comcastbusiness.net. [173.164.112.133])
        by smtp.gmail.com with ESMTPSA id w13sm7521100pgq.13.2017.10.04.16.27.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 04 Oct 2017 16:27:51 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Kees Cook <keescook@chromium.org>,
        Chris Metcalf <cmetcalf@mellanox.com>, netdev@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
        Michael Reed <mdr@sgi.com>, Oleg Nesterov <oleg@redhat.com>,
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
Subject: [PATCH 04/13] timer: Remove init_timer_pinned() in favor of timer_setup()
Date:   Wed,  4 Oct 2017 16:26:58 -0700
Message-Id: <1507159627-127660-5-git-send-email-keescook@chromium.org>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60257
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

This refactors the only users of init_timer_pinned() to use
the new timer_setup() and from_timer(). Drops the definition of
init_timer_pinned().

Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/net/ethernet/tile/tilepro.c | 9 ++++-----
 include/linux/timer.h               | 2 --
 2 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/tile/tilepro.c b/drivers/net/ethernet/tile/tilepro.c
index 49ccee4b9aec..56d06282fbde 100644
--- a/drivers/net/ethernet/tile/tilepro.c
+++ b/drivers/net/ethernet/tile/tilepro.c
@@ -608,9 +608,9 @@ static void tile_net_schedule_egress_timer(struct tile_net_cpu *info)
  * ISSUE: Maybe instead track number of expected completions, and free
  * only that many, resetting to zero if "pending" is ever false.
  */
-static void tile_net_handle_egress_timer(unsigned long arg)
+static void tile_net_handle_egress_timer(struct timer_list *t)
 {
-	struct tile_net_cpu *info = (struct tile_net_cpu *)arg;
+	struct tile_net_cpu *info = from_timer(info, t, egress_timer);
 	struct net_device *dev = info->napi.dev;
 
 	/* The timer is no longer scheduled. */
@@ -1004,9 +1004,8 @@ static void tile_net_register(void *dev_ptr)
 		BUG();
 
 	/* Initialize the egress timer. */
-	init_timer_pinned(&info->egress_timer);
-	info->egress_timer.data = (long)info;
-	info->egress_timer.function = tile_net_handle_egress_timer;
+	timer_setup(&info->egress_timer, tile_net_handle_egress_timer,
+		    TIMER_PINNED);
 
 	u64_stats_init(&info->stats.syncp);
 
diff --git a/include/linux/timer.h b/include/linux/timer.h
index b10c4bdc6fbd..9da903562ed4 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -128,8 +128,6 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 
 #define init_timer(timer)						\
 	__init_timer((timer), 0)
-#define init_timer_pinned(timer)					\
-	__init_timer((timer), TIMER_PINNED)
 #define init_timer_deferrable(timer)					\
 	__init_timer((timer), TIMER_DEFERRABLE)
 
-- 
2.7.4
