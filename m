Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Nov 2017 22:50:24 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:41673
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990765AbdKWVuSDiIaH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Nov 2017 22:50:18 +0100
Received: by mail-lf0-x243.google.com with SMTP id f134so23335294lfg.8;
        Thu, 23 Nov 2017 13:50:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=4qShSJV99C1epi9pb9j2K0TSaIFWlT8Q6ac/YoulFKo=;
        b=lNk/ZifgeURT5wlVRej7488KOZ4Qq4aNQhl4+j2gxpNkgfKVV2y1MSGil2Ay1D/bFd
         ux1+Gv8zWLZqzXfVYAGyZSKVHkXbQe/iJ93WeggYTlHT+YqMtyvr+Ms/MiB86VCugSoU
         XkDkZUpf5AzABGIFXkyYU2UQoHuJPwI6/8dyJc0Qc21poeF2lrqDXHoKLh7wlXdu0FJG
         1c/GwbDaQvS4AHER1bh5/wziXz6LLX7luVhuqk2rZ7ngu6JAQZIbnvcZvrX75Dq5LFnf
         6cZpM/Lh7U1GkW+fn+QZkQFoKd1h6CRSb0nsMKsEmh0dfm5C0ApcFff8PiZZD5a+dxQy
         D8hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=4qShSJV99C1epi9pb9j2K0TSaIFWlT8Q6ac/YoulFKo=;
        b=PRVbqOmiydpYyLy06bnybdZ2wSTdfj5roZo4ya6beImrRtuuZi9XbYUPzTBBZOM/y3
         QKiU82Sar7v+iCVik5OrD4KSEWrZlCD+cQmLd8u/A5jLwS6wbN0nm0QgdvHCxYhfQfNs
         KNmSuqBmxd1Xsw1A1aiKXkKBMCjWc1tJ/2xkYn8SIPZFO9/aijqsUCghmZ6tSHGhTI/t
         JB3x+lF7TubigYcfI9BbMtfETTGE+1WdHYsr4fT2tdWxbjjTqnQAC6zWcJq7YGs35yoA
         mvxWoEprCeht1CCIkvqV03jwqULGwKXWjZgO79qfJlOmT23dAePq3Qn3yOY7M+04Zse7
         soAw==
X-Gm-Message-State: AJaThX6B08BxPh0M6MFUI4o+REi3ojI/IysINmzmRbwp8OSPsC6Lwt+P
        wQVZpyuxAWLT1FbL/Snu7Gc2LZrE
X-Google-Smtp-Source: AGs4zMbm095drSW/mq2kkR8GGIeEYSJ19qodEHucTGnDUC+Swm5Yk0J6f/z5fBHe+XXzoWW+Bn1e1w==
X-Received: by 10.25.72.135 with SMTP id v129mr7769529lfa.113.1511473812019;
        Thu, 23 Nov 2017 13:50:12 -0800 (PST)
Received: from localhost.localdomain ([195.254.138.66])
        by smtp.gmail.com with ESMTPSA id z68sm3603378lje.26.2017.11.23.13.50.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 23 Nov 2017 13:50:09 -0800 (PST)
From:   Vasyl Gomonovych <gomonovych@gmail.com>
To:     ralf@linux-mips.org, paul.gortmaker@windriver.com,
        jhogan@kernel.org, linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, gomonovych@gmail.com
Subject: [PATCH] MIPS: TXx9: Add missing iounmap
Date:   Thu, 23 Nov 2017 22:49:55 +0100
Message-Id: <1511473795-20137-1-git-send-email-gomonovych@gmail.com>
X-Mailer: git-send-email 1.9.1
Return-Path: <gomonovych@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gomonovych@gmail.com
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

Add the missing iounmap() before put_device and
return from txx9_sramc_init().

Signed-off-by: Vasyl Gomonovych <gomonovych@gmail.com>
---
 arch/mips/txx9/generic/setup.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 1791a44ee570..6ef5edb85d68 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -965,6 +965,8 @@ void __init txx9_sramc_init(struct resource *r)
 	}
 	return;
 exit_put:
+	if (dev->base)
+		iounmap(dev->base);
 	put_device(&dev->dev);
 	return;
 }
-- 
1.9.1
