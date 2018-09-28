Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Sep 2018 00:00:49 +0200 (CEST)
Received: from smtprelay0195.hostedemail.com ([216.40.44.195]:60391 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993976AbeI1WAi33fvA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 29 Sep 2018 00:00:38 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 0D39F180A814A;
        Fri, 28 Sep 2018 22:00:37 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: blow36_545c0defa701
X-Filterd-Recvd-Size: 2752
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 22:00:36 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>, linux-mips@linux-mips.org
Subject: Bad MAINTAINERS pattern in section 'MIPS/LOONGSON3 ARCHITECTURE'
Date:   Fri, 28 Sep 2018 15:00:34 -0700
Message-Id: <20180928220034.30697-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

Please fix this defect appropriately.

linux-next MAINTAINERS section:

	9766	MIPS/LOONGSON3 ARCHITECTURE
	9767	M:	Huacai Chen <chenhc@lemote.com>
	9768	L:	linux-mips@linux-mips.org
	9769	S:	Maintained
	9770	F:	arch/mips/loongson64/
	9771	F:	arch/mips/include/asm/mach-loongson64/
	9772	F:	drivers/platform/mips/cpu_hwmon.c
	9773	F:	drivers/*/*loongson3*
-->	9774	F:	drivers/*/*/*loongson3*

Commit that introduced this:

commit ffe1f9356fbe55df7dd7f7f6b050ee8b7136611f
 Author: Huacai Chen <chenhc@lemote.com>
 Date:   Thu Dec 7 14:31:08 2017 +0800
 
     MAINTAINERS: Add Loongson-2/Loongson-3 maintainers
     
     Add Jiaxun Yang as the MIPS/Loongson-2 maintainer and add Huacai Chen
     as the MIPS/Loongson-3 maintainer.
     
     [ralf@linux-mips.org: Don't put all of drivers/platform/mips/ into these
     two entries but rather only the files required even though at this time
     the Loongson platforms are the only users of drivers/platform/mips/.]
     
     Signed-off-by: Huacai Chen <chenhc@lemote.com>
     Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
     Cc: Linus Torvalds <torvalds@linux-foundation.org>
     Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     Cc: Stephen Rothwell <sfr@canb.auug.org.au>
     Cc: James Hogan <james.hogan@mips.com>
     Cc: Rui Wang <wangr@lemote.com>
     Cc: Binbin Zhou <zhoubb@lemote.com>
     Cc: Ce Sun <sunc@lemote.com>
     Cc: Yao Wang <wangyao@lemote.com>
     Cc: Liangliang Huang <huangll@lemote.com>
     Cc: Fuxin Zhang <zhangfx@lemote.com>
     Cc: Zhangjin Wu <wuzhangjin@gmail.com>
     Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>
     Cc: r@hev.cc
     Cc: zhoubb.aaron@gmail.com
     Cc: huanglllzu@163.com
     Cc: 513434146@qq.com
     Cc: 1393699660@qq.com
     Cc: linux-mips@linux-mips.org
     Cc: linux-kernel@vger.kernel.org
     Cc: Huacai Chen <chenhc@lemote.com>
     Patchwork: https://patchwork.linux-mips.org/patch/17888/
     Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
     Signed-off-by: James Hogan <jhogan@kernel.org>
 
  MAINTAINERS | 19 +++++++++++++++++++
  1 file changed, 19 insertions(+)

No commit with drivers/*/*/*loongson3* found
