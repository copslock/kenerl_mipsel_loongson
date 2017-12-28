Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 17:30:29 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:49336 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990506AbdL1Q3zxXzSB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 17:29:55 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [PATCH 0/7] jz4740 watchdog driver & platform cleanups
Date:   Thu, 28 Dec 2017 17:29:32 +0100
Message-Id: <20171228162939.3928-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514478593; bh=5ed4bewwose2oXpsCecetM0ZXn8+sUF7FjHfvGoDkXc=; h=From:To:Cc:Subject:Date:Message-Id; b=PjMuJZ+xg5h9bYxB09jUNrR18Q1nDlMuO8YcoADeMJF0rA/qzS2Vt+ICokk1noXoUpcSjYtwqCp0r60JMfKXIX4VgVw8tyu4m+Rif2D/366JX2noKWJ1pLQGvFxcURxCZwA4vrS/yJzt69aWhS9V0FKPn1NeuDhRVV2ZDJ8iMtg=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61667
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

Hi,

This patchset is meant to drop the platform code that handles the system
reset, since the watchdog driver can be used for this task.

Some fixes and cleanups are also included.

Thanks,
-Paul Cercueil
