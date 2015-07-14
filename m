Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jul 2015 18:48:45 +0200 (CEST)
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36600 "EHLO
        mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010577AbbGNQr2pTszn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Jul 2015 18:47:28 +0200
Received: by obnw1 with SMTP id w1so9712079obn.3
        for <linux-mips@linux-mips.org>; Tue, 14 Jul 2015 09:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=subject:to:from:cc:date:message-id:in-reply-to:references
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=7trYJeZ1Tj+ZUSpeSYDxvHKu3jE/1nVuoBRAT29HRks=;
        b=pKPIUSQD/WC7CxgSR4LNM1NGbM23Ii+sROqSsTLQc0KrDX1IgozpqdIDyfqpTmz0h0
         valCwBjC23Rd1Vwtab5fjcRodT3ognTsUIjLVUOZPSSBLoykgB9ZS1v4srqmQcIYv6aS
         LlHyzXt3bvuyq22R3M15CzqeU4L+efVH0C5N1X7++f4CuCKgxkrtfB0rrZgS+uYc6yQA
         v62vPbeXAeKo0X/DwFb4e+GGP4N+4jHYSk+fFoewqOoLMayPcceO46y4Bb+3b865hAC3
         gzn4xWcGZQe5ydgTIKx2EYJnndsh/Ak3erq19QdE7bwoq7j/Rm70/y/R4KJs8nQTzIDy
         1AQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:from:cc:date:message-id:in-reply-to
         :references:user-agent:mime-version:content-type
         :content-transfer-encoding;
        bh=7trYJeZ1Tj+ZUSpeSYDxvHKu3jE/1nVuoBRAT29HRks=;
        b=jREBoF5kF/FMK9jV8i1UAG/ppOdeaNqWAvkiNPSqvtJnmrsJuuBPpeQ7wxd8ma0UNw
         NsStr1HYc+iMm94sj5XmdL95YYH1WoxG1V+YHwoUa4b0jkuyZKLnJMdZyF5C3chdX8zq
         zUS/0tuuohb4qH5IZBsmD7wRlV91GJaXXjp1SP7+Yo73bgXDsUXVd+ktiPLa4kuRcbV8
         8AS1FAkp0G2xYU+bSyRFCg8z0uRr/ta9PKNcuuIw59gSOw4N8HcAh5nckQ3mjnFYtPCL
         LTqU8Zlerq6xikTtYrrtiZrPR4oEE/i78Qdmy1ULJhljecKPDBVhLcTxMEKjjAvCglXf
         gc1g==
X-Gm-Message-State: ALoCoQkz1VhOvyE4eYAq39I3BVKNwkrESrpgcH1gZxxwJAwzgXTY6Y0md/qC38Kt9SVwnC+euOzS
X-Received: by 10.182.114.138 with SMTP id jg10mr37452923obb.55.1436892443127;
        Tue, 14 Jul 2015 09:47:23 -0700 (PDT)
Received: from localhost ([69.71.1.1])
        by smtp.gmail.com with ESMTPSA id yo9sm766212obc.3.2015.07.14.09.47.20
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Jul 2015 09:47:21 -0700 (PDT)
Subject: [PATCH v2 8/8] MIPS: Remove "__weak" definition from arch-specific
 linkage.h
To:     Ralf Baechle <ralf@linux-mips.org>
From:   Bjorn Helgaas <bhelgaas@google.com>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>,
        linux-kernel@vger.kernel.org
Date:   Tue, 14 Jul 2015 11:47:19 -0500
Message-ID: <20150714164719.1541.13701.stgit@bhelgaas-glaptop2.roam.corp.google.com>
In-Reply-To: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
References: <20150714164142.1541.92710.stgit@bhelgaas-glaptop2.roam.corp.google.com>
User-Agent: StGit/0.16
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-Path: <bhelgaas@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bhelgaas@google.com
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

"__weak" is defined in include/linux/compiler-gcc.h.  We shouldn't need an
arch-specific definition.

Remove the "__weak" definition from arch/mips/include/asm/linkage.h.

Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/linkage.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/include/asm/linkage.h b/arch/mips/include/asm/linkage.h
index 2767dda..99651b0 100644
--- a/arch/mips/include/asm/linkage.h
+++ b/arch/mips/include/asm/linkage.h
@@ -5,7 +5,6 @@
 #include <asm/asm.h>
 #endif
 
-#define __weak __attribute__((weak))
 #define cond_syscall(x) asm(".weak\t" #x "\n" #x "\t=\tsys_ni_syscall")
 #define SYSCALL_ALIAS(alias, name)					\
 	asm ( #alias " = " #name "\n\t.globl " #alias)
