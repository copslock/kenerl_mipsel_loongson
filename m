Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 Mar 2013 07:25:51 +0100 (CET)
Received: from mms3.broadcom.com ([216.31.210.19]:4690 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817033Ab3CEGZtaDX12 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 5 Mar 2013 07:25:49 +0100
Received: from [10.9.208.55] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 04 Mar 2013 22:19:35 -0800
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 4 Mar 2013 22:25:34 -0800
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP3.corp.ad.broadcom.com (10.9.207.53) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 4 Mar 2013 22:25:34 -0800
Received: from lc-blr-152.ban.broadcom.com (lc-blr-152.ban.broadcom.com
 [10.132.129.187]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 15D3240FE4; Mon, 4 Mar 2013 22:25:34 -0800 (PST)
Received: by lc-blr-152.ban.broadcom.com (Postfix, from userid 28730) id
 D2D1F2056B9; Tue, 5 Mar 2013 11:55:32 +0530 (IST)
Date:   Tue, 5 Mar 2013 11:55:32 +0530
From:   "Ganesan Ramalignam" <ganesanr@broadcom.com>
To:     "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
cc:     "Ralf Baechle" <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] Staging: Netlogic XLR/XLS GMAC driver
Message-ID: <20130305062531.GA29102@ganesanr.netlogicmircro.com>
References: <1362249374-25556-1-git-send-email-ganesanr@broadcom.com>
 <20130302184726.GA2411@kroah.com>
MIME-Version: 1.0
In-Reply-To: <20130302184726.GA2411@kroah.com>
User-Agent: Mutt/1.4.2.2i
X-WSS-ID: 7D2B51FD3P46831117-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
X-archive-position: 35848
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

On Sat, Mar 02, 2013 at 10:47:26AM -0800, Greg Kroah-Hartman wrote:
> On Sun, Mar 03, 2013 at 12:06:13AM +0530, ganesanr@broadcom.com wrote:
> > From: Ganesan Ramalingam <ganesanr@broadcom.com>
> > 
> > Add support for the Network Accelerator Engine on Netlogic XLR/XLS
> > MIPS SoCs. The XLR/XLS NAE blocks can be configured as one 10G
> > interface or four 1G interfaces. This driver supports blocks
> > with 1G ports.
> > 
> > Signed-off-by: Ganesan Ramalingam <ganesanr@broadcom.com>
> > ---
> >  This patch has to be merged via staging tree.
> 
> Why is this a staging driver?
> 
> I need a TODO file listing the remaining things left to fix up in this
> driver to get it merged to the "correct" location in the kernel, along
> with some email addresses and names of who to send the patches to for
> review, before I can accept this.
> 
> thanks,
> 
> greg k-h
> 

This driver has been submitted to netdev tree and reviewed, there are
comments and those are listed in TODO list. I will address those TODO
list in next cycle, till that time I want this driver to be in staging tree.

Will add TODO list and merge the "[PATCH 2/2] MIPS: Netlogic: Platform 
changes for XLR/XLS gmac" patch with driver patch and submit as a
stand-alone driver.

Thanks
Ganesan
