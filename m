Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Mar 2013 15:14:15 +0100 (CET)
Received: from mms2.broadcom.com ([216.31.210.18]:1942 "EHLO mms2.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6820301Ab3CEOON62W3D (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Mar 2013 15:14:13 +0100
Received: from [10.9.208.57] by mms2.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Tue, 05 Mar 2013 06:10:25 -0800
X-Server-Uuid: 4500596E-606A-40F9-852D-14843D8201B2
Received: from IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Tue, 5 Mar 2013 06:13:55 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP2.corp.ad.broadcom.com (10.9.207.52) with Microsoft SMTP
 Server id 14.1.438.0; Tue, 5 Mar 2013 06:13:55 -0800
Received: from lc-blr-152.ban.broadcom.com (lc-blr-152.ban.broadcom.com
 [10.132.129.187]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 815B940FE3; Tue, 5 Mar 2013 06:13:55 -0800 (PST)
Received: by lc-blr-152.ban.broadcom.com (Postfix, from userid 28730) id
 46A552056B9; Tue, 5 Mar 2013 19:43:54 +0530 (IST)
Date:   Tue, 5 Mar 2013 19:43:54 +0530
From:   "Ganesan Ramalignam" <ganesanr@broadcom.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
cc:     "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Staging: Netlogic XLR/XLS GMAC driver
Message-ID: <20130305141353.GB29102@ganesanr.netlogicmircro.com>
References: <1362464958-8722-1-git-send-email-ganesanr@broadcom.com>
 <20130305065851.GA30028@kroah.com>
MIME-Version: 1.0
In-Reply-To: <20130305065851.GA30028@kroah.com>
User-Agent: Mutt/1.4.2.2i
X-WSS-ID: 7D2B235B3S47401327-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35855
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

On Tue, Mar 05, 2013 at 02:58:51PM +0800, Greg Kroah-Hartman wrote:
> On Tue, Mar 05, 2013 at 11:59:18AM +0530, ganesanr@broadcom.com wrote:
> >  This patch has to be merged via staging tree.
> > 
> >  This driver has been submitted to netdev tree and reviewed, the comments 
> >  are list in TODO list, will be addressed in next cycle of submission, till
> >  that time I wanted this driver to be in staging tree.
> > 
> >  This driver shall be sent to netdev@vger.kernel.org and David Miller <davem@davemloft.net>
> >  for further review.
> 
> When is that going to happen?
> 

In two months.

> > --- /dev/null
> > +++ b/drivers/staging/netlogic/Kconfig
> > @@ -0,0 +1,7 @@
> > +config NETLOGIC_XLR_NET
> > +	tristate "Netlogic XLR/XLS network device"
> > +	depends on CPU_XLR
> 
> Why will this not build on any other platform?  It should, right?
> 
>

This driver is for XLR processor ethernet, which is depend on FMN
for any communication between packet processing agents, so this driver
depend on XLR platform.

> > --- /dev/null
> > +++ b/drivers/staging/netlogic/TODO
> > @@ -0,0 +1,5 @@
> > +* Implementing 64bit stat counter in software
> > +* All memory allocation should be changed to DMA allocations
> > +* All the netdev should be linked to single pdev as parent
> > +* Changing comments in to linux standred format
> > +
> 
> I need a name and email address for who is responsible for this driver
> and will be handling patches for it.
> 

Will add the emaipl address list and resubmit.

> Please fix this up and resubmit.
> 
> thanks,
> 
> greg k-h
> 
