Return-Path: <SRS0=x683=O4=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71325C43387
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33E9621841
	for <linux-mips@archiver.kernel.org>; Wed, 19 Dec 2018 07:08:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pJiquXko"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728142AbeLSHII (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Wed, 19 Dec 2018 02:08:08 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:50448 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728139AbeLSHII (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Wed, 19 Dec 2018 02:08:08 -0500
Received: by mail-wm1-f67.google.com with SMTP id n190so4966691wmd.0
        for <linux-mips@vger.kernel.org>; Tue, 18 Dec 2018 23:08:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3jx4mdTCWjOvzPpR6UCLUwuF1mQniwEkf5b/n9rhRfQ=;
        b=pJiquXkosQ/EuCMnCBEaUh1wAUzUa0l6Wtth1VHpMIi6IPlYRXWhJ6mtgLL5KNBQS/
         Mhx+3/OqPhkpQCqGXtKL9iNldpvs7P3aWSLujPnTAgF8dedyovtBfbDXBVM0A4fFkC+5
         ljgspbwu4iIG/CC2Pq7sEHO5PC/dFa0kYMXEmIApOeGJI6C8s0qWO/eg9tYZYp93pELC
         4QtWvKUfCh1xVicxcxhC1CVNJMpbd8I0Ve9UCWyK4Lu44Q7fO+poVL7Puvg0R7L5jClE
         36TWrqnmDr++G08kGlx2+lvkeudLc6/ahRTp51HYs+XrZxfRpvOFT36RD5fd5bNccioj
         qOrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=3jx4mdTCWjOvzPpR6UCLUwuF1mQniwEkf5b/n9rhRfQ=;
        b=XbBdcweJbJcBJirFKqrjH2al74lomatnT7/3OFoa+/q2v/x5rkSwSc3Dv2s+vvPovQ
         KA62kOG4oPef0XW0ErYWd4azyi36qIOPOZh98h3pHp2ReCpiKIrOZVtXHtlBmzJ+/+NA
         TkraOLrkg6hAfpnZB6sYTkV64ufcuZRyrqWzXpVD9ky8EURdeJ4JV9nFKMIcvFSC3JNE
         AV7okanoPT+VVXCBHc2ccPiIEAEpkq4TOLmSvmu8wxkFB3A0xVSVD3ww+FKzteoQ1zul
         Dy5puSbl8TDhgmcamCmGPeUE7NX2A8vH/N6L+QnfMWdON+1+/c7/IVa45F5h4v8c0A40
         xa8w==
X-Gm-Message-State: AA+aEWY1lEv26CZcgmNjDDgXVqgfOqJrnJkZxP1xSZIVeeUDEEpql07b
        NWpV+chWnbvF5Bomn4U6tp4WCcoz
X-Google-Smtp-Source: AFSGD/XwqHns4Qf/66faoXUZyxAIOaL/WJKKENxd2jL79BFoD7qYzi4W73QevJLgoG8FtxpQUfKbmQ==
X-Received: by 2002:a1c:c64e:: with SMTP id w75mr6233377wmf.46.1545203286174;
        Tue, 18 Dec 2018 23:08:06 -0800 (PST)
Received: from flagship2.speedport.ip (p200300C20BD333581B9ECEB655B1C7D2.dip0.t-ipconnect.de. [2003:c2:bd3:3358:1b9e:ceb6:55b1:c7d2])
        by smtp.gmail.com with ESMTPSA id s16sm3245724wrt.77.2018.12.18.23.08.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Dec 2018 23:08:05 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@vger.kernel.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 0/5] MIPS: Alchemy updates for 4.20+
Date:   Wed, 19 Dec 2018 08:07:58 +0100
Message-Id: <20181219070803.449981-1-manuel.lauss@gmail.com>
X-Mailer: git-send-email 2.20.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Here's a bunch of fixes to restore almost all functionality to the
Alchemy devboards, against 4.20-rc7+.

#1 gets rid of a warning in the clockevent code,
#2 let's the Alchemy on-chip ethernet driver build again,
#3 removes board-specific IrDA code, as the driver is gone,
#4 sync up overrides with latest cpu-features
#5 adds dma_masks to sound and mmc devices to get them
   working again.

Verified on the DB1300 and DB1500 boards.

Manuel Lauss (5):
  MIPS: alchemy: cpu_all_mask is forbidden for clock event devices
  net: drivers/amd: restore access to MIPS Alchemy platform
  MIPS: Alchemy: drop DB1000 IrDA support bits
  MIPS: Alchemy: update cpu-feature-overrides
  MIPS: Alchemy: update dma masks for devboard devices

 arch/mips/alchemy/common/time.c               |  2 +-
 arch/mips/alchemy/devboards/db1000.c          | 76 +++----------------
 arch/mips/alchemy/devboards/db1200.c          | 24 +++---
 arch/mips/alchemy/devboards/db1300.c          | 23 +++++-
 arch/mips/alchemy/devboards/db1550.c          | 13 +++-
 .../asm/mach-au1x00/cpu-feature-overrides.h   |  3 +
 drivers/net/ethernet/amd/Kconfig              |  3 +-
 7 files changed, 58 insertions(+), 86 deletions(-)

-- 
2.20.0

