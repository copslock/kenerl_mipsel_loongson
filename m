Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jul 2017 18:30:34 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:41458 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991978AbdGBQa1ostzq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jul 2017 18:30:27 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org
Subject: [PATCH v3 00/18] JZ4770 support
Date:   Sun,  2 Jul 2017 18:29:58 +0200
Message-Id: <20170702163016.6714-1-paul@crapouillou.net>
In-Reply-To: <20170607200439.24450-2-paul@crapouillou.net>
References: <20170607200439.24450-2-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1499013021; bh=zeB75bTFO+pLqcEQkcpm0hu7PudKgtDbeHmjYMT4QcE=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=lhqmWAwLRxHDICTQRA11ifhnlsx4PvenSs25FNSSXVukAtqeSOl1DGzUJn5vbS8aYn8aOAq1Hfh3qugfUj6gX4MuYTj4xnJMfc2NuMIp1I101534qRd1n/A3pA6fjfL+ZJneBmJgt1hbjXzAHz4oMybbp6N2L8UHWVc0+eBa0L0=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58943
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

This is the v3 of my patchset that introduces support for the jz4770 SoC
from Ingenic.

The only change in the whole series is that now
<dt-bindings/clock/jz4770-cgu.h> is introduced in a separate patch (05/18).
