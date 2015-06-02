Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 17:37:19 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27007048AbbFBPhRHiZk4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 17:37:17 +0200
Date:   Tue, 2 Jun 2015 16:37:17 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
cc:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: Re: CONFIG_64BIT && CONFIG_MIPS_HUGE_TLB_SUPPORT build broken
In-Reply-To: <556BEAFE.9030400@gentoo.org>
Message-ID: <alpine.LFD.2.11.1506021636140.6751@eddie.linux-mips.org>
References: <556BEAFE.9030400@gentoo.org>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 1 Jun 2015, Joshua Kinard wrote:

> Since this is dealing with R2 stuff, not sure what the best fix is.  Looks like
> this is the problem commit:
> 
> http://git.linux-mips.org/cgit/ralf/linux.git/commit/arch/mips/include/asm/pgtable-bits.h?id=be0c37c985eddc46d0d67543898c086f60460e2e

 Try <http://patchwork.linux-mips.org/patch/9960/>.

  Maciej
