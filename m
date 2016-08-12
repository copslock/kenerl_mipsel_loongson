Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Aug 2016 05:07:11 +0200 (CEST)
Received: from mail-pa0-f65.google.com ([209.85.220.65]:34301 "EHLO
        mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990778AbcHLDHE5YJRw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Aug 2016 05:07:04 +0200
Received: by mail-pa0-f65.google.com with SMTP id hh10so707147pac.1;
        Thu, 11 Aug 2016 20:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=KsnHOHeOZnckuy63PMISgswiAPFC7m89IP2m4++su8Q=;
        b=UaV2p6Ec/gQKt0tymdxGjSCmSc5CKdiIMHZqsmnkdUrRdO7o3NglEg74RZBkQWZASF
         Fit5MYKrv7zU1GrpwQ8KP2YfPKQNyu02rSmoWZh4Ycr1SEeFSz9K8yTEWjgvmCezdbU9
         VdxFf+upO2HYUVWUNVQfTnbWem9xyBcLcxgJgk6V6NtBbKJp3nvcTll2QbtAzXKg5v0d
         Kvgz3GHy2pxLEX053blBT2RDhiISdwQTDIvJAv4MO/DbdUtbB0oRs+Bp8Lt2VIZheCJv
         cGUnyK7sDwE7mae1P4l84g/sLoxzbzrnEANl72hIDu4H8vKKg6kS4BIDQVCE2U+zT0tr
         K+bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=KsnHOHeOZnckuy63PMISgswiAPFC7m89IP2m4++su8Q=;
        b=awcymfyL3MNShKoRjuMjRniTPrO33HazPCVMrjMkvPkmaC1eulj2MBkv3/1t2q85WV
         ARYMUMIeR2U28CC5eylcIoc/N6wQ4+wkbZCsHq+/J6I74SRket7Yfc7Pn2LRL/n6FqQs
         8uTWdiTztS49nPeirsA69P+iZyDAHtvdOkdwpt7vjQcxrQ2jLant+R98O2iSxt1w3tAR
         F4XmXPn0bbmaDTCnQh8cLxH3ppz8pR+HyQ0/IkwFz9sIBQjAnWsnP5a4gx5Xq7xtqNHb
         R3g39+9NLTipM+y4SuDMkrjcPYRXIGyTS8h8cjwEFgwTpc0xqkkMG7hlMnIWEEqC9L9P
         RUfw==
X-Gm-Message-State: AEkoouudC0ApMJaSJZ6JlSTNe9Jj0SjIgxNRh06jPntjIg9Mvfweu7l6KywHMRlQu8BEAg==
X-Received: by 10.66.136.74 with SMTP id py10mr23491491pab.114.1470971218878;
        Thu, 11 Aug 2016 20:06:58 -0700 (PDT)
Received: from localhost ([117.99.187.22])
        by smtp.gmail.com with ESMTPSA id c7sm8367751pfj.25.2016.08.11.20.06.57
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 11 Aug 2016 20:06:58 -0700 (PDT)
Date:   Fri, 12 Aug 2016 08:36:54 +0530
From:   Amitoj Kaur Chawla <amitoj1606@gmail.com>
To:     ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Cc:     julia.lawall@lip6.fr
Subject: [PATCH] MIPS: ath79: Modify error handling
Message-ID: <20160812030654.GA18340@amitoj-Inspiron-3542>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <amitoj1606@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54491
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: amitoj1606@gmail.com
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

clk_register_fixed_factor returns an ERR_PTR in case of an error and
should have an IS_ERR check instead of a null check.

The Coccinelle semantic patch used to find this issue is as follows:
@@
expression e;
statement S;
@@

*e = clk_register_fixed_factor(...);
if (!e) S

Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
---
 arch/mips/ath79/clock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/ath79/clock.c b/arch/mips/ath79/clock.c
index 2e73784..cc3a1e3 100644
--- a/arch/mips/ath79/clock.c
+++ b/arch/mips/ath79/clock.c
@@ -96,7 +96,7 @@ static struct clk * __init ath79_reg_ffclk(const char *name,
 	struct clk *clk;
 
 	clk = clk_register_fixed_factor(NULL, name, parent_name, 0, mult, div);
-	if (!clk)
+	if (IS_ERR(clk))
 		panic("failed to allocate %s clock structure", name);
 
 	return clk;
-- 
1.9.1
