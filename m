Return-Path: <SRS0=rTdo=QL=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CDAFC282CC
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0293C2083B
	for <linux-mips@archiver.kernel.org>; Mon,  4 Feb 2019 22:41:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726728AbfBDWl5 (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Mon, 4 Feb 2019 17:41:57 -0500
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:60568 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbfBDWl5 (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Mon, 4 Feb 2019 17:41:57 -0500
Received: from localhost.localdomain (85-76-69-76-nat.elisa-mobile.fi [85.76.69.76])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 19CBC30015;
        Tue,  5 Feb 2019 00:41:55 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/5] MIPS: OCTEON: avoid board-specific stuff in ethernet code
Date:   Tue,  5 Feb 2019 00:41:44 +0200
Message-Id: <20190204224149.8139-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

A small series that deletes some board-specific Ethernet knowledge
from the generic OCTEON code and moves it into the DT.

A.

Aaro Koskinen (5):
  MIPS: OCTEON: add fixed-link nodes to in-kernel device tree
  MIPS: OCTEON: warn if deprecated link status is being used
  MIPS: OCTEON: don't lie about interface type of CN3005 board
  MIPS: OCTEON: delete board-specific link status
  MIPS: OCTEON: program rx/tx-delay always from DT

 .../boot/dts/cavium-octeon/octeon_3xxx.dts    | 14 +++
 .../mips/boot/dts/cavium-octeon/ubnt_e100.dts |  6 ++
 .../executive/cvmx-helper-board.c             | 86 ++-----------------
 .../cavium-octeon/executive/cvmx-helper.c     | 19 +---
 arch/mips/cavium-octeon/octeon-platform.c     | 64 ++++++++++++++
 .../include/asm/octeon/cvmx-helper-board.h    | 12 ---
 6 files changed, 91 insertions(+), 110 deletions(-)

-- 
2.17.0

