Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 27 Feb 2010 17:56:16 +0100 (CET)
Received: from mail-bw0-f215.google.com ([209.85.218.215]:57994 "EHLO
        mail-bw0-f215.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492271Ab0B0Q4I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 27 Feb 2010 17:56:08 +0100
Received: by bwz7 with SMTP id 7so765004bwz.24
        for <multiple recipients>; Sat, 27 Feb 2010 08:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=vCKjkI8dODhgUKw6/z+aZ/MlIXzLYJuYiT2IYC2+nmU=;
        b=JAjdkIu2n4mDeFvxUpzezd2PF5qQM2VuPE8lpqw0+/FUzX4ov7bGgvWOm8HKXVOmF5
         /hR1IIuTDfsNtNci4BsCmwm5LSEJsdhfNzgH/aTVuaVn4Cu5LrD8wXUYwYBWQaKlIjfa
         4n0yf9kiSgQpvK3MNQHbp/hnebop/Z05aX+f8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=owD3xaXWWS9d1xcGfU4znADXBX7d6pktMgs4eDFYc1v/Z82oOSbMWRnI0qGrPbwrpN
         IQqrXVuiu8KHiGFxfZouhT0CFJLtgT0PHzKoztYd1KQTmR2OQQe0uR9CnA78W+CcwPyN
         vayxAaSZAWbMO9+/QnRfu6f2HewA3cDV17xcY=
Received: by 10.204.5.145 with SMTP id 17mr1395170bkv.40.1267289761939;
        Sat, 27 Feb 2010 08:56:01 -0800 (PST)
Received: from localhost (net-93-145-196-35.t2.dsl.vodafone.it [93.145.196.35])
        by mx.google.com with ESMTPS id 15sm819319bwz.8.2010.02.27.08.56.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 27 Feb 2010 08:56:01 -0800 (PST)
From:   Andrea Gelmini <andrea.gelmini@gelma.net>
To:     linux-kernel@vger.kernel.org
Cc:     Andrea Gelmini <andrea.gelmini@gelma.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Mundt <lethal@linux-sh.org>, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org
Subject: [PATCH 42/66] arch/mips/lib/libgcc.h: Checkpatch cleanup
Date:   Sat, 27 Feb 2010 17:51:23 +0100
Message-Id: <1267289508-31031-43-git-send-email-andrea.gelmini@gelma.net>
X-Mailer: git-send-email 1.7.0.90.g251a4
In-Reply-To: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
References: <1267289508-31031-1-git-send-email-andrea.gelmini@gelma.net>
Return-Path: <andrea.gelmini@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andrea.gelmini@gelma.net
Precedence: bulk
X-list: linux-mips

arch/mips/lib/libgcc.h:21: ERROR: open brace '{' following union go on the same line

Signed-off-by: Andrea Gelmini <andrea.gelmini@gelma.net>
---
 arch/mips/lib/libgcc.h |    3 +--
 arch/sh/lib/libgcc.h   |    3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/libgcc.h b/arch/mips/lib/libgcc.h
index 3f19d1c..05909d5 100644
--- a/arch/mips/lib/libgcc.h
+++ b/arch/mips/lib/libgcc.h
@@ -17,8 +17,7 @@ struct DWstruct {
 #error I feel sick.
 #endif
 
-typedef union
-{
+typedef union {
 	struct DWstruct s;
 	long long ll;
 } DWunion;
diff --git a/arch/sh/lib/libgcc.h b/arch/sh/lib/libgcc.h
index 3f19d1c..05909d5 100644
--- a/arch/sh/lib/libgcc.h
+++ b/arch/sh/lib/libgcc.h
@@ -17,8 +17,7 @@ struct DWstruct {
 #error I feel sick.
 #endif
 
-typedef union
-{
+typedef union {
 	struct DWstruct s;
 	long long ll;
 } DWunion;
-- 
1.7.0.90.g251a4
