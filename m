Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2009 13:21:26 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:36186 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492907AbZLRMVU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2009 13:21:20 +0100
Received: by yxe42 with SMTP id 42so3203306yxe.22
        for <multiple recipients>; Fri, 18 Dec 2009 04:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=kq3ENNo9hy/48x1bXGLLKjO9+8LxxwW7dLgQBXJZWVs=;
        b=U+r2HUOzirTGP5bvuxltaYNiG2rWXXCkLZghRqRmf/vmWrFUC6EnGpxlF6MNmthbpL
         UiZQmPFeW8Mz4e7jvZcBxgP9rtN7fVzQtWiwCqmQtdW6z/H9KbxzdVrRkQCv7ZWSLgbU
         1uhE7Fo5yMzhSlD4y7eOgJNHDQXhSHzbAE9OU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=XcuWZtM0WoOIrUSiZwyDz0uBpHsYfvfK1jCA33fQMK9vSLwRlHnr2yYzKKLJYCSBsj
         bHeVIj2rrUruCSKd1x2akSiKmX0CLk05q+eJSEC8FRrvzuRJeTekWmsHN/a8pW1UgF+t
         aXjLE0glgyF1igzhrafEDZB00+BoVIfEyhWPY=
Received: by 10.91.105.3 with SMTP id h3mr4182090agm.6.1261138872545;
        Fri, 18 Dec 2009 04:21:12 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm1421312gxk.1.2009.12.18.04.21.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 04:21:11 -0800 (PST)
Date:   Fri, 18 Dec 2009 21:20:24 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: ar7 remove kgdb_enabled
Message-Id: <20091218212024.d9d9b411.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25414
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

kgdb_enabled has not been used.

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/ar7/prom.c |    8 --------
 1 files changed, 0 insertions(+), 8 deletions(-)

diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 5ad6f1d..453dd22 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -219,14 +219,6 @@ static void __init console_config(void)
 	if (strstr(prom_getcmdline(), "console="))
 		return;
 
-#ifdef CONFIG_KGDB
-	if (!strstr(prom_getcmdline(), "nokgdb")) {
-		strcat(prom_getcmdline(), " console=kgdb");
-		kgdb_enabled = 1;
-		return;
-	}
-#endif
-
 	s = prom_getenv("modetty0");
 	if (s) {
 		baud = simple_strtoul(s, &p, 10);
-- 
1.6.5.7
