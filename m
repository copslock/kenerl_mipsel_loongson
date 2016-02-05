Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Feb 2016 01:57:21 +0100 (CET)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36307 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010427AbcBEAnPUEOXl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Feb 2016 01:43:15 +0100
Received: by mail-pa0-f65.google.com with SMTP id gc2so666899pab.3;
        Thu, 04 Feb 2016 16:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NkZLFQ6NGMt9OsrGzgsL6YkQoFiOmDi08gEuE2HtmfA=;
        b=t9N4YEhA1mAl/HlD4Lvj2F6eTxVUgb6SHbsJblWnSfZDfVhUu/69pKYGeptI7K5K+O
         Y/yUzy4ztRpdEpoEzhBdotewmoWwhmCvMvvbe0fb8FAo6PBp6UwY6mlAY9JdVj8BG8Ud
         HUyKqEsLiTVPyqA0liGMOsyK/ujY8xx0c1l8VA2kExH+lsaWO1rccEq7SdtHKK7Gpt/m
         iw+FZOK1tYq44YonalyXALeLFun6yEXveLacvpko6l26pZSvxdLDbMDygDk6zcThdkBQ
         obFJOcVyirKRPZbmExly72eV8vAHDbb3fHZXyXSTiynUY0lL3Gn2E4aYoRjnerMAfVTZ
         g0Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NkZLFQ6NGMt9OsrGzgsL6YkQoFiOmDi08gEuE2HtmfA=;
        b=fBeD9e0+DtSEX79SE+ySC0DSGnPNqL0h26oupEdvJk3tqmKuaQ8jxYC6yZh9huR5UB
         CUQcV9G1ErQvZSUYA85pEmuE9ypwtYkRguTXp6P125CmNdY4n/zHHyno79aAJ4Jm99Cg
         RSz1os9YETdm5BkZN4j393wkCFdQYJBnEXrrCadmjFmTAaSgc7Fjl4GzZPZjJznNDjI1
         tiSUsxXxfaMjD9C2RWeyxN5FhsxYBqaMUOz+nL4Cx8F3NcxHpaHxGADYaBYa3TiP1jND
         Hyz6UoBabribjk59RXAKoUdrshUPoAxrw7dJMD2+H9uMXgVUBwdxu0dJow80YDPbgRjY
         xhDw==
X-Gm-Message-State: AG10YOR/pr1yH1jmi8toTBKWhiU0TF/oAUtl3ibgCwCiD/pZ1oP9VqSXCsmDFZP0xfzFIA==
X-Received: by 10.66.90.133 with SMTP id bw5mr15566796pab.22.1454632989734;
        Thu, 04 Feb 2016 16:43:09 -0800 (PST)
Received: from dl.caveonetworks.com ([64.2.3.194])
        by smtp.gmail.com with ESMTPSA id s90sm14258384pfa.49.2016.02.04.16.43.04
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 04 Feb 2016 16:43:08 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id u150h4uR007735;
        Thu, 4 Feb 2016 16:43:04 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id u150h3B5007734;
        Thu, 4 Feb 2016 16:43:03 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 2/7] MIPS: Select CONFIG_HANDLE_DOMAIN_IRQ and make it work.
Date:   Thu,  4 Feb 2016 16:42:49 -0800
Message-Id: <1454632974-7686-3-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
References: <1454632974-7686-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51801
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

Per the subject, always select HANDLE_DOMAIN_IRQ, and implement
set_irq_regs() so that it actually works.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/Kconfig                |  1 +
 arch/mips/include/asm/irq_regs.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 57a945e..9a0a780 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -62,6 +62,7 @@ config MIPS
 	select HAVE_IRQ_TIME_ACCOUNTING
 	select GENERIC_TIME_VSYSCALL
 	select ARCH_CLOCKSOURCE_DATA
+	select HANDLE_DOMAIN_IRQ
 
 menu "Machine selection"
 
diff --git a/arch/mips/include/asm/irq_regs.h b/arch/mips/include/asm/irq_regs.h
index 33bd2a0..8c48d6d 100644
--- a/arch/mips/include/asm/irq_regs.h
+++ b/arch/mips/include/asm/irq_regs.h
@@ -18,4 +18,14 @@ static inline struct pt_regs *get_irq_regs(void)
 	return current_thread_info()->regs;
 }
 
+static inline struct pt_regs *set_irq_regs(struct pt_regs *new_regs)
+{
+	struct pt_regs *old_regs;
+
+	old_regs = get_irq_regs();
+	current_thread_info()->regs = new_regs;
+
+	return old_regs;
+}
+
 #endif /* __ASM_IRQ_REGS_H */
-- 
1.7.11.7
