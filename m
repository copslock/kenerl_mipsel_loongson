Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 May 2015 00:09:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10681 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007054AbbEZWJkf61Ux (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 May 2015 00:09:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 793732E08124B;
        Tue, 26 May 2015 23:09:33 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 26 May
 2015 23:04:33 +0100
Received: from laptop.hh.imgtec.org (10.100.200.175) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 26 May
 2015 23:04:32 +0100
From:   Ezequiel Garcia <ezequiel.garcia@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        "Mike Turquette" <mturquette@linaro.org>, <sboyd@codeaurora.org>
CC:     Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <james.hartley@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>, <cernekee@chromium.org>,
        <Govindraj.Raja@imgtec.com>, <Damien.Horsley@imgtec.com>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: [PATCH 0/3] clk: pistachio: Assorted fixes
Date:   Tue, 26 May 2015 19:01:06 -0300
Message-ID: <1432677669-29581-1-git-send-email-ezequiel.garcia@imgtec.com>
X-Mailer: git-send-email 2.3.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.175]
Return-Path: <Ezequiel.Garcia@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47685
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

This patchset contains a few fixes for the Pistachio
clock driver.

This is based on the series "clk: pistachio: Assorted changes"
(http://permalink.gmane.org/gmane.linux.kernel/1960107). I've dropped
the patches related to the fractional and integer PLLs rate change
and left only the fixes, as the rest might need some polishing.

Here's a brief summary of the patches:

Patches 1 and 2 clean up the PLL lock handling.

Patch 3 adds some very useful sanity checks on integer and fractions PLL
set_rate(), to make sure the parameters are modified only when it's legal
to do so.

None of these are really urgent fixes so this is all v4.2 material.
Hope we are still in time!

Ezequiel Garcia (2):
  clk: pistachio: Add a pll_lock() helper for clarity
  clk: pistachio: Lock the PLL when enabled upon rate change

Kevin Cernekee (1):
  clk: pistachio: Add sanity checks on PLL configuration

 drivers/clk/pistachio/clk-pll.c | 115 ++++++++++++++++++++++++++++++++--------
 1 file changed, 93 insertions(+), 22 deletions(-)

-- 
2.3.3
