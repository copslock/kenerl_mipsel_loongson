Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Mar 2013 17:14:35 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:1785 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827564Ab3CEQOcmCbAl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Mar 2013 17:14:32 +0100
Received: from [10.9.208.53] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 05 Mar 2013 08:08:15 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS06.corp.ad.broadcom.com (10.9.208.53) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 5 Mar 2013 08:14:15 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 5 Mar 2013 08:14:15 -0800
Received: from lc-blr-152.ban.broadcom.com (lc-blr-152.ban.broadcom.com
 [10.132.129.187]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 AD1ED40FE4; Tue, 5 Mar 2013 08:14:14 -0800 (PST)
Received: by lc-blr-152.ban.broadcom.com (Postfix, from userid 28730) id
 94C412056B9; Tue, 5 Mar 2013 21:44:13 +0530 (IST)
Date:   Tue, 5 Mar 2013 21:44:13 +0530
From:   "Ganesan Ramalignam" <ganesanr@broadcom.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
cc:     "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Staging: Netlogic XLR/XLS GMAC driver
Message-ID: <20130305161411.GC29102@ganesanr.netlogicmircro.com>
References: <1362464958-8722-1-git-send-email-ganesanr@broadcom.com>
 <20130305065851.GA30028@kroah.com>
 <20130305141353.GB29102@ganesanr.netlogicmircro.com>
 <20130305141929.GA4434@kroah.com>
MIME-Version: 1.0
In-Reply-To: <20130305141929.GA4434@kroah.com>
User-Agent: Mutt/1.4.2.2i
X-WSS-ID: 7D28C7E53P47005573-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ganesanr@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Mar 05, 2013 at 10:19:29PM +0800, Greg Kroah-Hartman wrote:
> On Tue, Mar 05, 2013 at 07:43:54PM +0530, Ganesan Ramalignam wrote:
> > On Tue, Mar 05, 2013 at 02:58:51PM +0800, Greg Kroah-Hartman wrote:
> > > On Tue, Mar 05, 2013 at 11:59:18AM +0530, ganesanr@broadcom.com wrote:
> > > >  This patch has to be merged via staging tree.
> > > > 
> > > >  This driver has been submitted to netdev tree and reviewed, the comments 
> > > >  are list in TODO list, will be addressed in next cycle of submission, till
> > > >  that time I wanted this driver to be in staging tree.
> > > > 
> > > >  This driver shall be sent to netdev@vger.kernel.org and David Miller <davem@davemloft.net>
> > > >  for further review.
> > > 
> > > When is that going to happen?
> > > 
> > 
> > In two months.
> 
> Why then?  What is so magic about 2 months?  In two months, this driver
> is not going to be in a released version of the kernel yet.
> 

Hi Greg,

Sorry, I think my previous mail did not give more detail, let me
clarify now.

The plan is to make the changes as per the comments received so far and
submit it again for review. There may be more changes and development when
this driver reviewed again, this process might take time of 2 months or even
more. Also this driver is useful to people with XLR/XLS board right now,
so I would like to move this driver to staging, once it reaches the standard
will be moved to netdev tree.

Please let me know if anything wrong in this approach.

> > > > --- /dev/null
> > > > +++ b/drivers/staging/netlogic/Kconfig
> > > > @@ -0,0 +1,7 @@
> > > > +config NETLOGIC_XLR_NET
> > > > +	tristate "Netlogic XLR/XLS network device"
> > > > +	depends on CPU_XLR
> > > 
> > > Why will this not build on any other platform?  It should, right?
> > > 
> > >
> > 
> > This driver is for XLR processor ethernet, which is depend on FMN
> > for any communication between packet processing agents, so this driver
> > depend on XLR platform.
> 
> What is "FMN"?
> 

This driver is for the network accelerator integrated into the
Netlogic XLR/XLS processor family. It uses the Fast Message
Network(FMN) present only on the Netlogic XLR/XLS SoCs, FMN is 
used for sending descriptors between CPUs and high speed interfaces
on XLR/XLS SoC (the code for this is in arch/mips/netlogic/xlr/fmn*),
so I do not see it being used on other platforms.

> thanks,
> 
> greg k-h
> 
