Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Dec 2014 19:01:00 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:39547 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009905AbaLYR50EIj8h (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Dec 2014 18:57:26 +0100
Received: by mail-pa0-f48.google.com with SMTP id rd3so12035557pab.21;
        Thu, 25 Dec 2014 09:57:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=YZzf0izXoq7wKTORpw7FTIQb7YPXmBG4SL95aKiphoM=;
        b=Pw1sDXBajmFwERkbqS7lK2Ko+ePKo3EVC4YanWxX2OfNrAduPkHU+4mld7oMwGD37w
         uqP7W5d81WdUMwPgyuRtX7/v8jtArLtxrlVxXRFoR9XIzwPNriZO6qkF7cW4KWQu0V94
         GHgTNUKHoeJK+PoJ6Ms0Vu7NNkQVLiN9T8TPNz4mC2/GWnASU4LBsSckxKFAzR5iNIL3
         94lcxZwqYGZLSFDSd8qNzyiQ00cYIZ4ZrUxzhZYABupSUTkx8QMcK+KcXGmPY8+QVSjQ
         4IFQD5wUb1f2Z9Xq3ep6CrpaeKhXt9a5rWu0UeinD80NYIumE1myqiNNSP3f0tSZmEOT
         7U7Q==
X-Received: by 10.68.201.233 with SMTP id kd9mr61869283pbc.149.1419530240423;
        Thu, 25 Dec 2014 09:57:20 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id e9sm25964046pdp.59.2014.12.25.09.57.18
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 25 Dec 2014 09:57:19 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jaedon.shin@gmail.com, abrestic@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net, jogo@openwrt.org,
        arnd@arndb.de, computersforpeace@gmail.com,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V6 13/25] MIPS: Fall back to the generic restart notifier
Date:   Thu, 25 Dec 2014 09:49:08 -0800
Message-Id: <1419529760-9520-14-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
References: <1419529760-9520-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44923
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
