Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Aug 2015 18:12:11 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13368 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007608AbbHZQMJhY2Gd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Aug 2015 18:12:09 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 12824AAE2C850;
        Wed, 26 Aug 2015 17:12:00 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 26 Aug
 2015 17:12:03 +0100
Received: from imgworks-VB.kl.imgtec.org (192.168.167.141) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 26 Aug 2015 17:12:03 +0100
From:   Govindraj Raja <Govindraj.Raja@imgtec.com>
To:     <linux-mips@linux-mips.org>, <linux-clk@vger.kernel.org>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
CC:     Zdenko Pulitika <zdenko.pulitika@imgtec.com>,
        Kevin Cernekee <cernekee@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "Andrew Bresticker" <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Govindraj Raja <Govindraj.Raja@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        Govindraj Raja <govindraj.raja@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH v6 0/4] clk: pistachio: Fixes for pll calculations.
Date:   Wed, 26 Aug 2015 17:11:36 +0100
Message-ID: <1440605500-13274-1-git-send-email-Govindraj.Raja@imgtec.com>
X-Mailer: git-send-email 1.9.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.167.141]
Return-Path: <Govindraj.Raja@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49022
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Govindraj.Raja@imgtec.com
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

From: Govindraj Raja <govindraj.raja@imgtec.com>

Patch 1/4 to 3/4 are pll calculation fixes for clock settings.

Patch 4/4: Is a reword and repost based on earlier thread:
http://patchwork.linux-mips.org/patch/10108/

Series Based on 4.2-rc7
Tested with Pistachio Bring-up-Board.

Changes from v5:
----------------
Cc: <stable@vger.kernel.org> # 4.1

This patch series is needed for 4.1-stable as well.
So adding necessary commit-id for Fixes.
Boot is broken on 4.1 stable without this patch series.

Changes from v4:
----------------
Fixes comments from Andrew and added Andrew's
reviewed by.

http://patchwork.linux-mips.org/patch/11014/
http://patchwork.linux-mips.org/patch/11016/


Changes from v3:
---------------
Fixes comments to bring back the poll rate table with
unsigned long int as discussed in below thread.

http://patchwork.linux-mips.org/patch/10900/

Changes from v2:
---------------
Fixes comments from Sergei as dicussed in below thread:
http://patchwork.linux-mips.org/patch/10903/

Changes from v1:
---------------
Fix comments from Andrew.
Topics:

* http://patchwork.linux-mips.org/patch/10888/
  (Remove long conversion for pll_rate_table variables)
	
* http://patchwork.linux-mips.org/patch/10889/
  (reword pll to PLL)

* http://patchwork.linux-mips.org/patch/10891/
  (squash 4/6 to 3/6)

* http://patchwork.linux-mips.org/patch/10892/
  (squash 5/6 to 3/6) 

* http://patchwork.linux-mips.org/patch/10893/
  (Add missing signed-off)


Damien.Horsley (1):
  clk: pistachio: correct critical clock list

Zdenko Pulitika (3):
  clk: pistachio: Fix 32bit integer overflows
  clk: pistachio: Fix override of clk-pll settings from boot loader
  clk: pistachio: Fix PLL rate calculation in integer mode

 drivers/clk/pistachio/clk-pistachio.c | 19 ++++++---
 drivers/clk/pistachio/clk-pll.c       | 77 +++++++++++++++++++++++++++--------
 drivers/clk/pistachio/clk.h           | 14 +++----
 3 files changed, 80 insertions(+), 30 deletions(-)

-- 
1.9.1
