Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Oct 2016 14:27:00 +0200 (CEST)
Received: from mout.web.de ([212.227.15.3]:57334 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992028AbcJXM0xzhxyY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 24 Oct 2016 14:26:53 +0200
Received: from [192.168.1.2] ([77.182.95.108]) by smtp.web.de (mrweb002) with
 ESMTPSA (Nemesis) id 0M2dt7-1cnrJB3OZ3-00sKq9; Mon, 24 Oct 2016 14:26:28
 +0200
To:     linux-mips@linux-mips.org,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
From:   SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH 0/4] MIPS-kernel: Fine-tuning for two function implementations
Message-ID: <3809e713-2f08-db60-92c1-21d735a4f35b@users.sourceforge.net>
Date:   Mon, 24 Oct 2016 14:26:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K0:z3x0a7+zW6BRuYPg4EzppaZdCJXRTJp7GZyCcdoZXOQdlUVAJla
 DAGHhJXGBOzQkGVs3vWxhClRXkqn/c5a8KeQo+5jYw1T90znKa3dZHy13W+N0IebKTvMDj6
 xtoM+1eGZEbVXPJb3p68BrcEYKat47e1/uFQa3BQxSWYQPIZOBpZKHcSDpWRgNwn3T0o9CJ
 FwKki0nLpmZ+Q+J4Q9Wng==
X-UI-Out-Filterresults: notjunk:1;V01:K0:usbyv/Ap7OY=:B40TTISTLCRe+FTOqrMOze
 YeJL3DFj88QroaxuB5Dgw6eTJ/G+E3+owxtP3Gli95TXzAEp/KgzaFTZ3ScHa9+c4etQo79MK
 t/HOLB7ZT4oSIDlU+287lIKEVdLZu28raI6j8jPsT49ROAvTKPt7KZ6AGEjc4A9ZuyKbBRhZV
 86TEaGgUUEEOUMAMNk9cQOV6LBhvyeFAixebYmO07c9rlGpWDmvRURUhC5feohNI7OO1UHSsQ
 CnHm3a0dlkUoCUvSazNkP9rgyHfdGaZPu59j5hl0WPWE1aynvEmt8pMm5RY8SPe5WTu80oOER
 yc94fZvokW2g8u3JjdtNv516pIJDR2UUb8VpDN3XvU1+m0LiuEOVRSSnql8YtXch/typLZdML
 j4/lwvJgtaxl6Py2lz9kVMLj9+kxpoDZQLnOn/cGHJc+FDXgY69MIJWhXLeOixWQTwJoQw8Jl
 feukVTxbV4HkcEBuWqeOqKTidsNQZ6g5moOm7kUcV7LplZcJrG8Bl8UQ9mIFiaGY/koHOpiQF
 P4rnk7R08zNUkVkrV4qMKRUT7nfuskGTe5geQPBDY/AD6qHKwYzg/4fJbv4+5AE6Q6GiMNIEt
 HU4LCqmNMLMiggXylsm2OmBUeAJw/bp1n8t02zx1n/GmkgZLXrXoYeSm3yJrSPAQUVfYX24pq
 8Sb4Pxtm+eWpT5O97HywUBkwpdPM7Fq1Q9LKs2iMkmHggPuzaiF5py51d7X1X3/9KXlEEgHVV
 NZGuUYF8+DxAQ43Bjp2wmwuIk3vs4QxpFlwSO/eLFUvVU4l/5/optTMHtO8jyYxs8uYYKNNNN
 iFeaDLW
Return-Path: <elfring@users.sourceforge.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: elfring@users.sourceforge.net
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

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Mon, 24 Oct 2016 14:05:14 +0200

A few update suggestions were taken into account
from static source code analysis.

Markus Elfring (4):
  r2-to-r6-emul: Use seq_puts() in mipsr2_stats_show()
  proc: Use seq_putc() in show_cpuinfo()
  proc: Replace 28 seq_printf() calls by seq_puts() in show_cpuinfo()
  proc: Combine four seq_printf() calls into one call in show_cpuinfo()

 arch/mips/kernel/mips-r2-to-r6-emul.c |  7 +--
 arch/mips/kernel/proc.c               | 95 ++++++++++++++++++++---------------
 2 files changed, 59 insertions(+), 43 deletions(-)

-- 
2.10.1
