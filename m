Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Jan 2015 16:12:41 +0100 (CET)
Received: from mga02.intel.com ([134.134.136.20]:62244 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010483AbbAVPMj4Vq0Z convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Jan 2015 16:12:39 +0100
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP; 22 Jan 2015 07:12:17 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.09,449,1418112000"; 
   d="scan'208";a="516059283"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga003.jf.intel.com with ESMTP; 22 Jan 2015 07:05:31 -0800
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Thu, 22 Jan 2015 07:12:16 -0800
Received: from fmsmsx106.amr.corp.intel.com (10.18.124.204) by
 ORSMSX157.amr.corp.intel.com (10.22.240.23) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Thu, 22 Jan 2015 07:12:16 -0800
Received: from fmsmsx114.amr.corp.intel.com ([169.254.6.89]) by
 FMSMSX106.amr.corp.intel.com ([169.254.5.229]) with mapi id 14.03.0195.001;
 Thu, 22 Jan 2015 07:12:15 -0800
From:   "Wilcox, Matthew R" <matthew.r.wilcox@intel.com>
To:     "Wu, Fengguang" <fengguang.wu@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "kbuild-all@01.org" <kbuild-all@01.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [next:master 4658/4676] undefined reference to `copy_user_page'
Thread-Topic: [next:master 4658/4676] undefined reference to `copy_user_page'
Thread-Index: AQHQNgYAlOM6wp/jaEmyg6vD1cmmCpzMPalg
Date:   Thu, 22 Jan 2015 15:12:15 +0000
Message-ID: <100D68C7BA14664A8938383216E40DE040853FB4@FMSMSX114.amr.corp.intel.com>
References: <201501221315.sbz4rdsB%fengguang.wu@intel.com>
In-Reply-To: <201501221315.sbz4rdsB%fengguang.wu@intel.com>
Accept-Language: en-CA, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.1.200.107]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <matthew.r.wilcox@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthew.r.wilcox@intel.com
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

Looks like mips *declares* copy_user_page(), but never *defines* an implementation.

It's documented in Documentation/cachetlb.txt, but it's not (currently) called if the architecture defines its own copy_user_highpage(), so some bitrot has occurred.  ARM is currently fixing this, and MIPS will need to do the same.

(We can't use copy_user_highpage() in DAX because we don't necessarily have a struct page for 'from'.)

-----Original Message-----
From: Wu, Fengguang 
Sent: Wednesday, January 21, 2015 9:40 PM
To: Andrew Morton
Cc: kbuild-all@01.org; Linux Memory Management List; Wilcox, Matthew R
Subject: [next:master 4658/4676] undefined reference to `copy_user_page'

Hi Andrew,

It's probably a bug fix that unveils the link errors.

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   e1e12812e428bcaf19e23f83e09f602d161b8005
commit: c429f45c501ac95383be9e37467d4e6ca08782c1 [4658/4676] daxext2-replace-the-xip-page-fault-handler-with-the-dax-page-fault-handler-fix-3
config: mips-allmodconfig (attached as .config)
reproduce:
  wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
  chmod +x ~/bin/make.cross
  git checkout c429f45c501ac95383be9e37467d4e6ca08782c1
  # save the attached .config to linux build tree
  make.cross ARCH=mips 

All error/warnings:

   fs/built-in.o: In function `dax_fault':
>> (.text+0x5dc6c): undefined reference to `copy_user_page'

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
