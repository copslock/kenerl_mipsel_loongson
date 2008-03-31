Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2008 00:11:30 +0200 (CEST)
Received: from smtp02.mtu.ru ([62.5.255.49]:23511 "EHLO smtp02.mtu.ru")
	by lappi.linux-mips.net with ESMTP id S1100127AbYCaWHu (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Apr 2008 00:07:50 +0200
Received: from smtp02.mtu.ru (localhost [127.0.0.1])
	by smtp02.mtu.ru (Postfix) with ESMTP id B399543AA0;
	Tue,  1 Apr 2008 02:04:08 +0400 (MSD)
Received: from localhost.localdomain (ppp85-140-79-111.pppoe.mtu-net.ru [85.140.79.111])
	by smtp02.mtu.ru (Postfix) with ESMTP id 76B9D45A06;
	Tue,  1 Apr 2008 02:03:17 +0400 (MSD)
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/6] [MIPS] make some functions and variables static
Date:	Tue,  1 Apr 2008 02:03:19 +0400
Message-Id: <1207001005-2633-1-git-send-email-dmitri.vorobiev@gmail.com>
X-Mailer: git-send-email 1.5.3.6
X-DCC-STREAM-Metrics: smtp02.mtu.ru 10001; Body=0 Fuz1=0 Fuz2=0
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I noticed that a few functions and variables in the MIPS-specific
code can become static, and this series of patches cleans up the
kernel global name space a little bit.

Please consider.

Thanks,
Dmitri Vorobiev
