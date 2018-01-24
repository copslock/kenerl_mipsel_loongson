Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 11:08:38 +0100 (CET)
Received: from mail-lf0-x244.google.com ([IPv6:2a00:1450:4010:c07::244]:40416
        "EHLO mail-lf0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990406AbeAXKIWwcOEV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Jan 2018 11:08:22 +0100
Received: by mail-lf0-x244.google.com with SMTP id h92so4450311lfi.7;
        Wed, 24 Jan 2018 02:08:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=PHwqi/vrpI5kQF4mQGYSGX4Mlv+55wL6uHq2bye0vZw=;
        b=vSavkhHHrgOgD+m00EIm7hy1A7V6k6HCAhGG5hsvcXXPIr0F06KQunkZQcNgfO98TD
         ytGZKbEetl8E+No4fGhPXj0i+qkdKHWvhPlx1XFdLjKvyP4HKRHREdfeAIufsANx9Sz3
         Eg/MqdIQabj1p7Kv6Xeaw2/vcEiPjl4DfeXzz6jvHLSPoGY4EOlBxwSxtxahOB+7t7aY
         MHqfxQiimelEk+zRxBTCshuPolAHfu6NTEfw4gO5t9INfe3/qj66wNBT7OpClRPWq3AK
         FWjgV0Jc9fSEdfZfBF9CdAJIXF5BLygL8gGC8XemAL2HYwGSQD0Q0By0IgocUsqEQ+ZY
         uOOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=PHwqi/vrpI5kQF4mQGYSGX4Mlv+55wL6uHq2bye0vZw=;
        b=F5E8ury/0nKHo7dS1z84EgQ3cdANdIks8a1MfGTmOPRJtq2K+GkTjz9mETMhOolRy6
         Bq4DupdnzbIcjI1SjF4aRuDVIndLzrLp5CPqegTfU9xgxAbeHBeXucPXj9EMmHzQZnhl
         O6FqFPi+Ub5i1PSaG5jEgwAKBBusga2jJjgDak/wyyWkw2Mw5POIcQ/ZNBPBVbO14mvc
         +CtM8WAQY5oyslUCSFUPbv1qD5K23c953dai4MPvO8Fs182SicgSzQMBYpKsQXD2wVIw
         aAZQoTrccM76Q9q4btalAun0kzkCc9SEFIqoQ0TN/5rNxMzc4DoTcpzzjmvt+gYak1b2
         cqDg==
X-Gm-Message-State: AKwxytfHSfjgLdHdwAkc+odKZnKfYAUBEINTdZVtMl0a9rzjGWX4w9Wx
        NAKnUrNfvI/U6QUbKD7SFKY=
X-Google-Smtp-Source: AH8x224WGQG4kIRxgAZqj8SDgAatrP7+VrNfhxfg33vfCQZFl9gLKFaEl1e/AU+UC2yJyrkWe4ciYw==
X-Received: by 10.46.84.70 with SMTP id y6mr3291880ljd.36.1516788497343;
        Wed, 24 Jan 2018 02:08:17 -0800 (PST)
Received: from mobilestation ([95.79.164.146])
        by smtp.gmail.com with ESMTPSA id q123sm1404479ljq.24.2018.01.24.02.08.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Jan 2018 02:08:16 -0800 (PST)
Date:   Wed, 24 Jan 2018 13:08:31 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>, ralf@linux-mips.org,
        miodrag.dinic@mips.com, jhogan@kernel.org, goran.ferenc@mips.com,
        david.daney@cavium.com, paul.gortmaker@windriver.com,
        paul.burton@mips.com, alex.belits@cavium.com,
        Steven.Hill@cavium.com, alexander.sverdlin@nokia.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/14] MIPS: memblock: Print out kernel virtual mem layout
Message-ID: <20180124100831.GB2281@mobilestation>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-12-fancer.lancer@gmail.com>
 <cce36f73-4381-f830-3422-1cef8ad9e622@gmail.com>
 <20180118201856.GA996@mobilestation>
 <b2797958-d217-9c8d-10ca-b9bc43ae585b@mips.com>
 <20180119142712.GA3101@mobilestation>
 <eef02082-c3b1-e42b-d5ff-1c0d5cb8d708@mips.com>
 <20180123191051.GA28147@mobilestation>
 <e751ccda-ab57-dfe8-0a16-25bb5368337c@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e751ccda-ab57-dfe8-0a16-25bb5368337c@mips.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <fancer.lancer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62307
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fancer.lancer@gmail.com
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

Hello Matt,

On Wed, Jan 24, 2018 at 09:46:07AM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
> Hi Serge,
> 
> On 23/01/18 19:10, Serge Semin wrote:
> >Hello Matt,
> >
> >On Tue, Jan 23, 2018 at 03:35:14PM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
> >>Hi Serge,
> >>
> >>On 19/01/18 14:27, Serge Semin wrote:
> >>>On Fri, Jan 19, 2018 at 07:59:43AM +0000, Matt Redfearn <matt.redfearn@mips.com> wrote:
> >>>
> >>>Hello Matt,
> >>>
> >>>>Hi Serge,
> >>>>
> >>>>
> >>>>
> >>>>On 18/01/18 20:18, Serge Semin wrote:
> >>>>>On Thu, Jan 18, 2018 at 12:03:03PM -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> >>>>>>On 01/17/2018 02:23 PM, Serge Semin wrote:
> >>>>>>>It is useful to have the kernel virtual memory layout printed
> >>>>>>>at boot time so to have the full information about the booted
> >>>>>>>kernel. In some cases it might be unsafe to have virtual
> >>>>>>>addresses freely visible in logs, so the %pK format is used if
> >>>>>>>one want to hide them.
> >>>>>>>
> >>>>>>>Signed-off-by: Serge Semin <fancer.lancer@gmail.com>
> >>>>>>
> >>>>>>I personally like having that information because that helps debug and
> >>>>>>have a quick reference, but there appears to be a trend to remove this
> >>>>>>in the name of security:
> >>>>>>
> >>>>>>https://patchwork.kernel.org/patch/10124007/
> >>>>>>
> >>>>>>maybe hide this behind a configuration option?
> >>>>>
> >>>>>Yeah, arm code was the place I picked the function up.) But in my case
> >>>>>I've used %pK so the pointers would disappear from logging when
> >>>>>kptr_restrict sysctl is 1 or 2.
> >>>>>I agree, that we might need to make the printouts optional. If there is
> >>>>>any kernel config, which for instance increases the kernel security we
> >>>>>could also use it or anything else to discard the printouts at compile
> >>>>>time.
> >>>>
> >>>>
> >>>>Certainly, when KASLR is active it would be preferable to hide this
> >>>>information, so you could use CONFIG_RELOCATABLE. The existing KASLR stuff
> >>>>additionally hides this kind of information behind CONFIG_DEBUG_KERNEL, so
> >>>>that only people actively debugging the kernel see it:
> >>>>
> >>>>http://elixir.free-electrons.com/linux/v4.15-rc8/source/arch/mips/kernel/setup.c#L604
> >>>
> >>>Ok. I'll hide the printouts behind both of that config macros in the next patchset
> >>>version.
> >>
> >>
> >>Another thing to note - since ad67b74d2469d ("printk: hash addresses printed
> >>with %p") %pK at this time in the boot process is useless since the RNG is
> >>not sufficiently initialised and all prints end up being "(ptrval)". Hence
> >>after v4.15-rc2 we end up with output like:
> >>
> >>[    0.000000] Kernel virtual memory layout:
> >>[    0.000000]     lowmem  : 0x(ptrval) - 0x(ptrval)  ( 256 MB)
> >>[    0.000000]       .text : 0x(ptrval) - 0x(ptrval)  (7374 kB)
> >>[    0.000000]       .data : 0x(ptrval) - 0x(ptrval)  (1901 kB)
> >>[    0.000000]       .init : 0x(ptrval) - 0x(ptrval)  (1600 kB)
> >>[    0.000000]       .bss  : 0x(ptrval) - 0x(ptrval)  ( 415 kB)
> >>[    0.000000]     vmalloc : 0x(ptrval) - 0x(ptrval)  (1023 MB)
> >>[    0.000000]     fixmap  : 0x(ptrval) - 0x(ptrval)  (  68 kB)
> >>
> >
> >It must be some bug in the algo. What point in the %pK then? According to
> >the documentation the only way to see the pointers is when (kptr_restrict == 0).
> >But if it is we don't get into the restricted_pointer() method at all:
> >http://elixir.free-electrons.com/linux/v4.15-rc9/source/lib/vsprintf.c#L1934
> >In this case the vsprintf() executes the method ptr_to_id(), which of course
> >default to _not_ leak addresses, and hash it before printing.
> >
> >Really %pK isn't supposed to be dependent from RNG at all since kptr_restrict
> >doesn't do any value randomization.
> 
> 
> That was true until v4.15-rc2. The behavior of %pK was changed without that
> being reflected in the documentation. A patch
> (https://patchwork.kernel.org/patch/10124413/) is in progress to update
> this.
> 
> >
> >>
> >>The %px format specifier was added for cases such as this, where we really
> >>want to print the unmodified address. And as long as this function is
> >>suitably guarded to only do this when KASLR is deactivated /
> >>CONFIG_DEBUG_KERNEL is activated, etc, then we are not unwittingly leaking
> >>information - we are deliberately making it available.
> >>
> >
> >If %pK would work as it's stated by the kernel documentation:
> >https://www.kernel.org/doc/Documentation/printk-formats.txt
> >then the only change I'd suggest to have here is to close the kernel memory
> >layout printout method by the CONFIG_DEBUG_KERNEL ifdef-macro. The kptr_restrict
> >should default to 1/2 if the KASLR is activated:
> >https://lwn.net/Articles/444556/
> 
> Yeah, again, the documentation is no longer correct, and %pK will always be
> hashed, and before the RNG is initialized it does not even hash it, just
> returning "(ptrval)".  So I'd recommend guarding with CONFIG_DEBUG_KERNEL
> and switching the format specifier to %px.
> 

Oh, it isn't the bug then) I'll do as you suggest and replace %pK with
%px closing the code by CONFIG_DEBUG_KERNEL macro.

Regards,
-Sergey

> Thanks,
> Matt
> 
> >
> >Regards,
> >-Sergey
> >
> >>Thanks,
> >>Matt
> >>
> >>>
> >>>Regards,
> >>>-Sergey
> >>>
> >>>>
> >>>>Thanks,
> >>>>Matt
> >>>>
> >>>>>
> >>>>>>-- 
> >>>>>>Florian
