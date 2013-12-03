Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Dec 2013 20:47:11 +0100 (CET)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:39602 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822668Ab3LCTrJM6vYa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Dec 2013 20:47:09 +0100
Received: by mail-ie0-f170.google.com with SMTP id qd12so25304645ieb.29
        for <multiple recipients>; Tue, 03 Dec 2013 11:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=dDmVmU3ab+0bl0bJzYHUGBelwesZ81x/xPiXJsBzfrQ=;
        b=SRnIlU+CX+jpde5wp8SkW8AaBPNEaV1CFWfiuJX43UDEwOhfTNsF1oi8wO9Q7LxvY3
         XD0/bDZCTQ+lVuCy6/eLFJJiMHTnUx/WIQ+DBkpFzs3lkSh1KOYz4UD/nK8oNmV5yns8
         Xn6K2bguEq/7qIA+Depm5xCtLPqgX0XB/0vqgkLVs/yHN1lcN90r6kGLAW+0uEc3wrAR
         sFSVvaRfsi22MJ/y8dcqhF3q0Z+ImD2bjOsgnXeSgc4tuzYNwcQKAnQ35F0AFWGWORSg
         JdHIGPlv0vdCtdy8LWn0ToMgYOUY3hJROaOO5EtOeVtbGHcjNJPE0sjiuqzIFS5s8G5y
         HAYA==
X-Received: by 10.43.16.2 with SMTP id pw2mr3460985icb.56.1386100022692;
        Tue, 03 Dec 2013 11:47:02 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id p5sm4686049igj.10.2013.12.03.11.47.00
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 03 Dec 2013 11:47:01 -0800 (PST)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id rB3Jkx74006112;
        Tue, 3 Dec 2013 11:46:59 -0800
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id rB3JktCC006111;
        Tue, 3 Dec 2013 11:46:55 -0800
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH 0/2] MIPS/staging: Probe octeon-usb driver via device-tree
Date:   Tue,  3 Dec 2013 11:46:50 -0800
Message-Id: <1386100012-6077-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Tested against both EdgeRouter LITE (no bootloader supplied device
tree), and ebb5610 (device tree supplied by bootloader).

The patch set is spread across both the MIPS and staging trees, so it
would be great if Ralf could merge at least the MIPS parts, if not
both parts.


David Daney (2):
  MIPS: OCTEON: Supply OCTEON+ USB nodes in internal device trees.
  staging: octeon-usb: Probe via device tree populated platform device.

 .../cavium-octeon/executive/cvmx-helper-board.c    |  27 ++
 arch/mips/cavium-octeon/octeon-platform.c          |  32 +++
 arch/mips/cavium-octeon/octeon_3xxx.dts            |  19 ++
 arch/mips/include/asm/octeon/cvmx-helper-board.h   |   9 +
 drivers/staging/octeon-usb/octeon-hcd.c            | 273 +++++++++------------
 5 files changed, 203 insertions(+), 157 deletions(-)

-- 
1.7.11.7
