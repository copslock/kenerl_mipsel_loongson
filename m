Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 00:19:54 +0200 (CEST)
Received: from mail-pb0-f44.google.com ([209.85.160.44]:54905 "EHLO
        mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818702Ab3FSWTnVocZc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 00:19:43 +0200
Received: by mail-pb0-f44.google.com with SMTP id uo1so5531325pbc.31
        for <multiple recipients>; Wed, 19 Jun 2013 15:19:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=IYySz0BQxu9nDU/5kYbq3jwHGJMHcfXJw/dSYLhooDM=;
        b=X43K6bOMJev6M1Io2R1ii61ZxBd5/n5slV1FRMlTXhZPHR629Rd9LiiT8+qXhbGvEP
         ImhQuPtUIWinguopLvsfkdKKUdtb/66iybBx5wzNg/YVRedwj7dEg5CldkBVdT84maUS
         2su9WIgGbXCEs7ZsqFHG7u8BuY35ObFYPiktAru27LjWxet2CAX2WpKjd4lqvUsFKoUp
         ei0z9XWU1JseWEb1ZdoVOekJjQzWNkX2KIfm5ZNkji0rOGIwq4fdxuvL2h9gWrhRzNtj
         3WkgvRQ3ouANFyfg4PeRcGwtYfrZY9rNPTDQ6HwrNb6Kn+JztMjPN/wgAuJxHFQ3w17K
         v4OA==
X-Received: by 10.68.12.165 with SMTP id z5mr4680522pbb.172.1371680376672;
        Wed, 19 Jun 2013 15:19:36 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id o10sm24734929pbq.39.2013.06.19.15.19.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 15:19:35 -0700 (PDT)
Message-ID: <51C22E75.3020001@gmail.com>
Date:   Wed, 19 Jun 2013 15:19:33 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130514 Thunderbird/17.0.6
MIME-Version: 1.0
To:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH v2] mips: delete __cpuinit/__CPUINIT usage from MIPS code
References: <1371566339-18336-1-git-send-email-paul.gortmaker@windriver.com>
In-Reply-To: <1371566339-18336-1-git-send-email-paul.gortmaker@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37031
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 06/18/2013 07:38 AM, Paul Gortmaker wrote:
> The __cpuinit type of throwaway sections might have made sense
> some time ago when RAM was more constrained, but now the savings
> do not offset the cost and complications.  For example, the fix in
> commit 5e427ec2d0 ("x86: Fix bit corruption at CPU resume time")
> is a good example of the nasty type of bugs that can be created
> with improper use of the various __init prefixes.
>
> After a discussion on LKML[1] it was decided that cpuinit should go
> the way of devinit and be phased out.  Once all the users are gone,
> we can then finally remove the macros themselves from linux/init.h.
>
> Note that some harmless section mismatch warnings may result, since
> notify_cpu_starting() and cpu_up() are arch independent (kernel/cpu.c)
> and are flagged as __cpuinit  -- so if we remove the __cpuinit from
> the arch specific callers, we will also get section mismatch warnings.
> As an intermediate step, we intend to turn the linux/init.h cpuinit
> related content into no-ops as early as possible, since that will get
> rid of these warnings.  In any case, they are temporary and harmless.
>
> Here, we remove all the MIPS __cpuinit from C code and __CPUINIT
> from asm files.  MIPS is interesting in this respect, because there
> are also uasm users hiding behind their own renamed versions of the
> __cpuinit macros.
>
> [1] https://lkml.org/lkml/2013/5/20/589
>
> Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>

I get:


WARNING: vmlinux.o(.text+0x18640): Section mismatch in reference from 
the function register_cavium_notifier() to the variable 
.cpuinit.data:octeon_cpu_callback_nb.37045
The function register_cavium_notifier() references
the variable __cpuinitdata octeon_cpu_callback_nb.37045.
This is often because register_cavium_notifier lacks a __cpuinitdata
annotation or the annotation of octeon_cpu_callback_nb.37045 is wrong.

WARNING: vmlinux.o(.text+0x18650): Section mismatch in reference from 
the function register_cavium_notifier() to the variable 
.cpuinit.data:octeon_cpu_callback_nb.37045
The function register_cavium_notifier() references
the variable __cpuinitdata octeon_cpu_callback_nb.37045.
This is often because register_cavium_notifier lacks a __cpuinitdata
annotation or the annotation of octeon_cpu_callback_nb.37045 is wrong.

WARNING: vmlinux.o(.text+0x24778): Section mismatch in reference from 
the function start_secondary() to the function 
.cpuinit.text:calibrate_delay()
The function start_secondary() references
the function __cpuinit calibrate_delay().
This is often because start_secondary lacks a __cpuinit
annotation or the annotation of calibrate_delay is wrong.

WARNING: vmlinux.o(.text+0x247b4): Section mismatch in reference from 
the function start_secondary() to the function 
.cpuinit.text:notify_cpu_starting()
The function start_secondary() references
the function __cpuinit notify_cpu_starting().
This is often because start_secondary lacks a __cpuinit
annotation or the annotation of notify_cpu_starting is wrong.



So I think an alternate approach is required.

Really I think we need to leave all existing __cpuinitdata and __cpuinit 
annotations in place.

Instead we would first change the definitions of these two to be empyt:

#define __cpuinit
#define __cpuinitdata

Once that is working, we would make a second pass and remove the symbols 
themselves.

David Daney
