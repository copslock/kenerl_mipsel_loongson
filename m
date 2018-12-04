Return-Path: <SRS0=TQVq=ON=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8400C65BB3
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7FE520834
	for <linux-mips@archiver.kernel.org>; Tue,  4 Dec 2018 20:20:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A7FE520834
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=iki.fi
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbeLDUUZ (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 4 Dec 2018 15:20:25 -0500
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:41656 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLDUUZ (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 4 Dec 2018 15:20:25 -0500
Received: from localhost.localdomain (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id A9ACBB0025;
        Tue,  4 Dec 2018 22:12:47 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, linux-mips@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 0/6] MIPS: OCTEON: cleanups, part II
Date:   Tue,  4 Dec 2018 22:12:14 +0200
Message-Id: <20181204201220.12667-1-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.17.0
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

Hi,

Continuing OCTEON cleanups:

- Enable all drivers in defconfig to get the full build coverage.

- Some small adjustements to platform code to allow mechanical deletion of
  a huge amount of unneeded union fields.

Boot tested on OCTEON+ (EdgeRouter Lite) and OCTEON 2 (EdgeRouter Pro).

Build tested with cavium_octeon_defconfig.

A.

Aaro Koskinen (6):
  MIPS: OCTEON: enable all OCTEON drivers in defconfig
  MIPS: OCTEON: octeon-usb: use common gpio_bit definition
  MIPS: OCTEON: cvmx_pko_mem_debug8: use oldest forward compatible
    definition
  MIPS: OCTEON: cvmx_mio_fus_dat3: use oldest forward compatible
    definition
  MIPS: OCTEON: cvmx_gmxx_inf_mode: use oldest forward compatible
    definition
  MIPS: OCTEON: delete redundant register definitions

 .../cavium-octeon/executive/cvmx-cmd-queue.c  |    2 +-
 .../cavium-octeon/executive/cvmx-helper.c     |    4 +-
 .../executive/cvmx-interrupt-rsl.c            |    2 +-
 .../cavium-octeon/executive/octeon-model.c    |   12 +-
 arch/mips/cavium-octeon/octeon-usb.c          |    6 +-
 arch/mips/configs/cavium_octeon_defconfig     |    2 +-
 arch/mips/include/asm/octeon/cvmx-agl-defs.h  |  699 ----------
 arch/mips/include/asm/octeon/cvmx-asxx-defs.h |  105 --
 arch/mips/include/asm/octeon/cvmx-dbg-defs.h  |    4 -
 arch/mips/include/asm/octeon/cvmx-dpi-defs.h  |  178 ---
 arch/mips/include/asm/octeon/cvmx-fpa-defs.h  |  247 ----
 arch/mips/include/asm/octeon/cvmx-gmxx-defs.h |  118 --
 arch/mips/include/asm/octeon/cvmx-gpio-defs.h |  116 --
 arch/mips/include/asm/octeon/cvmx-iob-defs.h  |  375 ------
 arch/mips/include/asm/octeon/cvmx-ipd-defs.h  |  538 --------
 arch/mips/include/asm/octeon/cvmx-l2t-defs.h  |    6 -
 arch/mips/include/asm/octeon/cvmx-led-defs.h  |   78 --
 arch/mips/include/asm/octeon/cvmx-lmcx-defs.h |  514 -------
 arch/mips/include/asm/octeon/cvmx-mio-defs.h  | 1197 -----------------
 arch/mips/include/asm/octeon/cvmx-mixx-defs.h |  136 --
 arch/mips/include/asm/octeon/cvmx-npei-defs.h |  295 ----
 arch/mips/include/asm/octeon/cvmx-npi-defs.h  |  235 ----
 arch/mips/include/asm/octeon/cvmx-pci-defs.h  |  392 ------
 arch/mips/include/asm/octeon/cvmx-pcsx-defs.h |  185 ---
 .../mips/include/asm/octeon/cvmx-pcsxx-defs.h |  146 --
 arch/mips/include/asm/octeon/cvmx-pemx-defs.h |  144 --
 .../mips/include/asm/octeon/cvmx-pescx-defs.h |   59 -
 arch/mips/include/asm/octeon/cvmx-pip-defs.h  |  688 ----------
 arch/mips/include/asm/octeon/cvmx-pko-defs.h  |  619 ---------
 arch/mips/include/asm/octeon/cvmx-pko.h       |    2 +-
 arch/mips/include/asm/octeon/cvmx-pow-defs.h  |  317 -----
 arch/mips/include/asm/octeon/cvmx-rnm-defs.h  |   53 -
 arch/mips/include/asm/octeon/cvmx-rst-defs.h  |   28 -
 arch/mips/include/asm/octeon/cvmx-smix-defs.h |   88 --
 arch/mips/include/asm/octeon/cvmx-spxx-defs.h |   62 -
 .../mips/include/asm/octeon/cvmx-sriox-defs.h |  123 --
 arch/mips/include/asm/octeon/cvmx-srxx-defs.h |   22 -
 arch/mips/include/asm/octeon/cvmx-stxx-defs.h |   64 -
 .../mips/include/asm/octeon/cvmx-uctlx-defs.h |   89 --
 39 files changed, 15 insertions(+), 7935 deletions(-)

-- 
2.17.0

