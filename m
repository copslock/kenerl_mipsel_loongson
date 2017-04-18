Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Apr 2017 10:35:36 +0200 (CEST)
Received: from mail-pf0-x241.google.com ([IPv6:2607:f8b0:400e:c00::241]:32911
        "EHLO mail-pf0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992126AbdDRIf3ws1QS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Apr 2017 10:35:29 +0200
Received: by mail-pf0-x241.google.com with SMTP id c198so29217883pfc.0
        for <linux-mips@linux-mips.org>; Tue, 18 Apr 2017 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=wENzCad3yZoNk4bwy6Bra3jNKAHsqTb4spJAG1j/rcg=;
        b=gB76JK8/81WmBY+dRnEfE5DT273lkutEGTn+zRTsPgU5Vdw0rpegKqbtOEhDE/0r2X
         CeSZDg7T7LxPHU4BrK5KGcHKsykN6jLyDUyVhFbNIeUH8sFxmb5xXCm7o0dD3YkzCCoX
         qNHkzilJx8AJpakSM+0eMv9DSdWwAhDLmr+69OVunF8zBicEMARLDZssWaGHvhwVdqXv
         6ENEYuT9QnL/BfYx/slmEofmRHBZlYNh0vt0V53PXVohBPTrP5Ur6RFb+nXKYHR/Sfkz
         /KwJkMyeoHHo0gVL7emXTIZdchwFBKTSNTZDm4BMOs0HMXvlhJ/PpANSLH+1HRHVvpU/
         GYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=wENzCad3yZoNk4bwy6Bra3jNKAHsqTb4spJAG1j/rcg=;
        b=Km2Z+GUjGrTqJhKrI500S+Hu2/9NYrp20fQfYDW9t8sDNpLt4tNtwyFyQoWnIkA0Ig
         lF2B9j91EZHnxiwPJSsfit8JWNuuuwt/gBRDo9zzKta01Tp1KXvgIvuGD35R+I7i462F
         e6aObrtbxjJ8Keo+GDl1E1ViHzLtlnelR2yeYcyPwzhjtPjb7FJt+756ahaoahrA5Xiw
         e7iPorDYUL0DvDUHPXRq+Lh2lUaA9U5+Qefg3b+c/FxXpCDawIqZKcwG40m9aAv29caX
         m2LqdfGBeXtFWoV2VKUMfl6ZvRBo2bq+hWIVyA1coUAzX+QrwiFevDNbjo4vl6224xdK
         wNlA==
X-Gm-Message-State: AN3rC/7tYm0B2LmRoAgOU58vACzf25/LFG/p7VOkGyyUS8ANjruGibkF
        tUn85Xbxjdp8gQ==
X-Received: by 10.99.124.13 with SMTP id x13mr16467842pgc.81.1492504523929;
        Tue, 18 Apr 2017 01:35:23 -0700 (PDT)
Received: from localhost.localdomain ([115.118.46.164])
        by smtp.gmail.com with ESMTPSA id u129sm22448108pfu.48.2017.04.18.01.35.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Apr 2017 01:35:23 -0700 (PDT)
From:   Rahul Bedarkar <rahulbedarkar89@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     linux-kernel@vger.kernel.org,
        Rahul Bedarkar <rahulbedarkar89@gmail.com>
Subject: [PATCH] MAINTAINERS: Update email-id of Rahul Bedarkar
Date:   Tue, 18 Apr 2017 14:04:36 +0530
Message-Id: <1492504476-4703-1-git-send-email-rahulbedarkar89@gmail.com>
X-Mailer: git-send-email 2.7.4
Return-Path: <rahulbedarkar89@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57725
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rahulbedarkar89@gmail.com
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

I'm no longer with Imagination Technologies. I am still interested in
maintaining or reviewing DTS patches for Ci40 if any. Update email-id
to an active one.

Signed-off-by: Rahul Bedarkar <rahulbedarkar89@gmail.com>
---
I'm not sure via which tree this should get in. Since this entry was
merged via MIPS tree, I'm sending to linux-mips mailing list.

 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 892e958..9c5c208 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7903,7 +7903,7 @@ L:	linux-man@vger.kernel.org
 S:	Maintained
 
 MARDUK (CREATOR CI40) DEVICE TREE SUPPORT
-M:	Rahul Bedarkar <rahul.bedarkar@imgtec.com>
+M:	Rahul Bedarkar <rahulbedarkar89@gmail.com>
 L:	linux-mips@linux-mips.org
 S:	Maintained
 F:	arch/mips/boot/dts/img/pistachio_marduk.dts
-- 
2.7.4
