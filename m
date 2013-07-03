Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jul 2013 16:01:55 +0200 (CEST)
Received: from mail-wg0-f49.google.com ([74.125.82.49]:33061 "EHLO
        mail-wg0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823015Ab3GCOBvMFA0f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Jul 2013 16:01:51 +0200
Received: by mail-wg0-f49.google.com with SMTP id a12so160758wgh.16
        for <multiple recipients>; Wed, 03 Jul 2013 07:01:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p6tzu1pwq9Qyveu7YGkwgh2MqdEwEajk5JGXWgSUUL8=;
        b=y+Hi5iuD5kYMxDyidNFcicayKXhT6G9/dG0Jd5VkD9KsmQcLCfYnPhaJ+SIrIR8lvJ
         J62eEVVMyEMEMjQDQdjjz3IgzFtwJw5DwuPhvTyPr8KTBK6lxvAJbqksekNUmef6mamA
         Cdi5bP5R1XHaztQsfFwlI4EkcA9emns2AvxLbFkWGTS87KXswZ1evqUAolSdLuW+Zdsi
         8dIIbhlp/nI7OElj9FGcxQAuxJga00N2dIuCJIUtdM2DWGlJezy8XuBo0h1bcHfVaR1S
         p4hJbtqXeiuHOfrCcZK4x/1YtDM2tdxBJfuYJhvjISoJ60OyAsOO8WgtqCYMCMZ/1Fnu
         g/qA==
X-Received: by 10.180.36.12 with SMTP id m12mr710457wij.10.1372860105664; Wed,
 03 Jul 2013 07:01:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.194.163.138 with HTTP; Wed, 3 Jul 2013 07:01:05 -0700 (PDT)
In-Reply-To: <20130626145234.GB7171@linux-mips.org>
References: <1371742590-10138-1-git-send-email-Steven.Hill@imgtec.com> <20130626145234.GB7171@linux-mips.org>
From:   Markos Chandras <markos.chandras@gmail.com>
Date:   Wed, 3 Jul 2013 15:01:05 +0100
Message-ID: <CAG2jQ8gf+0rmO-JynMGUUw7evAU2eG5JdWG7+rT58ATDfCFRVQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "MIPS: make CAC_ADDR and UNCAC_ADDR account for PHYS_OFFSET"
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Florian Fainelli <florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <markos.chandras@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@gmail.com
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

On 26 June 2013 15:52, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Jun 20, 2013 at 10:36:30AM -0500, Steven J. Hill wrote:
>
>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>
>> This reverts commit 3f4579252aa166641861a64f1c2883365ca126c2. It is
>> invalid because the macros CAC_ADDR and UNCAC_ADDR have a kernel
>> virtual address as an argument and also returns a kernel virtual
>> address. Using and physical address PHYS_OFFSET is blatantly wrong
>> for a macro common to multiple platforms.
>
> While the patch itself is looking sane at a glance, I'm wondering if this
> is fixing any actual bug or is just the result of a code review?
>
>   Ralf
>

I am afraid this commit[1] broke the build in
upstream-sfr/mips-for-linux-next with errors like this

arch/mips/include/asm/mach-generic/spaces.h:29:0: warning:
"UNCAC_BASE" redefined [enabled by default]
In file included from arch/mips/include/asm/addrspace.h:13:0,
                 from arch/mips/include/asm/barrier.h:11,
                 from arch/mips/include/asm/bitops.h:18,
                 from include/linux/bitops.h:22,
                 from include/linux/kernel.h:10,
                 from include/asm-generic/bug.h:13,
                 from arch/mips/include/asm/bug.h:41,
                 from include/linux/bug.h:4,
                 from include/linux/page-flags.h:9,
                 from kernel/bounds.c:9:
arch/mips/include/asm/mach-ar7/spaces.h:20:0: note: this is the
location of the previous definition

[1]: http://git.linux-mips.org/?p=ralf/upstream-sfr.git;a=commit;h=ed3ce16c3d2ba7cac321d29ec0a7d21408ea8437

--
Regards,
Markos Chandras
