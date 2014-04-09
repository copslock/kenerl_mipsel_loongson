Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 01:14:21 +0200 (CEST)
Received: from mga02.intel.com ([134.134.136.20]:41695 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822287AbaDIXOTIJrMW (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Apr 2014 01:14:19 +0200
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP; 09 Apr 2014 16:13:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.97,829,1389772800"; 
   d="scan'208";a="518026294"
Received: from wfg-t420.sh.intel.com ([10.239.197.51])
  by orsmga002.jf.intel.com with ESMTP; 09 Apr 2014 16:13:46 -0700
Received: from wfg by wfg-t420.sh.intel.com with local (Exim 4.77)
        (envelope-from <fengguang.wu@intel.com>)
        id 1WY1gf-0002Vd-Eh; Thu, 10 Apr 2014 07:13:45 +0800
Date:   Thu, 10 Apr 2014 07:13:45 +0800
From:   Fengguang Wu <fengguang.wu@intel.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Florian Lohoff <f@zz.de>, Michal Marek <mmarek@suse.cz>,
        kbuild-all@01.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed
 option -mr10k-cache-barrier=store.  Stop.
Message-ID: <20140409231345.GC8370@localhost>
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com>
 <20140409051929.GA29246@localhost>
 <20140409082445.GC1438@pax.zz.de>
 <20140409133229.GA22315@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140409133229.GA22315@alpha.franken.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <fengguang.wu@intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fengguang.wu@intel.com
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

On Wed, Apr 09, 2014 at 03:32:29PM +0200, Thomas Bogendoerfer wrote:
> On Wed, Apr 09, 2014 at 10:24:45AM +0200, Florian Lohoff wrote:
> > Most likely they never made it into gcc upstream but they are
> > necessary working around the r10k speculative stores on non
> > cache coherent machines like the IP28.
> 
> IMHO the patch went upstream judging from the incremental patches
> here http://gcc.gnu.org/ml/gcc-patches/2012-12/msg01371.html.
> 
> Iirc it went into 4.4.0.

That's interesting. I'm using the cross compiler

        gcc-4.6.3-nolibc/mips-linux

downloaded from

        https://www.kernel.org/pub/tools/crosstool/files/bin/x86_64/4.6.3/

I notice there is also a mips64 compiler. Should I use that?

Thanks,
Fengguang
