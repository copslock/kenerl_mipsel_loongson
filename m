Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2014 23:39:52 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:39164 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6869766AbaCLWjuUKMXm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Mar 2014 23:39:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 51FC05A6E99;
        Thu, 13 Mar 2014 00:39:46 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id 5FfL-0NicV7e; Thu, 13 Mar 2014 00:39:42 +0200 (EET)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 907285BC005;
        Thu, 13 Mar 2014 00:39:44 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Huacai Chen <chenhc@lemote.com>, Andreas Barth <aba@ayous.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH RESEND 0/2] MIPS: fix loongson2 regression
Date:   Thu, 13 Mar 2014 00:41:05 +0200
Message-Id: <1394664067-17712-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.9.0
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39457
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

MIPS/Loongson2 got (again) broken during 3.14-rc merge window,
and so far we haven't been able to get fixes in through the MIPS
tree as there are still some issues with the tree maintenance.
Please consider applying these two fixes. The issues have been reported
and the fixes have been tested by several users. Thanks.

Earlier discussions:
	http://marc.info/?t=139178356200002&r=1&w=2
	http://marc.info/?t=139178356600001&r=1&w=2
	http://marc.info/?t=139183090100002&r=1&w=2
	http://marc.info/?t=139195288700001&r=1&w=2

Huacai Chen (1):
  MIPS: fpu: fix conflict of register usage

Paul Bolle (1):
  MIPS: Replace CONFIG_MIPS64 and CONFIG_MIPS32_R2

 arch/mips/include/asm/asmmacro.h |  4 ++--
 arch/mips/include/asm/fpu.h      |  2 +-
 arch/mips/kernel/r4k_fpu.S       | 16 ++++++++--------
 3 files changed, 11 insertions(+), 11 deletions(-)

-- 
1.9.0
