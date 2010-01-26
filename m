Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 10:57:44 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:56515 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492735Ab0AZJ5T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 10:57:19 +0100
Received: by yxe42 with SMTP id 42so2117924yxe.22
        for <multiple recipients>; Tue, 26 Jan 2010 01:57:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:in-reply-to:references:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=MpVqDqGK4NA7Uaxej60xR/yrvaIcmsguXBl4h5GIil8=;
        b=W7KODSLw8cnJGxR3GLJ0+tLSDqKhqNe12xzpiwgcahMgF34Hl11zeO6Vxl98TtjbMa
         M79EKGnS8bJPvqqtlTbPbFyQyB1fERlOJazYfxARfi0x8KvlRwsEjDS50W8gLoJpX1EO
         hBZo5QdTEaV8JyHSBV8Ox165AqBnVMGp32WuE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:in-reply-to:references
         :x-mailer:mime-version:content-type:content-transfer-encoding;
        b=hqTgJJh9j5gsQ9F/f7RREDVZiw4NGPLLb4roCZ8NfMeTto+3hljl/7whSkjPhWh6ny
         l3JaW5ZdF1OyQSOAULsUMfz1Io7WTg/CfB/cW+fwy5m3OgHbzrgJCKvngdGBA9BEaxUs
         XE6WutDRV1R0n1+/nf512zkQtPogzbpenD8X0=
Received: by 10.90.133.11 with SMTP id g11mr766975agd.121.1264499832858;
        Tue, 26 Jan 2010 01:57:12 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 16sm3461950gxk.7.2010.01.26.01.57.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 26 Jan 2010 01:57:12 -0800 (PST)
Date:   Tue, 26 Jan 2010 18:08:34 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2/2] MIPS: AR7: replace prom_getcmdline() to arcs_cmdline[]
Message-Id: <20100126180834.0e2f2ca3.yuasa@linux-mips.org>
In-Reply-To: <20100126180702.d47afbcf.yuasa@linux-mips.org>
References: <20100126180702.d47afbcf.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25662
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16566

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/ar7/prom.c |    7 +------
 1 files changed, 1 insertions(+), 6 deletions(-)

diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 43b21c0..4d75ff1 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -49,11 +49,6 @@ char *prom_getenv(const char *name)
 }
 EXPORT_SYMBOL(prom_getenv);
 
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
 static void  __init ar7_init_cmdline(int argc, char *argv[])
 {
 	int i;
@@ -206,7 +201,7 @@ static void __init console_config(void)
 	char parity = '\0', bits = '\0', flow = '\0';
 	char *s, *p;
 
-	if (strstr(prom_getcmdline(), "console="))
+	if (strstr(arcs_cmdline, "console="))
 		return;
 
 	s = prom_getenv("modetty0");
-- 
1.6.6.1
