Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 14:04:47 +0200 (CEST)
Received: from mail-lf0-f68.google.com ([209.85.215.68]:34259 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27032452AbcEUMBiY0FEI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 14:01:38 +0200
Received: by mail-lf0-f68.google.com with SMTP id 65so25317lfq.1;
        Sat, 21 May 2016 05:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=+bHz7ucxEEyzQlRPIQoN/Usbt15mNe3OYtf2H185y3Q=;
        b=BVDGJ4LV85mdX+0mA8dpt1IiYdgGNBDyIhAIxIxyW1Wh76X5YyDVDaPu5KtZMRXwUt
         M21fU/SvfALfKD+I9x5xart1UeYLgwBTg6PT5nOvDGxvcbjiVCA3jv8vsCpuR0SectFe
         cVBACmLbhg0r2x5Fs5tMIv36Yy+ex/o/QJbJIvp/mGbfTwbYBEzuk1L0w5fe7mkl/4zV
         vJxCs6UsVPAbJAD8Ja8SwbHae/JDSXF2sNXGaGYNnmDmyminFAx1z2IYbJVBXry/aQGS
         hWi0diUOGfsMofmhLM5S6R/9hzZSP4rl2ZZtspe/eKeL4UZfredFWmcjqyWMllnz2BfX
         HtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=+bHz7ucxEEyzQlRPIQoN/Usbt15mNe3OYtf2H185y3Q=;
        b=Ixc7NXvEVEslnLPiHa57i67pOIrbVjHZdaTuNZzfzE19KmKK45tbCD9bRnyJyvaZxd
         G00Lq0H1Lsm7CUkDqhPBAJZKK7udlu4vtYWNa+DpJ381iA/ddYZWmXgwslBjRJv5bg2Z
         2aUzn9tK9CdkU2Fse/SlJV5dF9d+ovoZqCHU4qYjpdEUEQqatxbZDurL4m7zar3e97zI
         F08g8dS9TkYQRoYDoChtLhzQwMj73dmGWGetyfXX/CgsFrOYxJFMG3D6l/mXYp5sZXvL
         +mlLJofH0a5IJJcSDcioNCdT0YYjWWt4RxZrYfoLCWi2TpkY5XQ+fvGs8MnxeJsxlKGZ
         zfPQ==
X-Gm-Message-State: AOPr4FVIcw7FYO8a38zpS3X0Le+P4h32jYKFfDyI6myON9H7AzRK/LSxl/WINVSow/Plnw==
X-Received: by 10.25.151.20 with SMTP id z20mr2754320lfd.92.1463832093113;
        Sat, 21 May 2016 05:01:33 -0700 (PDT)
Received: from glen.ipredator.se (anon-35-25.vpn.ipredator.se. [46.246.35.25])
        by smtp.gmail.com with ESMTPSA id wc3sm2086037lbb.27.2016.05.21.05.01.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 21 May 2016 05:01:31 -0700 (PDT)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     andrea.gelmini@gelma.net
Cc:     trivial@kernel.org, ralf@linux-mips.org, paul.burton@imgtec.com,
        macro@imgtec.com, james.hogan@imgtec.com, jslaby@suse.cz,
        adam.buchbinder@gmail.com, linux-mips@linux-mips.org
Subject: [PATCH 0194/1529] Fix typo
Date:   Sat, 21 May 2016 14:01:27 +0200
Message-Id: <20160521120127.10031-1-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 2.8.2.534.g1f66975
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53592
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
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

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/kernel/process.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 411c971..813ed78 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -345,7 +345,7 @@ static int get_frame_info(struct mips_frame_info *info)
 		return 0;
 	if (info->pc_offset < 0) /* leaf */
 		return 1;
-	/* prologue seems boggus... */
+	/* prologue seems bogus... */
 err:
 	return -1;
 }
-- 
2.8.2.534.g1f66975
