Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jan 2010 06:13:58 +0100 (CET)
Received: from mail-yx0-f204.google.com ([209.85.210.204]:35926 "EHLO
        mail-yx0-f204.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491124Ab0ACFNy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jan 2010 06:13:54 +0100
Received: by yxe42 with SMTP id 42so14476699yxe.22
        for <multiple recipients>; Sat, 02 Jan 2010 21:13:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=e9DsUOz2i8zq/RmlFVJYkf5EGNX8gZ2NJ3UF+62AKPY=;
        b=PGOZhuAZlocbvgI1zEoxs7xYDU8G8TMhOHtQV/FIWkKcxB7Yjo4XQAvi5aswUTVGZ6
         aKzxWWj8WcdPbhW7x+u4FE7n8QRgWVacIvMdXcSmBxf6JJsf3WCy8H4ETdluy1G+zJ6x
         BIFS6oCMcog+sknrHon21VhvbGh9yTd6JcN/Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=tTFMY6qvdWsxnz8t2oaw0sPv0o0cmTd/pTcutlYds0mLjdUj7r9pPBHiN+md227sAO
         NrH++hQM+th3+EHnoE0IIgE0BQEwKD5TYQEprhUWO4N3R5cMTj8oohsWsRIfpaZw333A
         wdYm5CkDqM11kLNoTt6xxyvoi39woXIzVa+tM=
Received: by 10.91.42.25 with SMTP id u25mr3666416agj.70.1262495622968;
        Sat, 02 Jan 2010 21:13:42 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm8455229gxk.9.2010.01.02.21.13.40
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 02 Jan 2010 21:13:42 -0800 (PST)
Date:   Sun, 3 Jan 2010 14:13:04 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: ar7 remove unused prom_getchar()
Message-Id: <20100103141304.2f7b653f.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 25470
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 1837

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/ar7/prom.c |    7 -------
 1 files changed, 0 insertions(+), 7 deletions(-)

diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index 453dd22..c1fdd36 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -272,13 +272,6 @@ static inline void serial_out(int offset, int value)
 	writel(value, (void *)PORT(offset));
 }
 
-char prom_getchar(void)
-{
-	while (!(serial_in(UART_LSR) & UART_LSR_DR))
-		;
-	return serial_in(UART_RX);
-}
-
 int prom_putchar(char c)
 {
 	while ((serial_in(UART_LSR) & UART_LSR_TEMT) == 0)
-- 
1.6.5.7
