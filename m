Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2014 11:28:55 +0200 (CEST)
Received: from mail-qa0-f44.google.com ([209.85.216.44]:49505 "EHLO
        mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826470AbaHAJ2wxmsvG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 1 Aug 2014 11:28:52 +0200
Received: by mail-qa0-f44.google.com with SMTP id f12so3643449qad.31
        for <multiple recipients>; Fri, 01 Aug 2014 02:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=CiBy35XdCTQdi3726a3eYgZli3SgUZC5dTLafWvKQ4Q=;
        b=YrCxChapOGqsatWX8rlC86mEq6x3grbKJiyzSZs+wswj0++A5/PvchjLYfKxWYRKTt
         Ws0AM8jQk2ryuE4YOkbBecCpHGmy8t9O1FQ7z51rKV3RLHv0KD9NfRFCOpTF2QT36CgS
         bsuAjNYBqaBvnKnBu6vSKfFGE2d9Z5yT2xowby4PJ/0BUQWUaW/NVvEgd5NlESClfUTt
         yXS1du7zHGQxLrELPL73eRQjK6JCBGnRUPfxdnAAxctft8pv1yzsP6B0ueLvIrDlFd2e
         kD7i74OamV+eFmaLKg+QpHGe6WjldEs/T2GyGLGiEVRrD2XVuGFjrVTZRmm8ikEqrjGW
         hqDA==
MIME-Version: 1.0
X-Received: by 10.140.48.161 with SMTP id o30mr6519344qga.68.1406885326402;
 Fri, 01 Aug 2014 02:28:46 -0700 (PDT)
Received: by 10.140.105.119 with HTTP; Fri, 1 Aug 2014 02:28:46 -0700 (PDT)
In-Reply-To: <20140801054739.GF12788@jayachandranc.netlogicmicro.com>
References: <53dac64a.+6998x07jTwh9JtK%fengguang.wu@intel.com>
        <tencent_4DD2F4897C8F21F621E1333A@qq.com>
        <20140801054739.GF12788@jayachandranc.netlogicmicro.com>
Date:   Fri, 1 Aug 2014 17:28:46 +0800
X-Google-Sender-Auth: NzJDpORP1Tt-XcHje4YGzMHh3aM
Message-ID: <CAAhV-H42Y7JPgiV66uLDG6v3j5cbs2KnUd8N_g2O42ceau0hfg@mail.gmail.com>
Subject: Re: [next:master 9246/10000]arch/mips/include/asm/mach-netlogic/topology.h:14:0:
 warning:"topology_physical_package_id" redefined
From:   Huacai Chen <chenhc@lemote.com>
To:     "Jayachandran C." <jchandra@broadcom.com>
Cc:     kbuild test robot <fengguang.wu@intel.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        kbuild-all <kbuild-all@01.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Jayachandran

I have update my patch, do you think this one is OK? I have built with
nlm_xlr_defconfig, no warnings again.
http://patchwork.linux-mips.org/patch/7502/

Huacai

On Fri, Aug 1, 2014 at 1:47 PM, Jayachandran C. <jchandra@broadcom.com> wrote:
> Hi Huacai,
>
> On Fri, Aug 01, 2014 at 09:19:11AM +0800, 陈华才 wrote:
>> Hi, Jayachandran
>>
>> I think I introduce a more *general* method of MIPS CPU's topology in commit bda4584cd94 (MIPS: Support CPU topology files in sysfs). So, could you please modify the Netlogic's code to adaptive the new framework? If you can't do that, I'll send a new version of my patch by adding some #ifndef.
>
> You have added the definitions for topology in asm/smp.h
>
> +#define topology_physical_package_id(cpu)      (cpu_data[cpu].package)
> +#define topology_core_id(cpu)                  (cpu_data[cpu].core)
> +#define topology_core_cpumask(cpu)             (&cpu_core_map[cpu])
> +#define topology_thread_cpumask(cpu)           (&cpu_sibling_map[cpu])
>
> These changes have to be in asm/topology.h and should only change the
> definitions if mach-<platform>/topology.h does not define them.
>
> Can you please look at fixing this?
>
> Thanks,
> JC.
>
