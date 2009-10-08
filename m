Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 14:40:18 +0200 (CEST)
Received: from mail-px0-f187.google.com ([209.85.216.187]:42318 "EHLO
	mail-px0-f187.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492608AbZJHMkL (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Oct 2009 14:40:11 +0200
Received: by pxi17 with SMTP id 17so7362087pxi.21
        for <linux-mips@linux-mips.org>; Thu, 08 Oct 2009 05:40:01 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=KpNFwhQTsPP58mWa/mdiSFYSn3iEuFNMHO4t/FluFkQ=;
        b=wXF9/dnPDOvhQVLVcLXRAhfCdjIo0mXc0kHA/+Vt1lLSxXIX1xOJPDR1Uk/r5n3Xm9
         PZTMbGlEimLl+PkPxE5R31HHc7T45Ju4jkDDoLQIK+igRW/iGed3Oc4j2p+224caSZD6
         o9tFi/0roBCHAgk5k1v5Gz+jQkwdndrPs0cg8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=GdHkj1J+ZsuUskuqLXiBlYZoCAo5dy0Ccd7SaQtGtW7Higm94NHJXgMZOK4bGeUbyS
         AJ0ChdxZKE16hKASOjAW2DbrdNNMsOfUaEvGalYZDGvMYZg90d2WGti4v7kSmVS09F5o
         ZFEsy9uFyrk26u+0ioKo9anU3ccbaBiqrWSA4=
Received: by 10.114.6.28 with SMTP id 28mr2006639waf.115.1255005601495;
        Thu, 08 Oct 2009 05:40:01 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 23sm805450pzk.4.2009.10.08.05.39.58
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 08 Oct 2009 05:40:00 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] [loongson] Remove redundant local_irq_disable()
Date:	Thu,  8 Oct 2009 20:39:50 +0800
Message-Id: <1255005590-16562-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

That code is executed with irq disabled already, so, Remove the redundant
local_irq_disable() here.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/loongson/common/irq.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
index 53dff17..20e7328 100644
--- a/arch/mips/loongson/common/irq.c
+++ b/arch/mips/loongson/common/irq.c
@@ -55,7 +55,6 @@ void __init arch_init_irq(void)
 	 * int-handler is not on bootstrap
 	 */
 	clear_c0_status(ST0_IM | ST0_BEV);
-	local_irq_disable();
 
 	/* setting irq trigger mode */
 	set_irq_trigger_mode();
-- 
1.6.2.1
