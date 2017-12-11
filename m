Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Dec 2017 17:13:36 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:35420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990436AbdLKQNaOBSZu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 11 Dec 2017 17:13:30 +0100
Received: from localhost.localdomain (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5200A20C01;
        Mon, 11 Dec 2017 16:13:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5200A20C01
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org
Cc:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Maciej W . Rozycki" <macro@mips.com>
Subject: [PATCH 0/2] MIPS: mipsregs.h: Optimise read of const Cop0 regs
Date:   Mon, 11 Dec 2017 16:13:13 +0000
Message-Id: <cover.a0a46ee9377083562543020efa89accdc3760bbe.1513004494.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.13.6
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61418
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

Certain coprocessor 0 registers (namely CP0_PRId) should never change,
and can safely be read with a non-volatile inline asm statement. This
improves performance under virtualisation, since access to the CP0_PRId
register traps even with hardware assisted virtualisation (VZ), and the
use of volatile prevents the compiler discarding the MFC0 if the value
isn't used.

Patch 1 adds alternative COP0 read macros for registers which shouldn't
change, and patch 2 uses one of those macros to read CP0_PRId.

Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Maciej W. Rozycki <macro@mips.com>
Cc: linux-mips@linux-mips.org

James Hogan (2):
  MIPS: mipsregs.h: Add read const Cop0 macros
  MIPS: mipsregs.h: Make read_c0_prid use const accessor

 arch/mips/include/asm/mipsregs.h | 39 +++++++++++++++++++++++----------
 1 file changed, 28 insertions(+), 11 deletions(-)

base-commit: ae64f9bd1d3621b5e60d7363bc20afb46aede215
-- 
git-series 0.9.1
