Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2016 12:03:55 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39896 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27028891AbcEKKDuyNpm5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 May 2016 12:03:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u4BA3iVJ014879;
        Wed, 11 May 2016 12:03:44 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u4BA3Z42014878;
        Wed, 11 May 2016 12:03:35 +0200
Date:   Wed, 11 May 2016 12:03:35 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org,
        James Hogan <james.hogan@imgtec.com>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Joshua Kinard <kumba@gentoo.org>,
        Huacai Chen <chenhc@lemote.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        David Hildenbrand <dahi@linux.vnet.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Daney <david.daney@cavium.com>,
        Jonas Gorski <jogo@openwrt.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Ingo Molnar <mingo@kernel.org>,
        Alex Smith <alex.smith@imgtec.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCH 00/12] TLB/XPA fixes & cleanups
Message-ID: <20160511100335.GA14397@linux-mips.org>
References: <1460716620-13382-1-git-send-email-paul.burton@imgtec.com>
 <20160510124426.GG16402@linux-mips.org>
 <57321EC4.5030301@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57321EC4.5030301@gmail.com>
User-Agent: Mutt/1.6.0 (2016-04-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53358
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, May 10, 2016 at 10:47:48AM -0700, Florian Fainelli wrote:

> > Applied - but "MIPS: Separate XPA CPU feature into LPA and MVH" causes
> > a massive conflict with Florian's RIXI patches
> > 
> >   [3/6] MIPS: Allow RIXI to be used on non-R2 or R6 core
> >   [4/6] MIPS: Move RIXI exception enabling after vendor-specific cpu_probe
> >   [5/6] MIPS: BMIPS: BMIPS4380 and BMIPS5000 support RIXI
> > 
> > I figured unapplying those three, applying Paul's series then re-applying
> > Florian's patch on top of the whole series will be the easier path as in
> > leaving me with the smaller rejects to manage.
> 
> Did you already push that to mips-for-linux-next? I can give it a quick
> spin once you do so.

I just pushed a tree with everything applied.  HEAD of tree is
22702a86997c5aed2e479bfe0b24d10d66b09604 dated May 11 11:58:06; a version
from earlier today was broken.

  Ralf
