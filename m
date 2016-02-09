Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 21:00:28 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:2414 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012187AbcBIUAZ1zLfS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 21:00:25 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 3042A7A20C597;
        Tue,  9 Feb 2016 20:00:15 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Tue, 9 Feb 2016
 20:00:17 +0000
Date:   Tue, 9 Feb 2016 19:44:08 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Daniel Wagner <daniel.wagner@bmw-carit.de>
CC:     kbuild test robot <lkp@intel.com>, <kbuild-all@01.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH v3 3/3] mips: Differentiate between 32 and 64 bit ELF
 header
In-Reply-To: <56B9DDCA.3000700@bmw-carit.de>
Message-ID: <alpine.DEB.2.00.1602091941400.15885@tp.orcam.me.uk>
References: <201602090033.mukhdG4N%fengguang.wu@intel.com> <56B99D55.2020301@bmw-carit.de> <alpine.DEB.2.00.1602091148570.15885@tp.orcam.me.uk> <56B9DDCA.3000700@bmw-carit.de>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51916
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Tue, 9 Feb 2016, Daniel Wagner wrote:

> >  FWIW I think all the MIPS ABI flags stuff also needs to go outside the 
> > conditional, because it's ABI agnostic.  I'll make the right change myself 
> > on top of your fixes.  It'll remove a little bit of code duplication, 
> > which is always welcome.
> 
> Great, thanks for taking care of it.

 My ABI flags change has passed testing and I'm ready to post it, will you 
be respinning your patch soon?

  Maciej
