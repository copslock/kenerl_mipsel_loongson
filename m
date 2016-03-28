Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2016 17:10:32 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:39317 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014253AbcC1PKbQ0Tz9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 Mar 2016 17:10:31 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id u2SFAGqX012075
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 28 Mar 2016 08:10:17 -0700 (PDT)
Received: from yow-pgortmak-d1 (128.224.56.57) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.40) with Microsoft SMTP Server id 14.3.248.2; Mon, 28 Mar 2016
 08:10:15 -0700
Received: by yow-pgortmak-d1 (Postfix, from userid 1000)        id CD61E2800AB; Mon,
 28 Mar 2016 11:10:14 -0400 (EDT)
Date:   Mon, 28 Mar 2016 11:10:14 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     James Bottomley <jejb@linux.vnet.ibm.com>
CC:     <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        <linux-m68k@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/2] scsi: remove orphaned modular code from non-modular
 drivers
Message-ID: <20160328151014.GR16831@windriver.com>
References: <1459098025-26269-1-git-send-email-paul.gortmaker@windriver.com>
 <1459143107.13004.21.camel@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1459143107.13004.21.camel@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52712
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

[Re: [PATCH 0/2] scsi: remove orphaned modular code from non-modular drivers] On 27/03/2016 (Sun 22:31) James Bottomley wrote:

> On Sun, 2016-03-27 at 13:00 -0400, Paul Gortmaker wrote:
> > In the ongoing audit/cleanup of non-modular code needlessly using 
> > modular infrastructure, the SCSI subsystem fortunately only contains 
> > two instances that I detected.  Both are for legacy drivers that 
> > predate the git epoch, so cleary there is no demand for converting 
> > these drivers to be tristate.
> > 
> > For anyone new to the underlying goal of this cleanup, we are trying 
> > to not use module support for code that isn't buildable as a module
> > since:
> > 
> >  (1) it is easy to accidentally write unused module_exit and remove
> > code
> >  (2) it can be misleading when reading the source, thinking it can be
> >      modular when the Makefile and/or Kconfig prohibit it
> >  (3) it requires the include of the module.h header file which in
> > turn
> >      includes nearly everything else, thus adding to CPP overhead.
> >  (4) it gets copied/replicated into other code and spreads like
> > weeds.
> 
> I don't really buy any of these as being credible issues for the
> ancient drivers, so there doesn't appear to be an real benefit to this
> conversion; however, besides the danger of touching old stuff, there
> are some down sides:

Thanks James for your review and always interesting/alternative
viewpoints.  You seem pretty clear in your conviction here, so I won't
bother making counter points ; best we just agree to disagree, and I
won't bother you with these patches again.

Paul.
--

> 
> > -MODULE_DESCRIPTION("Sun3x ESP SCSI driver");
> > -MODULE_AUTHOR("Thomas Bogendoerfer (tsbogend@alpha.franken.de)");
> > -MODULE_LICENSE("GPL");
> > -MODULE_VERSION(DRV_VERSION);
> 
> These tags are usefully greppable for drivers, regardless of whether
> they generate actual kernel side information.
> 
> > We explicitly disallow a driver unbind, since that doesn't have a
> > sensible use case anyway, and it allows us to drop the ".remove"
> > code for non-modular drivers.
> 
> That's bogus.  I use bind and unbind a lot for testing built in drivers
> but the usual user use case is for resetting the devices.
> 
> > Build tested for mips (jazz) and m68k (sun3x) on 4.6-rc1 to ensure no
> > silly typos crept in.
> 
> For trivial changes, build testing is not really sufficient: a
> significant fraction of them break something that isn't spotted by the
> reviewers.  For the older drivers, this isn't discovered for months to
> years and then someone has to go digging back through all the so called
> trivial changes to find which one it was.
> 
> James
> 
