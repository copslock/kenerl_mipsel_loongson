Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Dec 2009 14:00:47 +0100 (CET)
Received: from mail-yw0-f203.google.com ([209.85.211.203]:47549 "EHLO
        mail-yw0-f203.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493083AbZLRNAn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Dec 2009 14:00:43 +0100
Received: by ywh41 with SMTP id 41so8910964ywh.0
        for <multiple recipients>; Fri, 18 Dec 2009 05:00:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:date:from:to:cc
         :subject:message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=W7nW/1XM48AZ4pVmwmXmeBxCeilgHaXPJo+PnRpP8o0=;
        b=eW6ItsQzcnuACis+dOUmDS6OCz1ZVwl2d4kwjZD+h9HTKsqg+Nu65EnIjGCTcISxue
         AOdmXUOmGpCppL6i+VMADjvz7ng2LJ+TfMUM2nBIcfz9z236+K7UM2ph0I3LFfCMsT2s
         C4QVlvyUJzHH0NpezGfne+3PQpr8qn+Zrro+w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:date:from:to:cc:subject:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=xOSjoTxM08A2E64kWZC/2xTPUIKDWLi+YNZK3I4N7v05UXlXgskGcbku9U2gJPGWx5
         DrlPYhG3uHemcUT9VBrT+37x7QHZbnyf5sIprkm+dLfmrNAtElJzLOfCFFf9mVLr3Xn2
         OLDegm7Qr0n09vzl8vyA27htXTaJ3ZrIX+gCI=
Received: by 10.101.167.16 with SMTP id u16mr6263581ano.7.1261141236490;
        Fri, 18 Dec 2009 05:00:36 -0800 (PST)
Received: from ypsilon.skybright.jp (sannin29006.nirai.ne.jp [203.160.29.6])
        by mx.google.com with ESMTPS id 13sm1432506gxk.1.2009.12.18.05.00.34
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 18 Dec 2009 05:00:35 -0800 (PST)
Date:   Fri, 18 Dec 2009 21:29:17 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     yuasa@linux-mips.org, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 1/5]MIPS: remove unused powertv prom_getcmdline()
Message-Id: <20091218212917.f42e8180.yuasa@linux-mips.org>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.16.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa.linux@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25417
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
Precedence: bulk
X-list: linux-mips

Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/powertv/cmdline.c |    5 -----
 1 files changed, 0 insertions(+), 5 deletions(-)

diff --git a/arch/mips/powertv/cmdline.c b/arch/mips/powertv/cmdline.c
index 98d73cb..ee7ab47 100644
--- a/arch/mips/powertv/cmdline.c
+++ b/arch/mips/powertv/cmdline.c
@@ -31,11 +31,6 @@
  */
 #define prom_argv(index) ((char *)(long)_prom_argv[(index)])
 
-char * __init prom_getcmdline(void)
-{
-	return &(arcs_cmdline[0]);
-}
-
 void  __init prom_init_cmdline(void)
 {
 	int len;
-- 
1.6.5.7
