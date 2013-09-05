Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Sep 2013 20:46:44 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:37639 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837146Ab3IESpnrZQMH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Sep 2013 20:45:43 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 523395A6CE8;
        Thu,  5 Sep 2013 21:45:41 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id dms1VymyIT7P; Thu,  5 Sep 2013 21:45:36 +0300 (EEST)
Received: from blackmetal.pp.htv.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp6.welho.com (Postfix) with ESMTP id 5B9395BC006;
        Thu,  5 Sep 2013 21:45:36 +0300 (EEST)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, linux-mips@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>, richard@nod.at,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: octeon-ethernet: bug fixes
Date:   Thu,  5 Sep 2013 21:43:58 +0300
Message-Id: <1378406641-16530-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37768
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Here's some simple fixes for that should improve the stability of
the driver.

Aaro Koskinen (3):
  staging: octeon-ethernet: make dropped packets to consume NAPI budget
  staging: octeon-ethernet: remove skb alloc failure warnings
  staging: octeon-ethernet: rgmii: enable interrupts that we can handle

 drivers/staging/octeon/ethernet-mem.c   | 7 +------
 drivers/staging/octeon/ethernet-rgmii.c | 4 +---
 drivers/staging/octeon/ethernet-rx.c    | 5 +----
 3 files changed, 3 insertions(+), 13 deletions(-)

-- 
1.8.3.2
