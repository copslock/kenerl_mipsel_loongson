Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Apr 2008 01:59:24 +0200 (CEST)
Received: from smtp03.mtu.ru ([62.5.255.50]:45818 "EHLO smtp03.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1103045AbYDAX7S (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 2 Apr 2008 01:59:18 +0200
Received: from smtp03.mtu.ru (localhost.mtu.ru [127.0.0.1])
	by smtp03.mtu.ru (Postfix) with ESMTP id CD3751870750;
	Wed,  2 Apr 2008 03:58:46 +0400 (MSD)
Received: from localhost.localdomain (ppp91-76-28-42.pppoe.mtu-net.ru [91.76.28.42])
	by smtp03.mtu.ru (Postfix) with ESMTP id B30B2187084B;
	Wed,  2 Apr 2008 03:58:38 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/5] [MIPS] unexport a few symbols in MIPS-specific code
Date:	Wed,  2 Apr 2008 03:58:33 +0400
Message-Id: <1207094318-21748-1-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
X-DCC-STREAM-Metrics: smtp03.mtu.ru 10002; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18754
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

A few exported symbols in MIPS-specific code can be unexported,
and this series of patches does so.

This series was tested using a custom config that was produced
by running `make allmodconfig', after which the CONFIG_VORTEX
option was manually turned off. The patches I am submitting do
not touch the code affected by this option, however. Setting
this options on leads to unbuildable kernel independently of
whether the patches are applied.

Additionally, the entire patchset was tested at runtime by
booting the Malta 4Kc board up to the shell prompt and
inserting the `oprofile.ko' kernel module. The tests were
successful.

Thanks,
Dmitri
