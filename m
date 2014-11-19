Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 23:07:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39960 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014056AbaKSWHPUUqXo (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Nov 2014 23:07:15 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sAJM79Af021739;
        Wed, 19 Nov 2014 23:07:09 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sAJM766K021730;
        Wed, 19 Nov 2014 23:07:06 +0100
Date:   Wed, 19 Nov 2014 23:07:06 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>
Cc:     linux-mips@linux-mips.org, Huacai Chen <chenhc@lemote.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>
Subject: Re: Lemote 2F build failure
Message-ID: <20141119220706.GB16990@linux-mips.org>
References: <20141119144717.GF8625@linux-mips.org>
 <20141119205405.GA6796@fuloong-minipc.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141119205405.GA6796@fuloong-minipc.musicnaut.iki.fi>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44310
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

On Wed, Nov 19, 2014 at 10:54:05PM +0200, Aaro Koskinen wrote:

> On Wed, Nov 19, 2014 at 03:47:18PM +0100, Ralf Baechle wrote:
> > Since I while already I'm getting this failure:
> > 
> > ERROR: "loongson_sysconf" [arch/mips/loongson/common/serial.ko] undefined!
> > scripts/Makefile.modpost:90: recipe for target '__modpost' failed
> > make[1]: *** [__modpost] Error 1
> > Makefile:1097: recipe for target 'modules' failed
> > make: *** [modules] Error 2
> > 
> > 
> > Below a config file to trigger the issue.
> 
> Are you sure you posted the right config? The modular serial 8250 build
> works fine for me for 2F, and also your config works.

Quite certainly - the buildbot sends me the error messages followed by the
config file used (which is not one of the defconfig but tweaked in weird
ways) in a single mail.

This issue is popping up for a number of days already for the upstream-sfr
tree's mips-for-linux-next branch; I last saw it for commit
298395f5f43d1ea4b00e8c9ddaa01d9d8e653582 which is still the current HEAD
of that tree.

I don't see an EXPORT_SYMBOL for loongson_sysconf in that tree.

I took a quick look at arch/mips/loongson/common/serial.c.  This file
probably shouldn't register a platform device - that's dangerous business
from a module.  And it indeed looks like it had never been thought through
what will happen if this file was a module.  Just build it always.

  Ralf
