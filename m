Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Apr 2015 13:13:34 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:33623 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006880AbbDULNadCYi7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Apr 2015 13:13:30 +0200
Received: by ozlabs.org (Postfix, from userid 1011)
        id 4196114010F; Tue, 21 Apr 2015 21:13:26 +1000 (AEST)
From:   Rusty Russell <rusty@rustcorp.com.au>
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Guenter Roeck <linux@roeck-us.net>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org
Subject: Re: mips build failures due to commit 8dd928915a73 (mips: fix up obsolete cpu function usage)
In-Reply-To: <20150420210933.GB31618@fuloong-minipc.musicnaut.iki.fi>
References: <20150420194028.GA10814@roeck-us.net> <20150420210933.GB31618@fuloong-minipc.musicnaut.iki.fi>
User-Agent: Notmuch/0.17 (http://notmuchmail.org) Emacs/24.3.1 (x86_64-pc-linux-gnu)
Date:   Tue, 21 Apr 2015 13:45:35 +0930
Message-ID: <87fv7up15k.fsf@rustcorp.com.au>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <rusty@ozlabs.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rusty@rustcorp.com.au
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

Aaro Koskinen <aaro.koskinen@iki.fi> writes:
> Hi,
>
> On Mon, Apr 20, 2015 at 12:40:28PM -0700, Guenter Roeck wrote:
>> the upstream kernel fails to build mips:nlm_xlp_defconfig,
>> mips:nlm_xlp_defconfig, mips:cavium_octeon_defconfig, and possibly
>> other targets, with errors such as
>> 
>> arch/mips/kernel/smp.c:211:2: error:
>> 	passing argument 2 of 'cpumask_set_cpu' discards 'volatile' qualifier
>> 	from pointer target type
>> arch/mips/kernel/process.c:52:2: error:
>> 	passing argument 2 of 'cpumask_test_cpu' discards 'volatile' qualifier
>> 	from pointer target type
>> arch/mips/cavium-octeon/smp.c:242:2: error:
>> 	passing argument 2 of 'cpumask_clear_cpu' discards 'volatile' qualifier
>> 	from pointer target type
>> 
>> The problem was introduced with commit 8dd928915a73 (" mips: fix up
>> obsolete cpu function usage"). I would send a patch to fix it, but I
>> am not sure if removing 'volatile' from the variable declaration(s)
>> would be a good idea.
>
> I think removing volatile from cpu_callin_map declaration should be OK,
> since test_cpu (only reader) uses test_bit which takes care of it:
>
> 	static inline int test_bit(int nr, const volatile unsigned long *addr)

No, that got replaced too, with cpumask_test_cpu AFAICT.

You can open-code it, like so:

        test_bit(0, cpumask_bits(cpu_callin_map));

But you probably want to put a barrier in that loop instead of relying
on volatile.

Thanks,
Rusty.
