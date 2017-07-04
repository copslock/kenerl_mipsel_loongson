Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Jul 2017 17:50:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:63184 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993906AbdGDPuRYIIQ7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Jul 2017 17:50:17 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 05E1E3F48FD;
        Tue,  4 Jul 2017 16:50:08 +0100 (IST)
Received: from [10.20.78.88] (10.20.78.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 4 Jul 2017
 16:50:10 +0100
Date:   Tue, 4 Jul 2017 16:50:00 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     James Hogan <james.hogan@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS16e2: Provide feature overrides for non-MIPS16
 systems
In-Reply-To: <20170703203250.GN31455@jhogan-linux.le.imgtec.org>
Message-ID: <alpine.DEB.2.00.1707041636350.3339@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1705180145220.2590@tp.orcam.me.uk> <alpine.DEB.2.00.1705230345530.2590@tp.orcam.me.uk> <20170703203250.GN31455@jhogan-linux.le.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.88]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59018
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

On Mon, 3 Jul 2017, James Hogan wrote:

> > Hardcode the absence of the MIPS16e2 ASE for all the systems that do so 
> > for the MIPS16 ASE already, providing for code to be optimized away.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
> 
> I'm inclined to agree with Florian, that git formatted patches are
> slightly easier to review, perhaps they just subjectively look more
> familiar. Out of interest, do you not use git for retrieving kernel
> source already?

 I do use GIT for managing the sources themselves of course, however I 
keep using `quilt' for patches for two main reasons:

1. It works efficiently for the work flow I've got used to, e.g. how do I 
   hand-edit 16th previous diff with GIT; how do I swap patches; how do I 
   move individual hunks between patches? -- these actions are trivial 
   with `quilt'.

2. I don't use the same system for development as I do for submissions, 
   also to make sure no unwanted bits leak by accident.

Maybe `quilt' can be taught to prepend `diffstat' automagically itself; 
I'll check.

> Thanks for the series.

 Thanks for your review!

  Maciej
