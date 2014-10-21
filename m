Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2014 00:26:20 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:47733 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012096AbaJUWXpTQ4kO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2014 00:23:45 +0200
Received: by mail-pa0-f46.google.com with SMTP id fa1so2329309pad.33
        for <linux-mips@linux-mips.org>; Tue, 21 Oct 2014 15:23:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=uuNRopr2IT6COfCJkPeEmpK8Y+NTFwVwAjF6HiNGKAY=;
        b=y0qFZpd2hQt3IZ9b3C2Zx0L9wEOlHoikQvzTz6S3+26qZpgLofI+zz86IegK3hK2cF
         ID+7c1iLjwji9EHyOuvQs01O8nUtG7xKS0CYE9h5FkH+Y2NMWXsmutjl0J4M7VTAbWXv
         iu1X5QueMJ7HfOge/OF5doQ0vNHS7+I6azB/zfwBuw7bytYtg3p63f7HsC75ZFP/DOA3
         ufkdwVn4q6TLmCkGv7vteK3MXnLu+W9LbA3rIiF5DZmmOY2jbB0Oq5M10fZa9FbmD4sC
         Ddfkt3AsZ+F7wo99mjUe2D7HigZiTy9pqjFI0khL9C9xdHhoVBkmtVnyWXO95FgF42eV
         ESAQ==
X-Received: by 10.70.56.70 with SMTP id y6mr38373890pdp.61.1413930219352;
        Tue, 21 Oct 2014 15:23:39 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id al4sm12702816pbc.19.2014.10.21.15.23.37
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 15:23:38 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     gregkh@linuxfoundation.org, jslaby@suse.cz
Cc:     robh@kernel.org, grant.likely@linaro.org, arnd@arndb.de,
        geert@linux-m68k.org, f.fainelli@gmail.com, mbizon@freebox.fr,
        jogo@openwrt.org, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH V3 10/10] MAINTAINERS: Add entry for rp2 (Rocketport Express/Infinity) driver
Date:   Tue, 21 Oct 2014 15:23:06 -0700
Message-Id: <1413930186-23168-11-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
References: <1413930186-23168-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43446
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
