Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2015 22:06:46 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33365 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025913AbbDTUGpRcdlC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Apr 2015 22:06:45 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t3KK6jAs023037;
        Mon, 20 Apr 2015 22:06:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t3KK6gpJ023036;
        Mon, 20 Apr 2015 22:06:42 +0200
Date:   Mon, 20 Apr 2015 22:06:42 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up
 obsolete cpu function usage)
Message-ID: <20150420200642.GA23756@linux-mips.org>
References: <20150420194028.GA10814@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150420194028.GA10814@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46948
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

On Mon, Apr 20, 2015 at 12:40:28PM -0700, Guenter Roeck wrote:

> the upstream kernel fails to build mips:nlm_xlp_defconfig,
> mips:nlm_xlp_defconfig, mips:cavium_octeon_defconfig, and possibly
> other targets, with errors such as
> 
> arch/mips/kernel/smp.c:211:2: error:
> 	passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier
> 	from pointer target type
> arch/mips/kernel/process.c:52:2: error:
> 	passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier
> 	from pointer target type
> arch/mips/cavium-octeon/smp.c:242:2: error:
> 	passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier
> 	from pointer target type
> 
> The problem was introduced with commit 8dd928915a73 (" mips: fix up obsolete cpu
> function usage"). I would send a patch to fix it, but I am not sure if removing
> 'volatile' from the variable declaration(s) would be a good idea.
> 
> I don't recall seeing the problem in -next, but unless I am missing something,
> the patch never made it into -next to start with.

It was posted on March 2nd as part of a larger series.  Only this patch
9/16 was send to linux-mips and when I tested the patch it failed.  Back
then I blamed it on not having patches 1 to 8 in my test tree so I didn't
diver deeper into the issue and dropped the patch ...

  Ralf
