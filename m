Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2017 04:43:48 +0100 (CET)
Received: from mail-pf0-x243.google.com ([IPv6:2607:f8b0:400e:c00::243]:34144
        "EHLO mail-pf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991346AbdBTDnmBz6zS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2017 04:43:42 +0100
Received: by mail-pf0-x243.google.com with SMTP id o64so8151865pfb.1;
        Sun, 19 Feb 2017 19:43:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=bCdzCULlgMhjxRKtT90qanqNff0jRMmuFCJmEOoTyB8=;
        b=Rcp7O5WMtnTHdsrZrwVVXTbuZjbaV8XOTlm9A45iBfgRRM1xwDOPwWCr9kgItWQbk5
         dfD+Myx0mycQ7L3ShdFVfr4bEmPu0OtoglkAEDwdTfYaGd6+7JFqTMkNdFTJA7ak5abR
         aSMmud6r9xs2YxaNdmaDb56xFXdCu4mW/OldlGVxMvO0L6A2Lx1+cWZRMkrBRD25FWpU
         C/9O818+FwXD/ocZC+bfzohsk3FNFzBJVJGgzi7shKHXImYdZozPwS4dWD1XoLSPh7OF
         loc1rQ2Cr+kS26yvuispNbMMRoVf2++zl93iSe3hW9bFKNZy8nGebeBL7jAp4v3Dw9lZ
         ILBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=bCdzCULlgMhjxRKtT90qanqNff0jRMmuFCJmEOoTyB8=;
        b=iWBNMl0AtClM+5n/+T10wHbGucSVNMFqThVfln2TyF06cnBxRwdhU96PD/t3BYokXr
         90ZpZo38SNBSVrLRTZG2b55d6aBDAzaQpB0S3r7KB8t0JVOSQwv0Qr04nctDogO5lkGC
         xDVchPw1STgeamBM3wifSrPFPK0r9CNRKOdD/eZqUi1O90JYrPK93q1Suy4JM8AuBpAZ
         /8I4ovurLJdrqcogNMbASFpUrfNkBt2ABs1uDgj+YHn1pxEb5epGhm4uHFRQPP9vyx3H
         rXpowjFpk7vFBlsMUmeFTXJyxP6KrAYAGIFvLVguGqCSW7Hm5EGz8vVYYLiiWBzUp8dO
         i7vw==
X-Gm-Message-State: AMke39nH15c3GhImebBx80Ww310k/oipZ2ReUDpFBWRVqiZXyckNS6NscojHPnm6kZAmmA==
X-Received: by 10.98.78.66 with SMTP id c63mr23564572pfb.138.1487562215900;
        Sun, 19 Feb 2017 19:43:35 -0800 (PST)
Received: from will-VirtualBox.corp.ad.wrs.com ([106.120.101.38])
        by smtp.gmail.com with ESMTPSA id i82sm31514912pfk.52.2017.02.19.19.43.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 19 Feb 2017 19:43:35 -0800 (PST)
From:   "jianchao.wang" <jianchao.wan9@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        "jianchao.wang" <jianchao.wan9@gmail.com>
Subject: [PATCH] MIPS:wrong usage of l_exc_copy in octeon-memcpy.S
Date:   Mon, 20 Feb 2017 11:42:58 +0800
Message-Id: <1487562178-2901-1-git-send-email-jianchao.wan9@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <jianchao.wan9@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jianchao.wan9@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

l_exc_copy() is usually to be used like this:
1 EXC(	LOAD	t0, UNIT(0)(src),	l_exc)
2 EXC(	LOAD	t1, UNIT(1)(src),	l_exc_copy)
3 EXC(	LOAD	t2, UNIT(2)(src),	l_exc_copy)
4 EXC(	LOAD	t3, UNIT(3)(src),	l_exc_copy)
When the fault occurs on row 4, l_exc_copy will get the bad
addr through THREAD_BUADDR(), complete the copy of row
1,2 and 3, and then return the len that has not been copied.
l_exc_copy assumes the src is smaller thann the bad addr.It will
increase src by 1 until reach the bad addr.

octeon-memcpy.S use the l_exc_copy with wrong way which make src
could be greater than bad addr. We will fix it in this patch.
We add the max offset of LOAD to 15 here to fix the issue without
adding new commands . Howerver, the side effect is that, when LOAD
fails in few case, l_exc_copy has to copy more.

Signed-off-by: jianchao.wang <jianchao.wan9@gmail.com>
---
 arch/mips/cavium-octeon/octeon-memcpy.S | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/mips/cavium-octeon/octeon-memcpy.S b/arch/mips/cavium-octeon/octeon-memcpy.S
index 64e08df..b0fe98e 100644
--- a/arch/mips/cavium-octeon/octeon-memcpy.S
+++ b/arch/mips/cavium-octeon/octeon-memcpy.S
@@ -205,22 +205,22 @@ EXC(	LOAD	t3, UNIT(7)(src),	l_exc_copy)
 EXC(	STORE	t0, UNIT(4)(dst),	s_exc_p12u)
 EXC(	STORE	t1, UNIT(5)(dst),	s_exc_p11u)
 EXC(	STORE	t2, UNIT(6)(dst),	s_exc_p10u)
-	ADD	src, src, 16*NBYTES
 EXC(	STORE	t3, UNIT(7)(dst),	s_exc_p9u)
+EXC(	LOAD	t0, UNIT(8)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(9)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(10)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(11)(src),	l_exc_copy)
+EXC(	STORE	t0, UNIT(8)(dst),	s_exc_p8u)
+EXC(	STORE	t1, UNIT(9)(dst),	s_exc_p7u)
+EXC(	STORE	t2, UNIT(10)(dst),	s_exc_p6u)
+EXC(	STORE	t3, UNIT(11)(dst),	s_exc_p5u)
+EXC(	LOAD	t0, UNIT(12)(src),	l_exc_copy)
+EXC(	LOAD	t1, UNIT(13)(src),	l_exc_copy)
+EXC(	LOAD	t2, UNIT(14)(src),	l_exc_copy)
+EXC(	LOAD	t3, UNIT(15)(src),	l_exc_copy)
 	ADD	dst, dst, 16*NBYTES
-EXC(	LOAD	t0, UNIT(-8)(src),	l_exc_copy)
-EXC(	LOAD	t1, UNIT(-7)(src),	l_exc_copy)
-EXC(	LOAD	t2, UNIT(-6)(src),	l_exc_copy)
-EXC(	LOAD	t3, UNIT(-5)(src),	l_exc_copy)
-EXC(	STORE	t0, UNIT(-8)(dst),	s_exc_p8u)
-EXC(	STORE	t1, UNIT(-7)(dst),	s_exc_p7u)
-EXC(	STORE	t2, UNIT(-6)(dst),	s_exc_p6u)
-EXC(	STORE	t3, UNIT(-5)(dst),	s_exc_p5u)
-EXC(	LOAD	t0, UNIT(-4)(src),	l_exc_copy)
-EXC(	LOAD	t1, UNIT(-3)(src),	l_exc_copy)
-EXC(	LOAD	t2, UNIT(-2)(src),	l_exc_copy)
-EXC(	LOAD	t3, UNIT(-1)(src),	l_exc_copy)
 EXC(	STORE	t0, UNIT(-4)(dst),	s_exc_p4u)
+	ADD	src, src, 16*NBYTES
 EXC(	STORE	t1, UNIT(-3)(dst),	s_exc_p3u)
 EXC(	STORE	t2, UNIT(-2)(dst),	s_exc_p2u)
 EXC(	STORE	t3, UNIT(-1)(dst),	s_exc_p1u)
-- 
2.7.4
