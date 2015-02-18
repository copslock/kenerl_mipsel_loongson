Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Feb 2015 18:36:16 +0100 (CET)
Received: from aserp1040.oracle.com ([141.146.126.69]:17723 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013065AbbBRRgOe2P9K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Feb 2015 18:36:14 +0100
Received: from aserv0022.oracle.com (aserv0022.oracle.com [141.146.126.234])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id t1IHZh01013038
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Wed, 18 Feb 2015 17:35:43 GMT
Received: from userz7022.oracle.com (userz7022.oracle.com [156.151.31.86])
        by aserv0022.oracle.com (8.13.8/8.13.8) with ESMTP id t1IHZgMw017431
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Wed, 18 Feb 2015 17:35:42 GMT
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by userz7022.oracle.com (8.14.5+Sun/8.14.4) with ESMTP id t1IHZfOQ029125;
        Wed, 18 Feb 2015 17:35:41 GMT
Received: from l.oracle.com (/10.137.178.253)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 18 Feb 2015 09:35:40 -0800
Received: by l.oracle.com (Postfix, from userid 1000)
        id 217616A3C8C; Wed, 18 Feb 2015 12:35:39 -0500 (EST)
Date:   Wed, 18 Feb 2015 12:35:39 -0500
From:   Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
To:     "Wang, Xiaoming" <xiaoming.wang@intel.com>
Cc:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "boris.ostrovsky@oracle.com" <boris.ostrovsky@oracle.com>,
        "david.vrabel@citrix.com" <david.vrabel@citrix.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux@horizon.com" <linux@horizon.com>,
        "lauraa@codeaurora.org" <lauraa@codeaurora.org>,
        "heiko.carstens@de.ibm.com" <heiko.carstens@de.ibm.com>,
        "d.kasatkin@samsung.com" <d.kasatkin@samsung.com>,
        "takahiro.akashi@linaro.org" <takahiro.akashi@linaro.org>,
        "chris@chris-wilson.co.uk" <chris@chris-wilson.co.uk>,
        "pebolle@tiscali.nl" <pebolle@tiscali.nl>,
        "Liu, Chuansheng" <chuansheng.liu@intel.com>,
        "Zhang, Dongxing" <dongxing.zhang@intel.com>
Subject: Re: [PATCH v3] modify the IO_TLB_SEGSIZE and IO_TLB_DEFAULT_SIZE
 configurable as flexible requirement about SW-IOMMU.
Message-ID: <20150218173539.GE8152@l.oracle.com>
References: <1424054298-17083-1-git-send-email-xiaoming.wang@intel.com>
 <20150216221322.GA7442@l.oracle.com>
 <FA47D36D6EC9FE4CB463299737C09B9901D00B41@shsmsx102.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FA47D36D6EC9FE4CB463299737C09B9901D00B41@shsmsx102.ccr.corp.intel.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Source-IP: aserv0022.oracle.com [141.146.126.234]
Return-Path: <konrad.wilk@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45853
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

> > >  static int __init
> > > +setup_io_tlb_segsize(char *str)
> > > +{
> > > +	get_option(&str, &io_tlb_segsize);
> > > +	return 0;
> > > +}
> > > +__setup("io_tlb_segsize=", setup_io_tlb_segsize);
> > 
> > This should be folded in swiotlb=XYZ parsing please.
> > 
> I am not very clear about this comment.
> 1,	Do you mean it should use early_param instead of __setup?
> As I known early_param  can't help to assign the parameter that we changed at
> kernel cmdline  because we have the default value here.
> int io_tlb_segsize = 128;
> unsigned long io_tlb_default_size = (64UL<<20);

The code in 'setup_io_tlb_npages' - which is run when 'swiotlb=' parameter
is passed on the command line, can be modified to parse other extra
values. That is what I meant.

As in right now it assumes you want only to change the size of the
IOTLB buffer (64MB default). You can make the code be smarter and
accept two values, say:

  32768,128

Which should make the size by the default of 64MB with an io_tlb_segsize of 128.

Or you can do:

  32768,256

for also an 64MB with a io_tlb_segsize of 256 instead.


This offers users to manipulate these values as well as the initial
arch code which can modify 'io_tlb_nslabs' and 'io_tlb_segsize' during
bootup to their preferred values.

> 2,	Or do you mean use iotlbsegsize instead of io_tlb_segsize?

No. Just fold it all under 'swiotlb' parameter please.
> 
> > Also you will need to update the Documentaiton/kernel-parameters.txt file.

And naturally that will have to be updated.
