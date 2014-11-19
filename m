Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 22:53:01 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:56912 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014046AbaKSVw6R0pVA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 22:52:58 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id E059056F7A8;
        Wed, 19 Nov 2014 23:52:57 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id Vr9Lc+F2HZV7; Wed, 19 Nov 2014 23:52:51 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 5CB055BC006;
        Wed, 19 Nov 2014 23:52:51 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 0/7] MIPS: loongson: cleanups
Date:   Wed, 19 Nov 2014 23:52:44 +0200
Message-Id: <1416433971-18604-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.1.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44302
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

Some simple cleanup patches to reduce annoying sparse warning noise.
Unfortunately not everything gets fixes these...

Aaro Koskinen (7):
  MIPS: loongson: common: fix array initializer syntax
  MIPS: loongson: cs5536_pci: add a missing include
  MIPS: loongson: common: setup: add a missing include
  MIPS: loongson: lemote-2f: irq: make internal data static
  MIPS: loongson: lemote-2f: reset: make ml2f_reboot static
  MIPS: loongson: common: init: add a missing include
  MIPS: loongson: common: rtc: make loongson_rtc_resources static

 arch/mips/loongson/common/cs5536/cs5536_pci.c | 25 +++++++++++++------------
 arch/mips/loongson/common/init.c              |  1 +
 arch/mips/loongson/common/machtype.c          | 26 +++++++++++++-------------
 arch/mips/loongson/common/rtc.c               |  2 +-
 arch/mips/loongson/common/serial.c            | 26 +++++++++++++-------------
 arch/mips/loongson/common/setup.c             |  1 +
 arch/mips/loongson/lemote-2f/irq.c            |  4 ++--
 arch/mips/loongson/lemote-2f/reset.c          |  2 +-
 8 files changed, 45 insertions(+), 42 deletions(-)

-- 
2.1.2
