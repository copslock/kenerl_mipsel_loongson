Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2009 22:00:11 +0200 (CEST)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:54130 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493763AbZG2UAE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Jul 2009 22:00:04 +0200
Received: by ewy12 with SMTP id 12so914757ewy.0
        for <multiple recipients>; Wed, 29 Jul 2009 12:59:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:subject:content-type
         :content-transfer-encoding;
        bh=/IifyQbe9OEbhMW+mWY/+y90dCf5VRvTppbc0dlE8OU=;
        b=N1EDxOW8an450ppSKZ4jRhyqh2GTrdGHenYNv8hTUiXyskp6AgDqNXvrFLjYK96hts
         CQHrAAS0uYxyCqeDrs118PWPJBgcP8PoEDmyX1mtwh6C1Qk2WW41AwckvCDCZBpRuzt2
         IJnMVkc9XcePBMaw/m5+rEUofamPxk+8j31I8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=d7Rj30yA82WJ1ygEs9YYx4gNjvr4kgpb8MqZWOGg5KR5ymeha8lYDqfEATnVmYYTGu
         22aOPZLz7HzUZ/B6la347WbSdLSMBXWbFgZe+rOAmpcvtSYi8rxR7Asmnad8eXVxyPPl
         5yIGzAbe3zIpkk2H2Up56gkCGA0lpcxPK7qW8=
Received: by 10.210.78.16 with SMTP id a16mr240617ebb.66.1248897599192;
        Wed, 29 Jul 2009 12:59:59 -0700 (PDT)
Received: from zoinx.mars (d133062.upc-d.chello.nl [213.46.133.62])
        by mx.google.com with ESMTPS id 24sm930265eyx.53.2009.07.29.12.59.58
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 29 Jul 2009 12:59:58 -0700 (PDT)
Message-ID: <4A70AAED.3040404@gmail.com>
Date:	Wed, 29 Jul 2009 22:02:53 +0200
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
X-archive-position: 23792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: roel.kluin@gmail.com
Precedence: bulk
X-list: linux-mips

it should tests against ARRAY_SIZE(psp_var_map) instead of sizeof(psp_var_map)

Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
---
ARRAY_SIZE(psp_var_map) is 9.
sizeof(psp_var_map) is 144.

diff --git a/arch/mips/ar7/prom.c b/arch/mips/ar7/prom.c
index a320bce..5ad6f1d 100644
--- a/arch/mips/ar7/prom.c
+++ b/arch/mips/ar7/prom.c
@@ -144,7 +144,7 @@ static char * __init lookup_psp_var_map(u8 num)
 {
 	int i;
 
-	for (i = 0; i < sizeof(psp_var_map); i++)
+	for (i = 0; i < ARRAY_SIZE(psp_var_map); i++)
 		if (psp_var_map[i].num == num)
 			return psp_var_map[i].value;
 
