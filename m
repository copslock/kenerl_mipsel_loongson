Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 04:31:22 +0200 (CEST)
Received: from mail-pa0-f51.google.com ([209.85.220.51]:57169 "EHLO
        mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010897AbaJSCawRU3F2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 04:30:52 +0200
Received: by mail-pa0-f51.google.com with SMTP id lj1so3031163pab.38
        for <linux-mips@linux-mips.org>; Sat, 18 Oct 2014 19:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AAd+a/scd5DS67KZEW/FNoEaaACdTIP9Wm8lFjrKRzQ=;
        b=OtUG/LxzeesSJs/QiOEQ7VLMdj200vLR4jMjB98oyNscqP0oOkAMCzTr72bBmJyYvM
         7ncu1BVAZdkJaQS6axzjd27waAEne4UjQAzylTIfh44QmiGGoJdIWjkjdevdC+DCRmB5
         wJE9LP7mcMtN2EzG2i4xnl8ZjstgwsJd3m0aQrmei2QD1KwR28t1fu55fYHSyOkOMcqH
         08wH0C+AC45BZe5w7QLdN77sfd5pQnZMNCbtQwcx7sxwn7AnV+AXdr4bY3J7TRZuF5ze
         q3sNi9jSKqSPtSY0MhmyBrQECcjthL06psNlzl0sSzgpwOTjW7js+GCYHfMDyNlyBGlY
         ociQ==
X-Received: by 10.70.37.79 with SMTP id w15mr18696087pdj.8.1413685845027;
        Sat, 18 Oct 2014 19:30:45 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id gi11sm5298159pbd.48.2014.10.18.19.30.43
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 18 Oct 2014 19:30:44 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     f.fainelli@gmail.com, mbizon@freebox.fr, jogo@openwrt.org,
        linux-mips@linux-mips.org, linux-serial@vger.kernel.org
Subject: [PATCH 3/3] MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver
Date:   Sat, 18 Oct 2014 19:30:18 -0700
Message-Id: <1413685818-32265-3-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43334
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

I wrote this driver and use it daily on several machines for work, so
why not.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 809ecd6..c08d8d5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7663,6 +7663,12 @@ S:	Maintained
 F:	Documentation/serial/rocket.txt
 F:	drivers/tty/rocket*
 
+ROCKETPORT EXPRESS/INFINITY DRIVER
+M:	Kevin Cernekee <cernekee@gmail.com>
+L:	linux-serial@vger.kernel.org
+S:	Odd Fixes
+F:	drivers/tty/serial/rp2.*
+
 ROSE NETWORK LAYER
 M:	Ralf Baechle <ralf@linux-mips.org>
 L:	linux-hams@vger.kernel.org
-- 
2.1.1
