Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Aug 2015 15:44:29 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64618 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012169AbbHFNo0YlFXI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Aug 2015 15:44:26 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2C8E91C13C602;
        Thu,  6 Aug 2015 14:44:18 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Thu, 6 Aug
 2015 14:44:20 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 6 Aug 2015 14:44:20 +0100
From:   Govindraj Raja <govindraj.raja@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-clk@vger.kernel.org>,
        Mike Turquette <mturquette@linaro.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        "Michael Turquette" <mturquette@baylibre.com>
CC:     Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        Govindraj Raja <govindraj.raja@imgtec.com>
Subject: [PATCH 0/6] clk: pistachio: Fixes for pll calculations.
Date:   Thu, 6 Aug 2015 14:43:28 +0100
Message-ID: <1438868614-7672-1-git-send-email-govindraj.raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48678
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: govindraj.raja@imgtec.com
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

Patch 1/6 to 5/6 are pll calculation fixes for clock settings.

Patch 6/6: Is a reword and repost based on earlier thread:
http://patchwork.linux-mips.org/patch/10108/

Series Based on 4.2-rc5
Tested with Pistachio Bring-up-Board.

Damien.Horsley (1):
  clk: pistachio: correct critical clock list

Zdenko Pulitika (5):
  clk: pistachio: Fix 32bit integer overflows
  clk: pistachio: Fix override of clk-pll settings from boot loader
  clk: pistachio: Fix pll rate calculation in integer mode
  clk: pistachio: Set operating mode in .set_rate
  pistachio: pll: Fix vco calculation in .set_rate (fractional)

 drivers/clk/pistachio/clk-pistachio.c | 19 ++++++---
 drivers/clk/pistachio/clk-pll.c       | 75 ++++++++++++++++++++++++++---------
 drivers/clk/pistachio/clk.h           | 18 +++++----
 3 files changed, 82 insertions(+), 30 deletions(-)

-- 
1.9.1
