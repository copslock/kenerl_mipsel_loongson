Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Oct 2009 16:52:10 +0200 (CEST)
Received: from mail-fx0-f225.google.com ([209.85.220.225]:62150 "EHLO
	mail-fx0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493594AbZJUOwE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 21 Oct 2009 16:52:04 +0200
Received: by fxm25 with SMTP id 25so8086437fxm.0
        for <multiple recipients>; Wed, 21 Oct 2009 07:51:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=J/EyCjyAh275PgLNf9RAHARDrI2RnisrSJTXL2ogQbI=;
        b=MqErP0CKPnLcy6fhLv5bIgemtTpLsVDrRkSVvOJWv9cd8c9MTFErIHG4KikGcEEgUP
         ojvxf251YWvdgMUvvWVyWALLAgNldCLLz0YPklRbsuFWkMlYfT45CE8XNaSZ0sgkAL+Q
         vwXkAg2uF8XQ8P99yBPBtXsPKSQVX9LDCPiKY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=neLWrk4GQ5nXvPm2aNv6Mw8VRCJmsQPqq7aD7HtglihlrTrUGJmOK13E6ZC/i6kku5
         iOx+3YU6PYEvxj7F0+BPh3YFp6uTjqb2YmKyXGVr/CFUrstcT4HyRLn8LT4vAAl6EWDz
         WtsB/DDPBRWhC+kbeaipRf6YHjn/3nCMpWoRA=
Received: by 10.204.48.210 with SMTP id s18mr8081274bkf.162.1256136717661;
        Wed, 21 Oct 2009 07:51:57 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id k29sm319201fkk.55.2009.10.21.07.51.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 21 Oct 2009 07:51:56 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>, Chen Jie <chenj@lemote.com>,
	Maynard Johnson <maynardj@us.ibm.com>,
	John Levon <levon@movementarian.org>,
	oprofile-list@lists.sourceforge.net,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] oprofile/loongson2: rename cpu_type from godson2 to loongson2
Date:	Wed, 21 Oct 2009 22:51:46 +0800
Message-Id: <1256136706-27810-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24415
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch try to unify the naming method between kernel and the
user-space oprofile tool. 'Cause loongson is used instead of godson in
most of the places, and just confer with the developer of the user-space
tool, we are agreed to use loongson instead, which will help a lot to
the future maintaining.

(This patch is very important to help the user-space support upstream,
 so, Ralf, could you please merge it into your -queue branch, thanks!)

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index 9536b21..08d4b09 100644
--- a/arch/mips/oprofile/op_model_loongson2.c
+++ b/arch/mips/oprofile/op_model_loongson2.c
@@ -22,7 +22,7 @@
  * otherwise, the oprofile tool will not recognize this and complain about
  * "cpu_type 'unset' is not valid".
  */
-#define LOONGSON2_CPU_TYPE	"mips/godson2"
+#define LOONGSON2_CPU_TYPE	"mips/loongson2"
 
 #define LOONGSON2_COUNTER1_EVENT(event)	((event & 0x0f) << 5)
 #define LOONGSON2_COUNTER2_EVENT(event)	((event & 0x0f) << 9)
-- 
1.6.2.1
