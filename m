Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Nov 2014 01:21:29 +0100 (CET)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:51738 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013762AbaKPATgJNopz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Nov 2014 01:19:36 +0100
Received: by mail-pd0-f176.google.com with SMTP id ft15so18825661pdb.7
        for <multiple recipients>; Sat, 15 Nov 2014 16:19:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8i5f+Sxh6hTo3I7177+kv0TAT5QNH8t3Otz1CXlRAuE=;
        b=O7feZjMXF38ky0ft66jONK5SszO6pOZRm6+j5+GRGRtQ9XelxTglihFlfJioklCc10
         TDrFXsHrAJcOf39RkcQG5ahr3ZMYw6aqI1blf/xP54BLi6y/EI+lXfdbcTaxLiMyY4qa
         kcypxhjESlO4MqB+WzNnd1hgwE7iohG8bwdmE94kdDLvaXzmzaGW8wEGILhYRB1dVZiE
         +K+AAdqk9jqOWnbtCf0dUH47GO1s28Fo5y4Ok8ESl2wVMN1wlcLjqcuoOMU/8LMSCixG
         06dxcqY4IvAScgeMH8OIp+UHjKgdrXanWzLkjXHMfbx2jB5G6JVrqqOYdqycxlcvlgSP
         KiRg==
X-Received: by 10.66.192.42 with SMTP id hd10mr10082221pac.55.1416097170532;
        Sat, 15 Nov 2014 16:19:30 -0800 (PST)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id xn4sm11099440pab.9.2014.11.15.16.19.29
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 15 Nov 2014 16:19:29 -0800 (PST)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     ralf@linux-mips.org
Cc:     f.fainelli@gmail.com, jfraser@broadcom.com, dtor@chromium.org,
        tglx@linutronix.de, jason@lakedaemon.net,
        linux-mips@linux-mips.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH V2 07/22] MIPS: BMIPS: Fix ".previous without corresponding .section" warnings
Date:   Sat, 15 Nov 2014 16:17:31 -0800
Message-Id: <1416097066-20452-8-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
References: <1416097066-20452-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44198
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Commit 078a55fc824c1 ("Delete __cpuinit/__CPUINIT usage from MIPS code")
removed our __CPUINIT directives, so now the ".previous" directives
are superfluous.  Remove them.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/bmips_vec.S | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/mips/kernel/bmips_vec.S b/arch/mips/kernel/bmips_vec.S
index 290c23b..8649507 100644
--- a/arch/mips/kernel/bmips_vec.S
+++ b/arch/mips/kernel/bmips_vec.S
@@ -208,7 +208,6 @@ bmips_reset_nmi_vec_end:
 END(bmips_reset_nmi_vec)
 
 	.set	pop
-	.previous
 
 /***********************************************************************
  * CPU1 warm restart vector (used for second and subsequent boots).
@@ -281,5 +280,3 @@ LEAF(bmips_enable_xks01)
 	jr	ra
 
 END(bmips_enable_xks01)
-
-	.previous
-- 
2.1.1
