Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Jul 2009 14:50:01 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:39050 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493809AbZGaMty (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Jul 2009 14:49:54 +0200
Received: by ewy12 with SMTP id 12so2197901ewy.0
        for <multiple recipients>; Fri, 31 Jul 2009 05:49:48 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=xLcWIxpHGP4mlurS44zV+ESBzOv9wlZR73KeCRjlGSo=;
        b=wh7qm5ulB1FjfP4zSYn3GAOAz4+kmbDGcxjtDm/vNBpmhy5zbqZExCMeW5U3rvcp6F
         ToMc7G5TaGuO5fK4mOsm+ZelgqgqWBEFOqGgWVvXzR7FeYA9LvMtIR0C3WcjMF4pvYEN
         nij5kH0YR2T5x4K26tJOXX0H2/Yb08z5o5p1k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=bNlP+VbPKL7lxauMrRJ8D0CfX1au1F8NAZMKthNPa//w1vnpQrJuSMecCm6ZgTYzs4
         RpgSwHk7bsUCWyAuLyV3sLI8jqNzjm5C7nzxOpwNcLK3zADpj10e4BQaweEqvEhzYrUG
         Ps4EuXSOR2op5lkA+zxJq2WrrqZFPjAZPx0Uc=
Received: by 10.210.125.13 with SMTP id x13mr816414ebc.87.1249044588797;
        Fri, 31 Jul 2009 05:49:48 -0700 (PDT)
Received: from zoinx.mars (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 5sm4315567eyh.6.2009.07.31.05.49.48
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 31 Jul 2009 05:49:48 -0700 (PDT)
Message-ID: <4A72E923.8070105@gmail.com>
Date:	Fri, 31 Jul 2009 14:52:51 +0200
From:	Roel Kluin <roel.kluin@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b3pre) Gecko/20090513 Fedora/3.0-2.3.beta2.fc11 Thunderbird/3.0b2
MIME-Version: 1.0
To:	ralf@linux-mips.org, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MIPS: Read buffer overflow
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <roel.kluin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23807
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

Check whether index is within bounds before testing the element.

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
diff --git a/arch/mips/jazz/jazzdma.c b/arch/mips/jazz/jazzdma.c
index f0fd636..0d64d0f 100644
--- a/arch/mips/jazz/jazzdma.c
+++ b/arch/mips/jazz/jazzdma.c
@@ -190,7 +190,7 @@ int vdma_free(unsigned long laddr)
 		return -1;
 	}
 
-	while (pgtbl[i].owner == laddr && i < VDMA_PGTBL_ENTRIES) {
+	while (i < VDMA_PGTBL_ENTRIES && pgtbl[i].owner == laddr) {
 		pgtbl[i].owner = VDMA_PAGE_EMPTY;
 		i++;
 	}
