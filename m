Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jul 2013 00:09:00 +0200 (CEST)
Received: from mail-pd0-f169.google.com ([209.85.192.169]:54742 "EHLO
        mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831320Ab3G2WHRsc-UF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Jul 2013 00:07:17 +0200
Received: by mail-pd0-f169.google.com with SMTP id y11so436773pdj.28
        for <multiple recipients>; Mon, 29 Jul 2013 15:07:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=sdb1PMZi1hofEQy2mWCMbgHd26PNNXuxxE901iJJZC4=;
        b=vvrVfZpXIY0kLjFNFQ6eLX5fYLyJNOkSV9gGn0eD6nlvVWqkrtHlHSdw8HmT+m5puO
         ewDRXBndVHgnicvz+n/skiMGukwQQRzktX5LnUb/V8/dOJEzzco2VyWtcuqnEXL1ooOZ
         bSXUhL4aj7QcKB9fCoLq40tROv/Wd6/bg11arXUEfLZOdLKqG1jqqWczxLO8pksw6luq
         znAKuGqdE3Y4KvYmyRSFdhVj8JYT8dasVwIpqnUTFwoiIv6DN4D0EkWLuRkyW4dtqeLV
         8eGbkv0VktcJNOqV549KUEzwohv9lQbrMxXEnkDoOVJwg7L9EElleuClH7Uf93pXOaae
         Soqg==
X-Received: by 10.66.21.37 with SMTP id s5mr72425063pae.103.1375135631314;
        Mon, 29 Jul 2013 15:07:11 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id vi8sm78976815pbc.31.2013.07.29.15.07.09
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 29 Jul 2013 15:07:10 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r6TM78QW031001;
        Mon, 29 Jul 2013 15:07:08 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r6TM78pu031000;
        Mon, 29 Jul 2013 15:07:08 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH 3/5] MIPS: Use r4k_wait for OCTEON3 CPUs.
Date:   Mon, 29 Jul 2013 15:07:02 -0700
Message-Id: <1375135624-30950-4-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
In-Reply-To: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
References: <1375135624-30950-1-git-send-email-ddaney.cavm@gmail.com>
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37397
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

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/kernel/idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/kernel/idle.c b/arch/mips/kernel/idle.c
index 0c655de..42f8875 100644
--- a/arch/mips/kernel/idle.c
+++ b/arch/mips/kernel/idle.c
@@ -166,6 +166,7 @@ void __init check_wait(void)
 	case CPU_CAVIUM_OCTEON:
 	case CPU_CAVIUM_OCTEON_PLUS:
 	case CPU_CAVIUM_OCTEON2:
+	case CPU_CAVIUM_OCTEON3:
 	case CPU_JZRISC:
 	case CPU_LOONGSON1:
 	case CPU_XLR:
-- 
1.7.11.7
