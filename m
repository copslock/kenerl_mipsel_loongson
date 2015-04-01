Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Apr 2015 22:16:44 +0200 (CEST)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:33174 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014962AbbDAUQmjeZoS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Apr 2015 22:16:42 +0200
Received: by pdjg10 with SMTP id g10so6468731pdj.0
        for <linux-mips@linux-mips.org>; Wed, 01 Apr 2015 13:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=/SGSGuw2sIkDfxNc6hjkTM76Rpm1NPLNll9K4//7Yic=;
        b=YyPvTexZ0m9OoN2AgjPX+guuAnoLyRrRayK99C25hGwq7YIF5BFINbudSdW2ow4J/+
         3P+QgXLg9+p0GGvv+gygwkRXvteDhndWyavnsyCP5457qe44yqYi6Sqki4zt0SlqPbDo
         i2NyNMjW+prjnSFzGkcmrVU0zsnGXdlcuJOqUzh16OTyDwabyif36RBBJC5ViHdXQKbR
         yMyzHKXYbEb94W0pC3PyKbYv/8DJdDC9y/Z+q8tpESusTda3aOIItcCSmti9+WFqS87L
         CSKcgUWpc2f9oLfpj3tFepbmjibTITjI8SzUfabXBsLvUiNkHSYoVnQUEDQoGTswqFuE
         sXyw==
X-Gm-Message-State: ALoCoQkKBuVWSUXdWCFkc/s3qxmwsjpm++ZP7ru55C9PkQmJmgOjyttpj5kmpCAgmyinsrhB0eI1
X-Received: by 10.66.157.194 with SMTP id wo2mr51137282pab.17.1427919397433;
        Wed, 01 Apr 2015 13:16:37 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id t22si36930yho.2.2015.04.01.13.16.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Apr 2015 13:16:37 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id JFZMCvcY.1; Wed, 01 Apr 2015 13:16:37 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 3FFC1220636; Wed,  1 Apr 2015 13:16:36 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>
Subject: [PATCH 0/2] Pistachio USB2.0 PHY
Date:   Wed,  1 Apr 2015 13:16:32 -0700
Message-Id: <1427919394-3580-1-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.2.0.rc0.207.ga3a616c
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

This series adds support for the USB2.0 PHY present on the IMG Pistachio SoC.

Based on mips-for-linux-next and tested on the IMG Pistachio BuB.  If possible,
I'd like this to go through the MIPS tree with Kishon's ACK.

Cc: James Hartley <james.hartley@imgtec.com>
Cc: Damien Horsley <Damien.Horsley@imgtec.com>

Andrew Bresticker (2):
  phy: Add binding document for Pistachio USB2.0 PHY
  phy: Add driver for Pistachio USB2.0 PHY

 .../devicetree/bindings/phy/pistachio-usb-phy.txt  |  29 +++
 drivers/phy/Kconfig                                |   7 +
 drivers/phy/Makefile                               |   1 +
 drivers/phy/phy-pistachio-usb.c                    | 206 +++++++++++++++++++++
 include/dt-bindings/phy/phy-pistachio-usb.h        |  16 ++
 5 files changed, 259 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/phy/pistachio-usb-phy.txt
 create mode 100644 drivers/phy/phy-pistachio-usb.c
 create mode 100644 include/dt-bindings/phy/phy-pistachio-usb.h

-- 
2.2.0.rc0.207.ga3a616c
