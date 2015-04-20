Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2015 23:09:40 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:33028 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011848AbbDTVJi1S9fW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Apr 2015 23:09:38 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 4016A21B9E1;
        Tue, 21 Apr 2015 00:09:39 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id KmB+Jz1a+htv; Tue, 21 Apr 2015 00:09:34 +0300 (EEST)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 465C45BC006;
        Tue, 21 Apr 2015 00:09:34 +0300 (EEST)
Date:   Tue, 21 Apr 2015 00:09:33 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org,
        Rusty Russell <rusty@rustcorp.com.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up
 obsolete cpu function usage)
Message-ID: <20150420210933.GB31618@fuloong-minipc.musicnaut.iki.fi>
References: <20150420194028.GA10814@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150420194028.GA10814@roeck-us.net>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

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
> The problem was introduced with commit 8dd928915a73 (" mips: fix up
> obsolete cpu function usage"). I would send a patch to fix it, but I
> am not sure if removing 'volatile' from the variable declaration(s)
> would be a good idea.

I think removing volatile from cpu_callin_map declaration should be OK,
since test_cpu (only reader) uses test_bit which takes care of it:

	static inline int test_bit(int nr, const volatile unsigned long *addr)

A.
