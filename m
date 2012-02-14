Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2012 23:51:36 +0100 (CET)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:38438 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903642Ab2BNWv3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2012 23:51:29 +0100
Received: by pbcun1 with SMTP id un1so1016178pbc.36
        for <linux-mips@linux-mips.org>; Tue, 14 Feb 2012 14:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=gamma;
        h=mime-version:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=XAsB5hnmXB+Qf6KfuZDjgJq+WUymHIeH20EJzRyKaac=;
        b=xBtXYpikdxlxwNGBu2hE0NCgMAUI8CsaJnLvGCgJy3EuBDz51hMwc6465hHgdNU7jN
         HWfv+t91/UROSfAmIwdoq7OR+ixMtIHsU79cGa5ot1Dc0TCvtaPXaFFjlME18CAUJ/Cz
         to54oGIIkkHlytfgWFenPaldooLylGW/JeSH8=
MIME-Version: 1.0
Received: by 10.68.229.33 with SMTP id sn1mr62880246pbc.60.1329259883184;
        Tue, 14 Feb 2012 14:51:23 -0800 (PST)
Received: by 10.68.229.33 with SMTP id sn1mr62880172pbc.60.1329259883001;
        Tue, 14 Feb 2012 14:51:23 -0800 (PST)
Received: from tippy.mtv.corp.google.com (tippy.mtv.corp.google.com [172.18.96.130])
        by mx.google.com with ESMTPS id y9sm6426972pbi.3.2012.02.14.14.51.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 14 Feb 2012 14:51:22 -0800 (PST)
From:   Venkatesh Pallipadi <venki@google.com>
To:     Rusty Russell <rusty@rustcorp.com.au>
Cc:     Tony Luck <tony.luck@gmail.com>,
        "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        KOSAKI Motohiro <kosaki.motohiro@gmail.com>,
        KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>,
        Mike Travis <travis@sgi.com>,
        "Paul E. McKenney" <paul.mckenney@linaro.org>,
        "Rafael J. Wysocki" <rjw@sisk.pl>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org, Richard Kuo <rkuo@codeaurora.org>,
        linux-hexagon@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net,
        Venkatesh Pallipadi <venki@google.com>
Subject: [PATCH 1/3] hexagon: Avoid raw handling of cpu_possible_map
Date:   Tue, 14 Feb 2012 14:49:42 -0800
Message-Id: <1329259784-20592-2-git-send-email-venki@google.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1329259784-20592-1-git-send-email-venki@google.com>
References: <87wr7pbwbz.fsf@rustcorp.com.au>
 <1329259784-20592-1-git-send-email-venki@google.com>
X-Gm-Message-State: ALoCoQlNKWsVbuGa9NjmIPvNJ2gBZoJ3UNJAOzZDBVtboUWiKhpF11poxnkfDZjrOYEstU/kgVyL8/yf8SQ1bFIeSOqXu4tHs7bOYR+ako3T7ZX1gYPEA6ZGmIIoW8stCE5uVheHKgdT8rezP5b4BrAmovD4F9UFNMOhEjEWeUCSfot773h3dj0=
X-archive-position: 32426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: venki@google.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Use set_cpu_possible instead.

Signed-off-by: Venkatesh Pallipadi <venki@google.com>
---
 arch/hexagon/kernel/smp.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/hexagon/kernel/smp.c b/arch/hexagon/kernel/smp.c
index c871a2c..8962705 100644
--- a/arch/hexagon/kernel/smp.c
+++ b/arch/hexagon/kernel/smp.c
@@ -272,5 +272,5 @@ void smp_start_cpus(void)
 	int i;
 
 	for (i = 0; i < NR_CPUS; i++)
-		cpu_set(i, cpu_possible_map);
+		set_cpu_possible(i, true);
 }
-- 
1.7.7.3
