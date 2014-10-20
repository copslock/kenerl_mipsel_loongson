Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 22:57:39 +0200 (CEST)
Received: from mail-pd0-f170.google.com ([209.85.192.170]:49249 "EHLO
        mail-pd0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011968AbaJTUzPRsrg6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Oct 2014 22:55:15 +0200
Received: by mail-pd0-f170.google.com with SMTP id z10so175456pdj.1
        for <linux-mips@linux-mips.org>; Mon, 20 Oct 2014 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uuNRopr2IT6COfCJkPeEmpK8Y+NTFwVwAjF6HiNGKAY=;
        b=FhGXSceE5vqlm/lJUlcGbV/kPlb9kQuqzSczzwTPPZ2UShK83pPHDzqOMwEAAqSD4m
         nBy+O6KDkhkKIUAKLPJXq02tT8ItIOt7n/M4Ytou2SmfLYDzwzGJ3M3v6QIYyn25nRQe
         1nvL/9UGk5oUtQHlkGwqSG5hY05xE3BLMnrQe3EWeO0A/5Tq8QeI4W5fUISxb1mW+4e8
         aATplZRLvTzZoLn2zUwl7zTI/1vudE6QcCoRAAopcbbPhjiP/SQ3Z6P0gbasAy2hbpvW
         o1IoeozErh8M521Em2ohEWCiH1UGiu5OABFKtKqnUrBAGut4IhjYQxVRkB1YSjHe94pu
         qZPw==
X-Received: by 10.66.121.103 with SMTP id lj7mr30633812pab.84.1413838509360;
        Mon, 20 Oct 2014 13:55:09 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id fr7sm9954083pdb.79.2014.10.20.13.55.07
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 20 Oct 2014 13:55:08 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz, robh@kernel.org,
        grant.likely@linaro.org
Cc:     geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V2 9/9] MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver
Date:   Mon, 20 Oct 2014 13:54:08 -0700
Message-Id: <1413838448-29464-10-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
References: <1413838448-29464-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43388
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
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a20df9b..d483627 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7787,6 +7787,12 @@ S:	Maintained
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
