Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Feb 2017 06:58:39 +0100 (CET)
Received: from mail.gentoo.org ([IPv6:2001:470:ea4a:1:5054:ff:fec7:86e4]:51007
        "EHLO smtp.gentoo.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdBGF6Kt05qr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Feb 2017 06:58:10 +0100
Received: from helcaraxe.arda (c-73-201-78-97.hsd1.md.comcast.net [73.201.78.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kumba)
        by smtp.gentoo.org (Postfix) with ESMTPSA id B74BD341673;
        Tue,  7 Feb 2017 05:58:03 +0000 (UTC)
From:   Joshua Kinard <kumba@gentoo.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: [PATCH 0/3] MIPS: Xtalk: Updates/clean-ups
Date:   Tue,  7 Feb 2017 00:57:48 -0500
Message-Id: <20170207055751.8134-1-kumba@gentoo.org>
X-Mailer: git-send-email 2.11.1
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

This series performs a number of clean-ups on the Crosstalk (Xtalk)
code in the kernel.  Notable changes include:

- Remove IRIX-era typedefs and replace with standard types.
- Clean-up a few hex mask values and add whitespace to a few macros.
- Rewrite and document Xtalk access structures.
- Add platform data hooks to be used later in IP27 and IP30.

Joshua Kinard (3):
  MIPS: Xtalk: Replace several IRIX-era typedefs
  MIPS: Xtalk: Clean-up xtalk.h macros
  MIPS: Xtalk: Rewrite access structs in xwidget.h

 arch/mips/include/asm/sn/hub.h        |   4 +-
 arch/mips/include/asm/xtalk/xtalk.h   |  43 +---
 arch/mips/include/asm/xtalk/xwidget.h | 310 ++++++++++++++++++++----
 arch/mips/sgi-ip27/ip27-hubio.c       |   2 +-
 arch/mips/sgi-ip27/ip27-xtalk.c       |   4 +-
 5 files changed, 278 insertions(+), 85 deletions(-)

-- 
2.11.1
