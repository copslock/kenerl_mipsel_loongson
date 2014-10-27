Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Oct 2014 02:46:01 +0100 (CET)
Received: from mga03.intel.com ([134.134.136.65]:62454 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010898AbaJ0Bp7yTs12 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Oct 2014 02:45:59 +0100
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP; 26 Oct 2014 18:44:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.04,792,1406617200"; 
   d="scan'208";a="625947589"
Received: from pgsmsx103.gar.corp.intel.com ([10.221.44.82])
  by orsmga002.jf.intel.com with ESMTP; 26 Oct 2014 18:45:49 -0700
Received: from kmsmsx151.gar.corp.intel.com (172.21.73.86) by
 PGSMSX103.gar.corp.intel.com (10.221.44.82) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Mon, 27 Oct 2014 09:43:02 +0800
Received: from shsmsx152.ccr.corp.intel.com (10.239.6.52) by
 KMSMSX151.gar.corp.intel.com (172.21.73.86) with Microsoft SMTP Server (TLS)
 id 14.3.195.1; Mon, 27 Oct 2014 09:43:01 +0800
Received: from shsmsx102.ccr.corp.intel.com ([169.254.2.156]) by
 SHSMSX152.ccr.corp.intel.com ([169.254.6.13]) with mapi id 14.03.0195.001;
 Mon, 27 Oct 2014 09:43:00 +0800
From:   "Ren, Qiaowei" <qiaowei.ren@intel.com>
To:     Thomas Gleixner <tglx@linutronix.de>
CC:     "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: [PATCH v9 09/12] x86, mpx: decode MPX instruction to get bound
 violation information
Thread-Topic: [PATCH v9 09/12] x86, mpx: decode MPX instruction to get bound
 violation information
Thread-Index: AQHP5dg7yyhiQxbkmEGH5PJVxeeZs5w+vGAAgASFDTA=
Date:   Mon, 27 Oct 2014 01:43:00 +0000
Message-ID: <9E0BE1322F2F2246BD820DA9FC397ADE0180ED16@shsmsx102.ccr.corp.intel.com>
References: <1413088915-13428-1-git-send-email-qiaowei.ren@intel.com>
 <1413088915-13428-10-git-send-email-qiaowei.ren@intel.com>
 <alpine.DEB.2.11.1410241408360.5308@nanos>
In-Reply-To: <alpine.DEB.2.11.1410241408360.5308@nanos>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <qiaowei.ren@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qiaowei.ren@intel.com
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



On 2014-10-24, Thomas Gleixner wrote:
> On Sun, 12 Oct 2014, Qiaowei Ren wrote:
> 
>> This patch sets bound violation fields of siginfo struct in #BR
>> exception handler by decoding the user instruction and constructing
>> the faulting pointer.
>> 
>> This patch does't use the generic decoder, and implements a limited
>> special-purpose decoder to decode MPX instructions, simply because
>> the generic decoder is very heavyweight not just in terms of
>> performance but in terms of interface -- because it has to.
> 
> My question still stands why using the existing decoder is an issue.
> Performance is a complete non issue in case of a bounds violation and
> the interface argument is just silly, really.
> 

As hpa said, we only need to decode several mpx instructions including BNDCL/BNDCU, and general decoder looks like a little heavy. Peter, what do you think about it?

Thanks,
Qiaowei
