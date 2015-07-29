Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jul 2015 18:19:24 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:58829 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011696AbbG2QTWh5D7q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Jul 2015 18:19:22 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.1/8.15.1) with ESMTPS id t6TGJDX8020942
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 29 Jul 2015 09:19:13 -0700 (PDT)
Received: from yow-pgortmak-d1 (128.224.56.57) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.235.1; Wed, 29 Jul 2015
 09:18:55 -0700
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id D6D2CE1D18B; Wed,
 29 Jul 2015 12:19:12 -0400 (EDT)
Date:   Wed, 29 Jul 2015 12:19:12 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <dh.herrmann@googlemail.com>
CC:     <gregkh@linuxfoundation.org>, <daniel@zonque.org>,
        <tixxdz@opendz.org>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-next@vger.kernel.org>
Subject: samples/kdbus/kdbus-workers.c and cross compiling MIPS
Message-ID: <20150729161912.GF18685@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

Hi David,

Does it make sense to build this sample when cross compiling?

The reason I ask is that it has been breaking the linux-next build of
allmodconfig for a while now, with:

  HOSTCC  samples/kdbus/kdbus-workers
samples/kdbus/kdbus-workers.c: In function ‘prime_new’:
samples/kdbus/kdbus-workers.c:934:18: error: ‘__NR_memfd_create’ undeclared (first use in this function)
  p->fd = syscall(__NR_memfd_create, "prime-area", MFD_CLOEXEC);
                  ^
samples/kdbus/kdbus-workers.c:934:18: note: each undeclared identifier is reported only once for each function it appears in
scripts/Makefile.host:91: recipe for target 'samples/kdbus/kdbus-workers' failed
make[2]: *** [samples/kdbus/kdbus-workers] Error 1

http://kisskb.ellerman.id.au/kisskb/buildresult/12473453/

We recently made some changes to skip other sample/test programs when
cross compiling in mainline 65f6f092a6987 and f59514b6a8c5ca6dd and
6a407a81a9abcf.  Maybe it makes sense to do the same here?

Paul.
