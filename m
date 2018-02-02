Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2018 23:15:19 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:49474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991025AbeBBWPLwrdag (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Feb 2018 23:15:11 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC4221759;
        Fri,  2 Feb 2018 22:15:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC4221759
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Aleksandar Markovic <aleksandar.markovic@mips.com>,
        Goran Ferenc <goran.ferenc@mips.com>,
        Miodrag Dinic <miodrag.dinic@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>
Subject: [PATCH 0/4] MIPS: generic: Fixes for Ranchu platform
Date:   Fri,  2 Feb 2018 22:14:08 +0000
Message-Id: <cover.fcf1b08ac94759a5cd4b4303f350734b68872619.1517609353.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
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

These are a few fixes for the Ranchu platform which is now applied to my
4.16 branch, which should fix boot on non-Ranchu "generic" platforms.

Fixes: eed0eabd12ef ("MIPS: generic: Introduce generic DT-based board support")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Miodrag Dinic <miodrag.dinic@mips.com>
Cc: Goran Ferenc <goran.ferenc@mips.com>
Cc: Aleksandar Markovic <aleksandar.markovic@mips.com>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: linux-mips@linux-mips.org

James Hogan (4):
  MIPS: generic: Fix machine compatible matching
  MIPS: generic: Fix ranchu_of_match[] termination
  MIPS: generic: Fix Makefile alignment
  MIPS: generic: Don't claim PC parport/serio

 arch/mips/Kconfig                | 4 ++--
 arch/mips/generic/Makefile       | 2 +-
 arch/mips/generic/board-ranchu.c | 1 +
 arch/mips/include/asm/machine.h  | 2 +-
 4 files changed, 5 insertions(+), 4 deletions(-)

base-commit: 6045f241b48f07b2fb80905bf49671f457a8c037
-- 
git-series 0.9.1
