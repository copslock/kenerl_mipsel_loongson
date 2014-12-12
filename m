Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Dec 2014 23:11:46 +0100 (CET)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:41534 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008560AbaLLWIkKoVTj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Dec 2014 23:08:40 +0100
Received: by mail-pa0-f52.google.com with SMTP id eu11so8059622pac.39
        for <multiple recipients>; Fri, 12 Dec 2014 14:08:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZzf0izXoq7wKTORpw7FTIQb7YPXmBG4SL95aKiphoM=;
        b=yyHSjsUoanRHyVKyrvQ07ijmPhUClIamxbF7t3es7VfDVbWQNj3k8d5dZVqqpW1vh5
         b1MMS7HDD3/2JwRHSQboseetVSU2P2ojqUkBibUYNAwnJ+pTejImq55iufXu81c9CZ6K
         V18XjBwChwDkKSYVgnh0+1IdFLRqY+q8KyRsGR4L8qI2a06Z6fu+hZot5VtDAMoEAPO+
         CJ6CHGayC6gnWZ+hbGw/nCR27oMfeC5/jnNMxURjruETVOH05l5XszrBwo78KPYBcOYM
         Rt9/KPDr1JYZiMEfU/q7VYhEp4nGn/k9GJONGbIJh/Pxm4J1TDc/XEa/4JBlON+HoeXc
         QMng==
X-Received: by 10.70.36.111 with SMTP id p15mr30461940pdj.122.1418422112711;
        Fri, 12 Dec 2014 14:08:32 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id tm3sm2425841pac.12.2014.12.12.14.08.31
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Dec 2014 14:08:32 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        jogo@openwrt.org, arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V5 11/23] MIPS: Fall back to the generic restart notifier
Date:   Fri, 12 Dec 2014 14:07:02 -0800
Message-Id: <1418422034-17099-12-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
References: <1418422034-17099-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

If the machine doesn't set its own _machine_restart callback, call the
common do_kernel_restart() instead.  This allows arch-independent reset
drivers from drivers/power/reset/ to be used to reboot the machine.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/reset.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 07fc524..cf23ab5 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -29,6 +29,8 @@ void machine_restart(char *command)
 {
 	if (_machine_restart)
 		_machine_restart(command);
+	else
+		do_kernel_restart(command);
 }
 
 void machine_halt(void)
-- 
2.1.1
