Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Feb 2018 17:13:06 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:44650 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992866AbeBIQM63rnwS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Feb 2018 17:12:58 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D448721726;
        Fri,  9 Feb 2018 16:12:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D448721726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Paul Burton <paul.burton@mips.com>,
        Matt Redfearn <matt.redfearn@mips.com>,
        linux-kbuild@vger.kernel.org
Subject: [PATCH 0/3] MIPS: Generic defconfig Makefile improvements
Date:   Fri,  9 Feb 2018 16:11:55 +0000
Message-Id: <cover.e6abe4a455cad25b6663ceb7da02aee67a3be269.1518192692.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62476
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

This series adds the following MIPS Makefile targets and improves the
MIPS "make help" text to list these things too:
 - list_generic_defconfigs - list specific generic defconfig names
 - list_generic_boards     - list boards that can be passed to BOARDS
 - list_legacy_defconfigs  - list legacy defconfigs

This will be helpful for CI builders to be able to automatically pick up
generic defconfigs that aren't directly represented as files in
arch/mips/configs/.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: Paul Burton <paul.burton@mips.com>
Cc: Matt Redfearn <matt.redfearn@mips.com>
Cc: linux-mips@linux-mips.org
Cc: linux-kbuild@vger.kernel.org

James Hogan (3):
  MIPS: Refactor legacy defconfigs
  MIPS: Add generic list_* Makefile targets
  MIPS: Expand help text to list generic defconfigs

 Makefile           |  2 +-
 arch/mips/Makefile | 89 ++++++++++++++++++++++++++++++++---------------
 2 files changed, 63 insertions(+), 28 deletions(-)

base-commit: 791412dafbbfd860e78983d45cf71db603a82f67
-- 
git-series 0.9.1
