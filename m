Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Sep 2018 23:58:36 +0200 (CEST)
Received: from smtprelay0129.hostedemail.com ([216.40.44.129]:44480 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993976AbeI1V6cLsiCA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Sep 2018 23:58:32 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 41E68181D3417;
        Fri, 28 Sep 2018 21:58:30 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: tank87_84587560e661f
X-Filterd-Recvd-Size: 2729
Received: from joe-laptop.perches.com (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Fri, 28 Sep 2018 21:58:29 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Jiaxun Yang <jiaxun.yang@flygoat.com>, linux-mips@linux-mips.org
Subject: Bad MAINTAINERS pattern in section 'MIPS/LOONGSON2 ARCHITECTURE'
Date:   Fri, 28 Sep 2018 14:58:27 -0700
Message-Id: <20180928215828.30526-1-joe@perches.com>
X-Mailer: git-send-email 2.15.0
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66612
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

	9757	MIPS/LOONGSON2 ARCHITECTURE
	9758	M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
	9759	L:	linux-mips@linux-mips.org
	9760	S:	Maintained
	9761	F:	arch/mips/loongson64/*{2e/2f}*
	9762	F:	arch/mips/include/asm/mach-loongson64/
	9763	F:	drivers/*/*loongson2*
-->	9764	F:	drivers/*/*/*loongson2*

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

No commit with drivers/*/*/*loongson2* found
