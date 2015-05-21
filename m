Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2015 02:01:32 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14310 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006702AbbEVABa7Bfxn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2015 02:01:30 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id C32B8758F3491;
        Fri, 22 May 2015 01:01:23 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 22 May
 2015 01:01:27 +0100
Received: from laptop.hh.imgtec.org (10.100.200.44) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Fri, 22 May
 2015 01:01:26 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "Mike Turquette" <mturquette@linaro.org>, <sboyd@codeaurora.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        <cernekee@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 0/9] clk: pistachio: Assorted changes
Date:   Thu, 21 May 2015 20:57:34 -0300
Message-ID: <1432252663-31318-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.44]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47537
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ezequiel.garcia@imgtec.com
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

This patchset contains a bunch of clock changes for the Pistachio
clock driver.

The nine patches in this series are not really related, but I wasn't
sure it was worth to prepare a separate patchset for each group.
However, if this makes it harder to review, I can send different groups
of related patches.

Here's a brief summary of the patch groups:

Patches 1 and 2 clean up the PLL lock handling.

Patch 3 implements PLL rate adjustment, and in particular allows to support
small (i.e. neighbor-constrained) changes of the fractional PLL rate.

Patch 4 to 7 implements MIPS PLL rate change propagation and introduces
a table of MIPS PLL rate parameters.

Patch 8 adds some very useful sanity checks on integer and fractions PLL
set_rate(), to make sure the parameters are modified only when it's legal
to do so.

Patch 9 fixes the list of critical clocks.

None of these are urgent fixes so this is all v4.2 material.

Damien Horsley (1):
  clk: pistachio: Correct critical clock list

Ezequiel Garcia (7):
  clk: pistachio: Add a pll_lock() helper for clarity
  clk: pistachio: Lock the PLL when enabled upon rate change
  clk: pistachio: Implement PLL rate adjustment
  clk: pistachio: Extend DIV_F to pass clk_flags as well
  clk: pistachio: Add a MUX_F macro to pass clk_flags
  clk: pistachio: Propagate rate changes in the MIPS PLL clock sub-tree
  clk: pistachio: Add a rate table for the MIPS PLL

Kevin Cernekee (1):
  clk: pistachio: Add sanity checks on PLL configuration

 drivers/clk/pistachio/clk-pistachio.c |  63 ++++++++-----
 drivers/clk/pistachio/clk-pll.c       | 161 +++++++++++++++++++++++++++-------
 drivers/clk/pistachio/clk.c           |   5 +-
 drivers/clk/pistachio/clk.h           |  33 ++++++-
 4 files changed, 205 insertions(+), 57 deletions(-)

-- 
2.3.3
