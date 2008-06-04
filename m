Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2008 17:00:34 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:16577 "EHLO
	p549F73B8.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S20038175AbYFDQAc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 4 Jun 2008 17:00:32 +0100
Received: from smtp5.pp.htv.fi ([213.243.153.39]:28311 "EHLO smtp5.pp.htv.fi")
	by lappi.linux-mips.net with ESMTP id S1097866AbYFDQAb (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Jun 2008 18:00:31 +0200
Received: from cs181133002.pp.htv.fi (cs181133002.pp.htv.fi [82.181.133.2])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id 5D65A5BC046;
	Wed,  4 Jun 2008 19:00:25 +0300 (EEST)
Date:	Wed, 4 Jun 2008 18:59:51 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Marc St-Jean <bluezzer@gmail.com>
Cc:	linux-mips@linux-mips.org, Brian_Oostenbrink@pmc-sierra.com
Subject: Status of PMC MSP71xx support?
Message-ID: <20080604155951.GC4189@cs181133002.pp.htv.fi>
References: <310540780805210817q177554acof9c5a60129a6a824@mail.gmail.com> <310540780805210834v745502e9i308cbebfe0a0167e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <310540780805210834v745502e9i308cbebfe0a0167e@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

On Wed, May 21, 2008 at 09:34:35AM -0600, Marc St-Jean wrote:

> Hi Adrian,

Hi Marc,

> It did compile with all patches, but at the time I moved on from PMC,
> several drivers patches needed more work and had not yet been accepted
> in the upstream kernel tree.
> 
> The contact at PMC that took over the work was Brian Oostenbrink, I'm
> forwarding this so he can answer you question.

thanks for this information.

Brian, are you or someone else working on getting all required stuff for 
making it usable into the kernel in the forseeable future?

In the current state what is shipped in the kernel tree is useless and 
a good candidate for removal.

> Marc

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
