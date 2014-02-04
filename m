Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2014 19:27:41 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:58277 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817974AbaBDS1fcI0bG (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 4 Feb 2014 19:27:35 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s14IRUCB023783;
        Tue, 4 Feb 2014 19:27:30 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s14IRP9h023777;
        Tue, 4 Feb 2014 19:27:25 +0100
Date:   Tue, 4 Feb 2014 19:27:25 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc:     kbuild test robot <fengguang.wu@intel.com>, kbuild-all@01.org,
        target-devel <target-devel@vger.kernel.org>,
        linux-mips@linux-mips.org
Subject: Re: [target:for-next 51/51] ERROR:
 "__cmpxchg_called_with_bad_pointer" undefined!
Message-ID: <20140204182725.GF19285@linux-mips.org>
References: <52e8a4ef.ROAJSlpOaZtBxfoG%fengguang.wu@intel.com>
 <1390989698.17325.73.camel@haakon3.risingtidesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390989698.17325.73.camel@haakon3.risingtidesystems.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39208
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

On Wed, Jan 29, 2014 at 02:01:38AM -0800, Nicholas A. Bellinger wrote:

> On Wed, 2014-01-29 at 14:51 +0800, kbuild test robot wrote:
> > tree:   git://git.kernel.org/pub/scm/linux/kernel/git/nab/target-pending.git for-next
> > head:   7769401d351d54d5cbcb6400ec60c0b916e87a7e
> > commit: 7769401d351d54d5cbcb6400ec60c0b916e87a7e [51/51] target: Fix percpu_ref_put race in transport_lun_remove_cmd
> > config: make ARCH=mips allmodconfig
> > 
> > All error/warnings:
> > 
> > >> ERROR: "__cmpxchg_called_with_bad_pointer" undefined!
> > 
> 
> So MIPS doesn't like typedef bool as 1-byte char being used for cmpxchg
> -> ll/sc instructions..
> 
> Fixing this up now by making se_cmd->lun_ref_active use a single word
> instead.

Thanks, looking good.

Note that this is a hardware restriction on LL/SC rsp. LLD/SCD which only
operate on natually aligned four rsp. eight byte operands.  Could fixed
but would slow down and inflate every invocation of cmpxchg() which is
currently an inline function and I feel a bit uneasy about hardware
behaviour when mixing LL/SC rsp. LLD/SCD with conventional loads and
stores.

  Ralf
