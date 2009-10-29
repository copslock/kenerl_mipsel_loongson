Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Oct 2009 03:09:32 +0100 (CET)
Received: from mail-px0-f188.google.com ([209.85.216.188]:64383 "EHLO
	mail-px0-f188.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493205AbZJ2CJZ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 29 Oct 2009 03:09:25 +0100
Received: by pxi26 with SMTP id 26so977917pxi.22
        for <multiple recipients>; Wed, 28 Oct 2009 19:09:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=vxctz3pSQMmcoE/BWm42/LySSxEcmzqXybbLHaEA2Sw=;
        b=TMfsjpX9TXDInh5NNB++emZvF2aNG9DC5pTFKVctQD4S/EN5kltsHfrK9OkbzJqz2i
         nkBEQ5KVU33BycP0WAie6J7JGo052BDHUN70X7veLlsHQtkYnys+cQoWEpTXq/7KxHaC
         Z0zt7yqFrmT5ZxMuB+hawsQ4Yums4SRHnGjIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=Ium6XykyrvdONaotHgy861Eeo7d8ittPrN3aLgGyb8rKDB8XfT2EV4A91c4s58dKB3
         hjbqQ5sQ7CRjMnHIAaL4I5Z6oMCjxRRALwC2CfEKKDaduTxfX7/9P9n2thK1p12KyDHI
         WJRF8z6Dt7jWl/gpE4STCMGPWZxv147q0Io90=
Received: by 10.115.101.30 with SMTP id d30mr5201285wam.175.1256782156654;
        Wed, 28 Oct 2009 19:09:16 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 21sm919475pzk.15.2009.10.28.19.09.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 28 Oct 2009 19:09:15 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Robert Richter <robert.richter@amd.com>, chenj@lemote.com,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH -sfr.git] oprofile/loongson2: rename cpu_type from godson2 to loongson2
Date:	Thu, 29 Oct 2009 10:09:05 +0800
Message-Id: <1256782145-2180-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24568
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
 so, Ralf, could you please merge it into your mips-for-linux-next
 branch, thanks!)

Acked-by: Robert Richter <robert.richter@amd.com>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/oprofile/op_model_loongson2.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/oprofile/op_model_loongson2.c b/arch/mips/oprofile/op_model_loongson2.c
index deed1d5..575cd14 100644
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
