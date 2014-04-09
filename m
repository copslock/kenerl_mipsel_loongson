Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Apr 2014 15:33:07 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:54511 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822287AbaDINdFHkDsB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Apr 2014 15:33:05 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1WXscg-0001uW-00; Wed, 09 Apr 2014 15:33:02 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 69FF01BB731; Wed,  9 Apr 2014 15:32:29 +0200 (CEST)
Date:   Wed, 9 Apr 2014 15:32:29 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Florian Lohoff <f@zz.de>
Cc:     Fengguang Wu <fengguang.wu@intel.com>,
        Michal Marek <mmarek@suse.cz>, kbuild-all@01.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
Message-ID: <20140409133229.GA22315@alpha.franken.de>
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com>
 <20140409051929.GA29246@localhost>
 <20140409082445.GC1438@pax.zz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140409082445.GC1438@pax.zz.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39745
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Wed, Apr 09, 2014 at 10:24:45AM +0200, Florian Lohoff wrote:
> Most likely they never made it into gcc upstream but they are
> necessary working around the r10k speculative stores on non
> cache coherent machines like the IP28.

IMHO the patch went upstream judging from the incremental patches
here http://gcc.gnu.org/ml/gcc-patches/2012-12/msg01371.html.

Iirc it went into 4.4.0.

Thomas

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
