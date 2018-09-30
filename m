Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 30 Sep 2018 18:21:42 +0200 (CEST)
Received: from smtprelay0039.hostedemail.com ([216.40.44.39]:34335 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990697AbeI3QViauEl2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 30 Sep 2018 18:21:38 +0200
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 7A741180A8CA8;
        Sun, 30 Sep 2018 16:21:36 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: glue83_481ec3db7d54f
X-Filterd-Recvd-Size: 1406
Received: from XPS-9350.home (unknown [47.151.153.53])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Sun, 30 Sep 2018 16:21:35 +0000 (UTC)
Message-ID: <ae2126ad8eab7d87b8a13cbe75d3ba27e2df22a7.camel@perches.com>
Subject: [PATCH] MAINTAINERS: MIPS/LOONGSON2 ARCHITECTURE - Use the normal
 wildcard style
From:   Joe Perches <joe@perches.com>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 30 Sep 2018 09:21:34 -0700
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66623
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

Neither git nor get_maintainer understands the curly brace style.

Signed-off-by: Joe Perches <joe@perches.com>
---
 MAINTAINERS | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1c62b724bb60..f6ab4f3bccfb 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9770,7 +9770,8 @@ MIPS/LOONGSON2 ARCHITECTURE
 M:	Jiaxun Yang <jiaxun.yang@flygoat.com>
 L:	linux-mips@linux-mips.org
 S:	Maintained
-F:	arch/mips/loongson64/*{2e/2f}*
+F:	arch/mips/loongson64/fuloong-2e/
+F:	arch/mips/loongson64/lemote-2f/
 F:	arch/mips/include/asm/mach-loongson64/
 F:	drivers/*/*loongson2*
 F:	drivers/*/*/*loongson2*
