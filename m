Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Aug 2014 21:36:27 +0200 (CEST)
Received: from mail-wi0-f174.google.com ([209.85.212.174]:64745 "EHLO
        mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27026882AbaHVTg0Kthmj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Aug 2014 21:36:26 +0200
Received: by mail-wi0-f174.google.com with SMTP id d1so158754wiv.1
        for <linux-mips@linux-mips.org>; Fri, 22 Aug 2014 12:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zYXcvw2VgX8jy+CV3dOFUyTs+HziSTCzvsUyqtd3+bA=;
        b=mhNRWPuwhOKq4577LvCn4oSqbF+ipP85B+eRg8wCmKuqJrjLNZOQb3RTCD75hNsQ/l
         YGcHjK+lgTAk1iPT8RgJUOVPN61xrsaNgzy8YtxDHRlO6m2bXifE32rdENjXY5EE6Vjr
         SNa5tMF++N1xE/PiCZoF1EanKQunnn7lvLIFVoG4KnXoUfMual794E/BxhknZ0R0CsKx
         XUBhkKeAoRjWlV2twGudl1KAapjFVtl1/nNZrk6rTzk1YY+DyglSi+J2vrv1OsMsADKm
         651AIfd4jR0XJCTMQDE5aXnA46zMLM/gVj8c5lVA2mDBID/iLOxI1TmIR2kmktBL0jp+
         InZg==
X-Received: by 10.180.79.72 with SMTP id h8mr17425005wix.55.1408563409943;
        Wed, 20 Aug 2014 12:36:49 -0700 (PDT)
Received: from localhost.localdomain (p4FD8DBDE.dip0.t-ipconnect.de. [79.216.219.222])
        by mx.google.com with ESMTPSA id vn10sm60779177wjc.28.2014.08.20.12.36.48
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 Aug 2014 12:36:49 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/4] MIPS: Alchemy devboard fixes and enhancements
Date:   Wed, 20 Aug 2014 21:36:29 +0200
Message-Id: <1408563393-132515-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.0.4
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

Here's a set of small patches to devboard support:
- when poweroff doesn't work, sit and spin in the idle loop to shut
  up systemd.
- updated cpu_feature_overrides which save ~7.5kB (db1xxx_defconfig)
- clock fixes
- support for pendown IRQ on DB1300: reduces timer interrupt rate
  when the touch is idle but open.

Manuel Lauss (4):
  MIPS: Alchemy: devboards: sit and spin after poweroff
  MIPS: Alchemy: update cpu-feature-overrides
  MIPS: Alchemy: db1xxx: explicitly set 50MHz clock for I2C/SPI units.
  MIPS: Alchemy: db1300: add touch penirq support

 arch/mips/alchemy/devboards/db1300.c               | 47 +++++++++++++++++++++-
 arch/mips/alchemy/devboards/db1550.c               |  9 ++---
 arch/mips/alchemy/devboards/platform.c             |  3 ++
 .../asm/mach-au1x00/cpu-feature-overrides.h        | 12 ++++++
 4 files changed, 65 insertions(+), 6 deletions(-)

-- 
2.0.4
