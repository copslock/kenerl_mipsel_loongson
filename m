Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2010 01:20:10 +0200 (CEST)
Received: from mms2.broadcom.com ([216.31.210.18]:2691 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491018Ab0HSXUG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 20 Aug 2010 01:20:06 +0200
Received: from [10.9.200.133] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Thu, 19 Aug 2010 16:19:47 -0700
X-Server-Uuid: D3C04415-6FA8-4F2C-93C1-920E106A2031
Received: from mail-irva-12.broadcom.com (10.11.16.101) by
 IRVEXCHHUB02.corp.ad.broadcom.com (10.9.200.133) with Microsoft SMTP
 Server id 8.2.247.2; Thu, 19 Aug 2010 16:21:05 -0700
Received: from [10.28.6.13] (lab-mhtb-013.and.broadcom.com [10.28.6.13])
 by mail-irva-12.broadcom.com (Postfix) with ESMTP id 98BE169CA8; Thu,
 19 Aug 2010 16:19:46 -0700 (PDT)
Subject: Re: sparsemem support on MIPS
From:   "Jon Fraser" <jfraser@broadcom.com>
Reply-to: jfraser@broadcom.com
To:     "David VomLehn" <dvomlehn@cisco.com>
cc:     jfraser@broadcom.com, "naveen yadav" <yad.naveen@gmail.com>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "sshtylyov@mvista.com" <sshtylyov@mvista.com>,
        "Michael Sundius" <msundius@cisco.com>
In-Reply-To: <20100819230613.GA10992@dvomlehn-lnx2.corp.sa.net>
References: <AANLkTinURQyZgp7bzogjYGzLc5-CyDRGyGo9Hz=pUFFF@mail.gmail.com>
 <20100819230613.GA10992@dvomlehn-lnx2.corp.sa.net>
Date:   Thu, 19 Aug 2010 19:19:45 -0400
Message-ID: <1282259985.10583.79.camel@chaos.and.broadcom.com>
MIME-Version: 1.0
X-Mailer: Evolution 2.12.3 (2.12.3-5.fc8)
X-WSS-ID: 607363993DO9311664-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jfraser@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jfraser@broadcom.com
Precedence: bulk
X-list: linux-mips


On Thu, 2010-08-19 at 16:06 -0700, David VomLehn wrote:
> On Thu, Aug 19, 2010 at 09:04:21PM +0530, naveen yadav wrote:
> > 
> >  Dear all,
> > 
> > I build MIPS 32 with sparsemem support to take care of holes in
> > physical memory, this conserve memory but put overhead to speed
> > because of pointer redirection in pfn_to_page().
> > 
> > To prevent this conversion I tried to use
> > CONFIG_SPARSEMEM_VMEMMAP_ENABLE on MIPS 32 but kernel build fails
> > becauase most of the supported functions related to vmemmap are
> > supported for 64 bit architectures only.
> > 
> > I wish to compare memory and speed result with / without
> > CONFIG_SPARSEMEM_VMEMMAP_ENABLE in MIPS 32. I need your comment in it
> > ?
> 
> We use sparse memory and submitted a patch some while ago to add support,
> but it died for lack of interest. The patch was relative to a kernel
> from several released ago; I don't know whether it would apply to
> the tip. I can see if I track it down.


I keep thinking we should have a git tree for highmem 'experimental'
changes.  Some of us are shipping highmem, discontiguous memory systems
in high volume.

--jfraser
