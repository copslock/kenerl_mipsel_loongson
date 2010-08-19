Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2010 01:06:28 +0200 (CEST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:61084 "EHLO
        sj-iport-6.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1490979Ab0HSXGU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Aug 2010 01:06:20 +0200
Authentication-Results: sj-iport-6.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-AV: E=Sophos;i="4.56,235,1280707200"; 
   d="scan'208";a="576108038"
Received: from sj-core-4.cisco.com ([171.68.223.138])
  by sj-iport-6.cisco.com with ESMTP; 19 Aug 2010 23:06:13 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-4.cisco.com (8.13.8/8.14.3) with ESMTP id o7JN6DIP029676;
        Thu, 19 Aug 2010 23:06:13 GMT
Date:   Thu, 19 Aug 2010 16:06:14 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     naveen yadav <yad.naveen@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        sshtylyov@mvista.com, Michael Sundius <msundius@cisco.com>
Subject: Re: sparsemem support on MIPS
Message-ID: <20100819230613.GA10992@dvomlehn-lnx2.corp.sa.net>
References: <AANLkTinURQyZgp7bzogjYGzLc5-CyDRGyGo9Hz=pUFFF@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTinURQyZgp7bzogjYGzLc5-CyDRGyGo9Hz=pUFFF@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 19, 2010 at 09:04:21PM +0530, naveen yadav wrote:
> 
>  Dear all,
> 
> I build MIPS 32 with sparsemem support to take care of holes in
> physical memory, this conserve memory but put overhead to speed
> because of pointer redirection in pfn_to_page().
> 
> To prevent this conversion I tried to use
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE on MIPS 32 but kernel build fails
> becauase most of the supported functions related to vmemmap are
> supported for 64 bit architectures only.
> 
> I wish to compare memory and speed result with / without
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE in MIPS 32. I need your comment in it
> ?

We use sparse memory and submitted a patch some while ago to add support,
but it died for lack of interest. The patch was relative to a kernel
from several released ago; I don't know whether it would apply to
the tip. I can see if I track it down.
-- 
David VL
