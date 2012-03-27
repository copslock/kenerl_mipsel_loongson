Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 23:53:20 +0200 (CEST)
Received: from mga14.intel.com ([143.182.124.37]:22832 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903668Ab2C0VxQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 23:53:16 +0200
Received: from azsmga001.ch.intel.com ([10.2.17.19])
  by azsmga102.ch.intel.com with ESMTP; 27 Mar 2012 14:53:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.71,315,1320652800"; 
   d="scan'208";a="124006268"
Received: from orsmsx605.amr.corp.intel.com ([10.22.226.10])
  by azsmga001.ch.intel.com with ESMTP; 27 Mar 2012 14:53:02 -0700
Received: from orsmsx106.amr.corp.intel.com (10.22.225.133) by
 orsmsx605.amr.corp.intel.com (10.22.226.10) with Microsoft SMTP Server (TLS)
 id 8.2.255.0; Tue, 27 Mar 2012 14:53:02 -0700
Received: from orsmsx104.amr.corp.intel.com ([169.254.3.46]) by
 ORSMSX106.amr.corp.intel.com ([169.254.5.128]) with mapi id 14.01.0355.002;
 Tue, 27 Mar 2012 14:53:02 -0700
From:   "Luck, Tony" <tony.luck@intel.com>
To:     "Luck, Tony" <tony.luck@intel.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        "microblaze-uclinux@itee.uq.edu.au" 
        <microblaze-uclinux@itee.uq.edu.au>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
        "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "discuss@x86-64.org" <discuss@x86-64.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Subject: RE: [PATCH 05/14] IA64: adapt for dma_map_ops changes
Thread-Topic: [PATCH 05/14] IA64: adapt for dma_map_ops changes
Thread-Index: AQHNDF9gqT6ids3dR7al+CAdekfr9pZ+rs0g
Date:   Tue, 27 Mar 2012 21:53:01 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F15B724D8@ORSMSX104.amr.corp.intel.com>
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
        <1324643253-3024-6-git-send-email-m.szyprowski@samsung.com>
 <CA+8MBbLAafFbVwviFmkjD0DNz5RsCbB_TNLL67wEi2k-hyXkXA@mail.gmail.com>
In-Reply-To: <CA+8MBbLAafFbVwviFmkjD0DNz5RsCbB_TNLL67wEi2k-hyXkXA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 32795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tony.luck@intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

> until part 5 (when ia64 sees the changes to match).  You could either merge part
> 5 into part 2 (to make a combined x86+ia64 piece

Doh! I see that you already did this in the re-post you did a few hours
ago (which my mail client had filed away in my linux-arch folder).

-Tony
 
