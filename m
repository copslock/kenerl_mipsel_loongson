Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Dec 2014 23:30:25 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:38008 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27008836AbaLQWaXYm2fB convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 17 Dec 2014 23:30:23 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id 27E121538A; Wed, 17 Dec 2014 22:30:16 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: rfc: remove early_printk from a few arches? (blackfin, m68k, mips)
References: <1418849927.28384.1.camel@perches.com>
        <CAJiQ=7DE1ojVRW6LqZg2LiqTQ0cgDY_a0nMGn=_Rs1mkuEgwoA@mail.gmail.com>
Date:   Wed, 17 Dec 2014 22:30:16 +0000
In-Reply-To: <CAJiQ=7DE1ojVRW6LqZg2LiqTQ0cgDY_a0nMGn=_Rs1mkuEgwoA@mail.gmail.com>
        (Kevin Cernekee's message of "Wed, 17 Dec 2014 13:30:02 -0800")
Message-ID: <yw1xk31phptz.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mru@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Kevin Cernekee <cernekee@gmail.com> writes:

> On Wed, Dec 17, 2014 at 12:58 PM, Joe Perches <joe@perches.com> wrote:
>> It seems like early_printk can be configured into
>> a few architectures but also appear not to be used.
>>
>> $ git grep -w "early_printk"
> [snip]
>> arch/mips/kernel/Makefile:obj-$(CONFIG_EARLY_PRINTK)    += early_printk.o
>
> Nowadays I try to use OF_EARLYCON whenever possible, but when that has
> been unavailable, I have used arch/mips/kernel/early_printk.c to get
> console output before the serial driver is initialized.  It runs very
> early in the boot sequence and has very few dependencies, which makes
> it useful for board bringup.

EARLY_PRINTK on MIPS is enabled just after prom_init(), well before
OF_EARLYCON is usable.  I'd prefer if it stayed that way.

-- 
Måns Rullgård
mans@mansr.com
