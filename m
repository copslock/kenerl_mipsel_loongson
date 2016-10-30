Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 31 Oct 2016 00:03:07 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:46826 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992236AbcJ3XC7isQea (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 31 Oct 2016 00:02:59 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     rtc-linux@googlegroups.com,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org
Subject: [PATCH v2 0/7] DT bindings for the jz4740-rtc driver
Date:   Mon, 31 Oct 2016 00:02:40 +0100
Message-Id: <20161030230247.20538-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1477868578; bh=O2j8MHHdwOQK2a8LjOaAAxqx9kwJGQnkBkBBw4sCF5I=; h=From:To:Subject:Date:Message-Id; b=xu9jGi3vrZx2T7ed33z1IHFc2vYfy6fEQviWDvxPNRF2Ysn5ZQ4HsovgNhgLIIOZ/0xpowVkbfIq9NIUzx/UPuEiYMzOjfUbgDN0fVmmj1EuVMAnGRDqCFwZBQsWYkcuPjdjQcGE/mbmUn5LlCF1Xeff1r+8kLsoOGhluVjtgTw=
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55597
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

This patch set is a v2 of a patchset I sent in March.

The previous patch 5/5 was garbage and has been dropped.
It was garbage, for two reasons:
- It enforced the jz4740-rtc as the system power controller in the
  SoC devicetree file, which introduced policy (maybe the jz4740-based
  boards want to use something else as the system power controller)
- It added the 'system-power-controller' entry not to the jz4740-rtc driver
  node, but to the 'rtc' clock node... I don't know how that slipped in, but
  I apologise for that. I need to raise my QA standards.

For the rest:

1/7: No change

2/7:
- Remove 'interrupt-parent' of the list of required properties
- Add the -msec suffix for the DT entries that represent time

3/7: No change

4/7:
- Get a handle to the 'rtc' clock in the probe function, to handle errors early
- Call clk_prepare_enable() on the 'rtc' clock before calling clk_get_rate()
- Use the -msec suffix for the OF properties that deal with time
- Use of_property_read_32() instead of device_property_read_u32()

5/7, 6/7, 7/7: New patches
