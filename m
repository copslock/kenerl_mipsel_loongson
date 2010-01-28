Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 14:52:26 +0100 (CET)
Received: from mail-yx0-f195.google.com ([209.85.210.195]:37858 "EHLO
        mail-yx0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492347Ab0A1NwW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2010 14:52:22 +0100
Received: by yxe33 with SMTP id 33so1555726yxe.0
        for <multiple recipients>; Thu, 28 Jan 2010 05:52:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=13O/N9ESiClkiyhDqNqqrAnu7EyRPqWYxsjHT7MX658=;
        b=Ia4kgu0JcMMl6iNmwF+QCjhQkPGxLgC36tSyYVR12MqpFaodVtgHlFyvWxBTW0vm69
         jMRyUgaovyQBo8JvbVcAtNkd0Yiqj3lL5L7HGS5SF6DVk6gfD5p/FbMw4O53XrelLNc+
         7dL4juASSayPkhEkA3WKsEd7YFFthH8hx61Ug=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=Oqx/tWMKl0Syhoo7QF8/VKv2yuq3anozceseI/m8/fZ3i1hQQcSRoCNg3ojGxsYsKT
         +dYUCv7JbQQmHcIJvk5WIcQfyX5KxwPnrEn89XAgVBWhcGMXhk7WWk3skb5+TlR0EPPp
         rjYIxsLBUI61cffPVFpcCmcdrNFKCn8iQIAIQ=
Received: by 10.101.53.7 with SMTP id f7mr2613246ank.136.1264686735176;
        Thu, 28 Jan 2010 05:52:15 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 14sm600082gxk.14.2010.01.28.05.52.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 05:52:14 -0800 (PST)
Date:   Thu, 28 Jan 2010 22:51:50 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: pnx833x: remove unused prom_getcmdline()
Message-Id: <20100128225150.e9958637.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18221

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/nxp/pnx833x/common/prom.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/nxp/pnx833x/common/prom.c b/arch/mips/nxp/pnx833x/common/prom.c
index 0688881..29969f9 100644
--- a/arch/mips/nxp/pnx833x/common/prom.c
+++ b/arch/mips/nxp/pnx833x/common/prom.c
@@ -62,8 +62,3 @@ char __init *prom_getenv(char *envname)
 void __init prom_free_prom_memory(void)
 {
 }
-
-char * __init prom_getcmdline(void)
-{
-	return arcs_cmdline;
-}
-- 
1.6.6.1
