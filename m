Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 23:16:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23396 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029141AbcEKVQMjJ5oG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2016 23:16:12 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 194E0808CE521;
        Wed, 11 May 2016 22:16:02 +0100 (IST)
Received: from [10.20.78.171] (10.20.78.171) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Wed, 11 May 2016
 22:16:05 +0100
Date:   Wed, 11 May 2016 22:15:51 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        <linux-mips@linux-mips.org>, James Hogan <james.hogan@imgtec.com>, Adam
 Buchbinder <adam.buchbinder@gmail.com>, Joshua Kinard <kumba@gentoo.org>,
        Huacai Chen <chenhc@lemote.com>, "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>, Aneesh Kumar K.V
        <aneesh.kumar@linux.vnet.ibm.com>, <linux-kernel@vger.kernel.org>, "Peter
 Zijlstra (Intel)" <peterz@infradead.org>, David Hildenbrand
        <dahi@linux.vnet.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, David
 Daney <david.daney@cavium.com>, Jonas Gorski <jogo@openwrt.org>, Markos
 Chandras <markos.chandras@imgtec.com>, Ingo Molnar <mingo@kernel.org>, Alex
 Smith <alex.smith@imgtec.com>, "Kirill A. Shutemov"
        <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 00/12] TLB/XPA fixes & cleanups
In-Reply-To: <57338536.9040209@gmail.com>
Message-ID: <alpine.DEB.2.00.1605112159010.6794@tp.orcam.me.uk>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com> <20160510124426.GG16402@linux-mips.org> <57321EC4.5030301@gmail.com> <20160511100335.GA14397@linux-mips.org> <57338536.9040209@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.171]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53385
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

On Wed, 11 May 2016, Florian Fainelli wrote:

> >>> Applied - but "MIPS: Separate XPA CPU feature into LPA and MVH" causes
> >>> a massive conflict with Florian's RIXI patches
> >>>
> >>>   [3/6] MIPS: Allow RIXI to be used on non-R2 or R6 core
> >>>   [4/6] MIPS: Move RIXI exception enabling after vendor-specific cpu_probe
> >>>   [5/6] MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI
> >>>
> >>> I figured unapplying those three, applying Paul's series then re-applying
> >>> Florian's patch on top of the whole series will be the easier path as in
> >>> leaving me with the smaller rejects to manage.
> >>
> >> Did you already push that to mips-for-linux-next? I can give it a quick
> >> spin once you do so.
> > 
> > I just pushed a tree with everything applied.  HEAD of tree is
> > 22702a86997c5aed2e479bfe0b24d10d66b09604 dated May 11 11:58:06; a version
> > from earlier today was broken.
> 
> Boot tested on BMIPS5000 (BCM7425):
> 
> Tested-by: Florian Fainelli <f.fainelli@gmail.com>

 NB it's not that the RIXI feature first appeared only with the MIPS32r2 
ISA.  It was introduced with the SmartMIPS ASE as a part of the original 
MIPS32r1 ISA.  And similarly there's no separate RIXI config register bit 
provided for MIPS32r1 SmartMIPS processors, the presence of the feature is 
implied solely by the Config3.SM (SmartMIPS) bit, so your implementation 
looks like the right direction to me.  Thanks for your contribution!

  Maciej
