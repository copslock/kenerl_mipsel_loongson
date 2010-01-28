Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jan 2010 14:53:25 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:51923 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492322Ab0A1NxV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jan 2010 14:53:21 +0100
Received: by ywh41 with SMTP id 41so561766ywh.0
        for <multiple recipients>; Thu, 28 Jan 2010 05:53:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=ljDJFgfLQDAemyBmSBcTngIoie1MyCRl0891iMP6crU=;
        b=YXlAOCa0iik6+J/vsJy0iWUdnCcdIGHHJ/XwoYVogHva/hcYCfYQcl2XZcCyhRAzLH
         3etrIWD1w4BpfCG63DDNrxwLfcR4RvtYbrGReoYJ30B0jHeZxnju/t55PZFhu9p6k/x6
         JSqzAgh4TVNI/+fQ+bKP3W5YwdG6cN0U+SstA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=x0Y6xhfJDIlJmdFdmwVodJAdLnZa7k40g93/tSchtpTRAvSaLqJ3yghJ/uazoFwRip
         3ubKWuYHW1XDE9nrBQLoxJLyQNe22UKJf5gN2E17pEELaawHlgwwW6XHoT09eJhjkbhG
         GI2u6H+AJA8ZVwu4S9U6Fzz9/zV5Xz/Hp/xFk=
Received: by 10.91.164.39 with SMTP id r39mr1902114ago.113.1264686794194;
        Thu, 28 Jan 2010 05:53:14 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 16sm598524gxk.3.2010.01.28.05.53.12
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 Jan 2010 05:53:13 -0800 (PST)
Date:   Thu, 28 Jan 2010 22:52:50 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: pnx8550: remove unnecessary export prom_getcmdline()
Message-Id: <20100128225250.bce580e7.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18222

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/nxp/pnx8550/common/prom.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/nxp/pnx8550/common/prom.c b/arch/mips/nxp/pnx8550/common/prom.c
index 2f56745..32f7009 100644
--- a/arch/mips/nxp/pnx8550/common/prom.c
+++ b/arch/mips/nxp/pnx8550/common/prom.c
@@ -124,6 +124,5 @@ void prom_putchar(char c)
 	}
 }
 
-EXPORT_SYMBOL(prom_getcmdline);
 EXPORT_SYMBOL(get_ethernet_addr);
 EXPORT_SYMBOL(str2eaddr);
-- 
1.6.6.1
