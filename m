Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 08:25:14 +0200 (CEST)
Received: from mail-ob0-f202.google.com ([209.85.214.202]:33785 "EHLO
        mail-ob0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007389AbbE0GZNN8goD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 08:25:13 +0200
Received: by obcwm4 with SMTP id wm4so11478obc.0
        for <linux-mips@linux-mips.org>; Tue, 26 May 2015 23:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:message-id:date;
        bh=nutwx/ejjwbcNZkfX5PKmgxDM4OkLFTDWUAcrXsQBoY=;
        b=pSwD+TjanNiVAr3eHVf106wqF3hKGFaEvBzR6Ao0cdDrdE0vEurP8TfsdDrSJw7qil
         i/8Ul/UdGqkQzjeA4lQKbSOINgec+1osqjLNILn/wFIcyNNvUe/YNsK4kd6am/uDHRVC
         HG70EYtaKk/rpzagHljGsfXtZjVuUnZqb3Y9TPYWjUh3hiKOMSLvA4Ln24RnSVjXAzwe
         PSsYm/hPMe9H18jvgMgk9maIb+HGMCTY/joqQq0CSnf2MnGu6PO0Ko3kVEAqQ6JPPT6L
         HZqfAx20rqSYnV5auQ+S7iDZeYEd83RPhjNFTC/w5+zLb0+9YxD9Ry5PM6vnt3Nw1FRc
         r2BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:message-id:date;
        bh=nutwx/ejjwbcNZkfX5PKmgxDM4OkLFTDWUAcrXsQBoY=;
        b=JeGpx3qPC/jpHb1YK7nIwbVWbeq6YM4EOP5hVUB6oM9FNxFF+BtLzSSSYae5+plS0d
         hzL7R1+jaxLtr8WDYjHMx2CVAIXppTPsym6dhQzXo8i/NY+Zqdvr57Utnot1he0ZjqzV
         OHFUDB9SWyhOTgN28Bx32LXqnQWA3sWMUKoyJhore3vU8P04JV3Qj9QU9y0qweLD2j8C
         L5/5GMBog4AT2wC6kyzbNTmHpQD30p30eq8Fq57ZB2qm4fpo0byKh+ttEFaY8T0hjEQb
         FVEFUiim6K/ZYOLf9kWX6RtYVxeiAiGu+hw6qkFpqxUPl/6Biu1oAvFFERWVsczvOJn/
         WjgA==
X-Gm-Message-State: ALoCoQmDv4gDdL5cpJzp9YMgXJDSiY9FJ7dVxOD2m6+wS2k04YPd4tiMVEfXepVEj8r1WqHVIpRG
X-Received: by 10.43.151.129 with SMTP id ks1mr1960901icc.26.1432707909955;
        Tue, 26 May 2015 23:25:09 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id x25si880456yha.2.2015.05.26.23.25.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 May 2015 23:25:09 -0700 (PDT)
Received: from puck.mtv.corp.google.com ([172.27.88.166])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id QhrUEnj2.1; Tue, 26 May 2015 23:25:09 -0700
Received: by puck.mtv.corp.google.com (Postfix, from userid 68020)
        id CD24722020B; Tue, 26 May 2015 23:25:08 -0700 (PDT)
From:   Petri Gynther <pgynther@google.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, f.fainelli@gmail.com
Subject: [PATCH] MIPS: BMIPS: fix bmips_wr_vec()
Message-Id: <20150527062508.CD24722020B@puck.mtv.corp.google.com>
Date:   Tue, 26 May 2015 23:25:08 -0700 (PDT)
Return-Path: <pgynther@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pgynther@google.com
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

bmips_wr_vec() copies exception vector code from start to dst.

The call to dma_cache_wback() needs to flush (end-start) bytes,
starting at dst, from write-back cache to memory.

Signed-off-by: Petri Gynther <pgynther@google.com>
---
 arch/mips/kernel/smp-bmips.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index fd528d7..336708a 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -444,7 +444,7 @@ struct plat_smp_ops bmips5000_smp_ops = {
 static void bmips_wr_vec(unsigned long dst, char *start, char *end)
 {
 	memcpy((void *)dst, start, end - start);
-	dma_cache_wback((unsigned long)start, end - start);
+	dma_cache_wback(dst, end - start);
 	local_flush_icache_range(dst, dst + (end - start));
 	instruction_hazard();
 }
-- 
2.2.0.rc0.207.ga3a616c
