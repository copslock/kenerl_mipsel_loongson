Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Mar 2010 11:00:26 +0100 (CET)
Received: from cantor2.suse.de ([195.135.220.15]:39845 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491820Ab0COKAT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Mar 2010 11:00:19 +0100
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.221.2])
        by mx2.suse.de (Postfix) with ESMTP id D0AD6867E2;
        Mon, 15 Mar 2010 11:00:18 +0100 (CET)
Date:   Mon, 15 Mar 2010 11:00:11 +0100 (CET)
From:   Jiri Kosina <jkosina@suse.cz>
X-X-Sender: jikos@twin.jikos.cz
To:     Wolfram Sang <w.sang@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org,
        Grant Likely <grant.likely@secretlab.ca>,
        kernel-janitors@vger.kernel.org,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Gortmaker <p_gortmaker@yahoo.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-mips@linux-mips.org, rtc-linux@googlegroups.com
Subject: Re: [PATCH] init dynamic bin_attribute structures
In-Reply-To: <1268612981-9009-1-git-send-email-w.sang@pengutronix.de>
Message-ID: <alpine.LRH.2.00.1003151055060.26353@twin.jikos.cz>
References: <alpine.LFD.2.00.1003141054050.3719@i5.linux-foundation.org> <1268612981-9009-1-git-send-email-w.sang@pengutronix.de>
User-Agent: Alpine 2.00 (LRH 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <jkosina@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26231
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jkosina@suse.cz
Precedence: bulk
X-list: linux-mips

On Mon, 15 Mar 2010, Wolfram Sang wrote:

> Commit 6992f5334995af474c2b58d010d08bc597f0f2fe introduced this requirement.
> First, at25 was fixed manually. Then, other occurences were found with
> coccinelle and the following semantic patch. Results were reviewed and fixed
> up:
> 
> @ init @
> identifier struct_name, bin;
> @@
> 
> 	struct struct_name {
> 		...
> 		struct bin_attribute bin;
> 		...
> 	};
> 
> @ main extends init @
> expression E;
> statement S;
> identifier name, err;
> @@
> 
> (
> 	struct struct_name *name;
> |
> -	struct struct_name *name = NULL;
> +	struct struct_name *name;
> )
> 	...
> (
> 	sysfs_bin_attr_init(&name->bin);
> |
> +	sysfs_bin_attr_init(&name->bin);
> 	if (sysfs_create_bin_file(E, &name->bin))
> 		S
> |
> +	sysfs_bin_attr_init(&name->bin);
> 	err = sysfs_create_bin_file(E, &name->bin);
> )
> 
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Eric W. Biederman <ebiederm@xmission.com>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> ---
>  arch/mips/txx9/generic/setup.c |    1 +
>  drivers/misc/eeprom/at25.c     |    1 +
>  drivers/rtc/rtc-ds1742.c       |    1 +
>  3 files changed, 3 insertions(+), 0 deletions(-)

I don't understand how cocinelle works, but the resulting patch seems to 
be incomplete.

The fix is needed at least in firmware loader (for which Greg has already 
queued patch), in ACPI thermal driver [1], etc).

[1] http://lkml.indiana.edu/hypermail/linux/kernel/1003.1/02680.html

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
