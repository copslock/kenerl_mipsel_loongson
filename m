Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Oct 2010 06:54:24 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:34951 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490948Ab0JOEyU convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 Oct 2010 06:54:20 +0200
Received: by gyf1 with SMTP id 1so183124gyf.36
        for <multiple recipients>; Thu, 14 Oct 2010 21:54:14 -0700 (PDT)
Received: by 10.150.207.20 with SMTP id e20mr776692ybg.398.1287118454024; Thu,
 14 Oct 2010 21:54:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.150.49.9 with HTTP; Thu, 14 Oct 2010 21:53:53 -0700 (PDT)
In-Reply-To: <4CB7713C.9040303@caviumnetworks.com>
References: <20101013064352.2743.80378.stgit@localhost6.localdomain6> <4CB7713C.9040303@caviumnetworks.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Thu, 14 Oct 2010 22:53:53 -0600
X-Google-Sender-Auth: 1PAW9v1u5S68D_JM64ReYpiphzM
Message-ID: <AANLkTik0mqV08ptsj9CXQxT_Ew2K479-V5r2DUdUXJv9@mail.gmail.com>
Subject: Re: [PATCH 1/2] of/flattree: Eliminate need to provide early_init_dt_scan_chosen_arch
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     ralf@linux-mips.org, benh@kernel.crashing.org, dediao@cisco.com,
        linux-mips@linux-mips.org, monstr@monstr.eu, dvomlehn@cisco.com,
        devicetree-discuss@lists.ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Thu, Oct 14, 2010 at 3:08 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 10/12/2010 11:44 PM, Grant Likely wrote:
>>
>> This patch refactors the early init parsing of the chosen node so that
>> architectures aren't forced to provide an empty implementation of
>> early_init_dt_scan_chosen_arch.  Instead, if an architecture wants to
>> do something different, it can either use a wrapper function around
>> early_init_dt_scan_chosen(), or it can replace it altogether.
>>
>> This patch was written in preparation to adding device tree support to
>> both x86 ad MIPS.
>>
>> Signed-off-by: Grant Likely<grant.likely@secretlab.ca>
>
> In conjunction with my 'MIPS: Add some irq definitins required by OF' and
> the '2/2 of/mips: Add device tree support to MIPS' patches, I can enable
> CONFIG_USE_OF, and build and run a kernel on my Octeon.  I haven't started
> using the device tree yet, but this is a good start.
>
> You can add my...
>
> Tested-by: David Daney <ddaney@caviumnetworks.com>

Thanks David.  I'll add your tags.

What do you think Ralf?  Should I merge these two patches up for
2.6.37?  As mentioned on my other reply, David's "MIPS: add some irq
definitions required by OF" patch isn't needed in my current
next-devicetree branch.

g.

>
>
>> ---
>>  arch/microblaze/kernel/prom.c |    5 -----
>>  arch/powerpc/kernel/prom.c    |   12 ++++++++++--
>>  drivers/of/fdt.c              |    2 --
>>  include/linux/of_fdt.h        |    2 +-
>>  4 files changed, 11 insertions(+), 10 deletions(-)
>
> [...]
>



-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
