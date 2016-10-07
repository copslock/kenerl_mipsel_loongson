Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2016 17:19:17 +0200 (CEST)
Received: from mailapp02.imgtec.com ([217.156.133.132]:30498 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992226AbcJGPTKxCikZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Oct 2016 17:19:10 +0200
Received: from HHMAIL03.hh.imgtec.org (unknown [10.44.0.21])
        by Forcepoint Email with ESMTPS id D1DDCB7D2CE06;
        Fri,  7 Oct 2016 16:18:59 +0100 (IST)
Received: from HHMAIL01.hh.imgtec.org (10.100.10.19) by HHMAIL03.hh.imgtec.org
 (10.44.0.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 7 Oct 2016
 16:19:03 +0100
Received: from [10.20.78.81] (10.20.78.81) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Fri, 7 Oct 2016
 16:19:02 +0100
Date:   Fri, 7 Oct 2016 16:18:54 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Fix -mabi=64 build of vdso.lds
In-Reply-To: <20161007083858.GK19354@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1610071615090.31859@tp.orcam.me.uk>
References: <a226de28606d340f3e4cf0d6f6f4b4d12e766a69.1475791723.git-series.james.hogan@imgtec.com> <alpine.DEB.2.00.1610062349100.31859@tp.orcam.me.uk> <20161007083858.GK19354@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.81]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55368
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

On Fri, 7 Oct 2016, James Hogan wrote:

> >  Also I've noticed $(aflags-vdso) duplicate `-I' and `-E' options already 
> > included with $(ccflags-vdso); I wonder if the duplicates should simply be 
> > removed or whether $(cflags-vdso) ought to filter from $(KBUILD_CFLAGS) 
> > and $(aflags-vdso) -- from $(KBUILD_AFLAGS) instead (or $(ccflags-vdso) 
> > should just take the options from $(KBUILD_CPPFLAGS)).  Also why `-E' is 
> > supposed to take an argument?  Can you please have a look at it?
> 
> I think -E is to catch -EL / -EB.

 Ahh, forgot about the existence of these!

> Removing the duplication is easily
> fixed (I'll post a patch soon). As for whether it should filter from the
> other KBUILD_ flags, I'm inclined to avoid changing it unless we can be
> sure it will be more robust as a result.

 I've only been trying to figure out what Alex might have intended here.  
Obviously given that otherwise the current setup seems to work I tend to 
agree with you in that a simple removal of the duplication is the safest 
path of the least resistance fix.

  Maciej
