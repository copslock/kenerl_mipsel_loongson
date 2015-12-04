Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 12:41:23 +0100 (CET)
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34579 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013159AbbLDLlWMVQ0x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2015 12:41:22 +0100
Received: by pfbg73 with SMTP id g73so25894203pfb.1;
        Fri, 04 Dec 2015 03:41:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=NnIyXtwoHJXAzIDT3VvYwcr09xvyP0525e/K7ViEuRo=;
        b=GE4ljmZGEoRzLvKgjjIHGY6pOT4SQeVzeOIjZxNQTe3dlQ9dgcAMI5mm3w6+phQzZ/
         TkZ/sXVqQy/VVUdd9WzQJ2tQ4cWAunzdbPtAjpQEXUHnhMemw8MpVAQ6/EjTRt9PQu82
         xpjUODYoNveL5D1gmk3O1/bnha2iYDlWKp9lgY53h86SrhgEWBPBy4BSa+YLQl2biuwV
         MTB+O4aYoCjjUQDT/Txv+J5aT6MUs4oe8w5GRLHUF2Kz/CsJ7xoFr7yTaiTJTVl2QWBD
         E2uZIru7zoPSPfZAWFO7hdUiYwrw6sFi1XFVIsMhT1XuTdphEom09Gl5H7IlGYSir9iV
         LSdA==
X-Received: by 10.98.65.206 with SMTP id g75mr20563734pfd.105.1449229276261;
        Fri, 04 Dec 2015 03:41:16 -0800 (PST)
Received: from yggdrasil (111-243-147-169.dynamic.hinet.net. [111.243.147.169])
        by smtp.gmail.com with ESMTPSA id t73sm16660795pfi.83.2015.12.04.03.41.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Dec 2015 03:41:15 -0800 (PST)
Date:   Fri, 4 Dec 2015 19:41:12 +0800
From:   Tony Wu <tung7970@gmail.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: [PATCH] MIPS: traps: remove unused variable
Message-ID: <20151204194034-tung7970@googlemail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tung7970@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tung7970@gmail.com
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

flags is indeed unused.

Signed-off-by: Tony Wu <tung7970@gmail.com>

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index e1c0203..ed1b356 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1401,7 +1401,6 @@ asmlinkage void do_cpu(struct pt_regs *regs)
 	unsigned long fcr31;
 	unsigned int cpid;
 	int status, err;
-	unsigned long __maybe_unused flags;
 	int sig;
 
 	prev_state = exception_enter();
