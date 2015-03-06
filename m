Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2015 16:20:16 +0100 (CET)
Received: from aserp1040.oracle.com ([141.146.126.69]:19938 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007216AbbCFPUPTA9tx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2015 16:20:15 +0100
Received: from ucsinet21.oracle.com (ucsinet21.oracle.com [156.151.31.93])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t26FJcZk015165
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 6 Mar 2015 15:19:39 GMT
Received: from aserz7022.oracle.com (aserz7022.oracle.com [141.146.126.231])
        by ucsinet21.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id t26FJX4m029513
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL);
        Fri, 6 Mar 2015 15:19:34 GMT
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserz7022.oracle.com (8.14.4+Sun/8.14.4) with ESMTP id t26FJXRo016088;
        Fri, 6 Mar 2015 15:19:33 GMT
Received: from l.oracle.com (/10.137.178.253)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 06 Mar 2015 07:19:33 -0800
Received: by l.oracle.com (Postfix, from userid 1000)
        id 4263D6A3C91; Fri,  6 Mar 2015 10:19:31 -0500 (EST)
Date:   Fri, 6 Mar 2015 10:19:31 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Wang, Xiaoming" <xiaoming.wang@intel.com>
Cc:     Jan Beulich <JBeulich@suse.com>,
        "Liu@aserp2030.oracle.com" <Liu@aserp2030.oracle.com>,
        "Zhang@aserp2030.oracle.com" <Zhang@aserp2030.oracle.com>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "david.vrabel@citrix.com" <david.vrabel@citrix.com>,
        "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "linux@horizon.com" <linux@horizon.com>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        "Zhang, Dongxing" <dongxing.zhang@intel.com>,
        "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "jkosina@suse.cz" <jkosina@suse.cz>
Subject: Re: [PATCH v5] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Message-ID: <20150306151931.GC4808@l.oracle.com>
References: <1425370269-29658-1-git-send-email-xiaoming.wang@intel.com>
 <20150304194237.GA12884@l.oracle.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D05BBA@shsmsx102.ccr.corp.intel.com>
 <54F8247B02000078000667AF@mail.emea.novell.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D05DF8@shsmsx102.ccr.corp.intel.com>
 <54F8292E02000078000667F9@mail.emea.novell.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D061EB@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA47D36D6EC9FE4CB463299737C09B9901D061EB@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Source-IP: ucsinet21.oracle.com [156.151.31.93]
Return-Path: <konrad.wilk@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46234
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: konrad.wilk@oracle.com
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

. snip..

> Format: { <int>,force,<int>,<int>} is suitable I think.
> And fixing  "force" is follow the code design previously in setup_io_tlb_npages.

It is a bug. It should have been smart enough to deal with the 'force' being
in any order.

If you are willing to make a patch to fix this - either folded into this
patch I am responding to or as a seperate one - that would be most excellent!

However, I can also do it - but my plate is full so it will take me some time
to get to it.
