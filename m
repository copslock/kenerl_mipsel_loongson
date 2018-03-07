Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 21:11:57 +0100 (CET)
Received: from mail-pl0-x244.google.com ([IPv6:2607:f8b0:400e:c01::244]:42295
        "EHLO mail-pl0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994039AbeCGULuOhF0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 Mar 2018 21:11:50 +0100
Received: by mail-pl0-x244.google.com with SMTP id 93-v6so1972020plc.9;
        Wed, 07 Mar 2018 12:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PBN2DEFDcAVdNoB+CJrX7S+pGwbqjmH/++UTk7ZoMLo=;
        b=MA2BHisuKMbq2DWRog1yAbjuxeCIRGDQ3u2p5ID7G0NkC/MJiuar6iKcjBuhTIWrbZ
         1Ffr80dFk8X2dCJZiHSazke7J7HaE8pMaimqiiQd+FgTjJQ0m9y6hAWTgp48o1cbp4r1
         xCeh5X99DqFwUpQmIfrV8LOrRbs/HF0nhYKPW9aIiqMo8IqgpGU5Isl5XJnPlBpeGwDD
         56cTLeYTxoeZcNV+749IEGyxIZqBTo7r0IZ3CtzvQLRpqOfkfD6dpO9NgEy8stXDAMC9
         LOcsWRfxw4i6xO2IbSZOg0eM5A2gEo7RVouzkqJ5ZpdYa07pElWpKXgk+3nsU49pL9Bl
         um9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PBN2DEFDcAVdNoB+CJrX7S+pGwbqjmH/++UTk7ZoMLo=;
        b=S92GiVGyMsxDdnONd89e91vVJUC4N2oEJ0HqjONAqTWkZV+OBrlOJYC0QghDiwOHbH
         9ANnUehPCpw9Ao+cI8O07nTKZP5ltLjmV+HVK/h6LFETCW8hXOkiw/LjFcKA7BLRKD9m
         eJzfw7gRlulSH8Hopv3EY81D61zI6ZldqUcQUim1f5srwoGw5PmSGUfwu1EGVPYEdJVO
         iRxvH9mE3LFamceZtvWQzu/vysSU/JUoC0WAeKsbkTJ99tDkMBxDuoZJY3XJzeSYM3TG
         M357+CtNyYvqf4X5Jb6WlZRdWBSdcGcKDbe6gYsEzwFpf0PneaJ/JK3z+4y+FlK+imWt
         fv0A==
X-Gm-Message-State: APf1xPCYquiDAJyAaRSg59op0sBpsh6gtqOGUPqAuwmgmmECQfFTAL5K
        f+tO/pkfwgTMemDCfzNtDQc=
X-Google-Smtp-Source: AG47ELuPMaeFMH+mkGYyE3/OdJZE1gI58plDj1xrQIblR6RBm8v4HptfOwr5s+iiYd11+tW6EvqFGQ==
X-Received: by 2002:a17:902:51ee:: with SMTP id y101-v6mr21898884plh.157.1520453503599;
        Wed, 07 Mar 2018 12:11:43 -0800 (PST)
Received: from [192.168.1.70] (c-73-93-215-6.hsd1.ca.comcast.net. [73.93.215.6])
        by smtp.gmail.com with ESMTPSA id f82sm43096798pfd.175.2018.03.07.12.11.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Mar 2018 12:11:43 -0800 (PST)
Subject: Re: [PATCH] kbuild: Handle builtin dtb files containing hyphens
To:     James Hogan <jhogan@kernel.org>, linux-kbuild@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        stable@vger.kernel.org
References: <20180307140633.26182-1-jhogan@kernel.org>
From:   Frank Rowand <frowand.list@gmail.com>
Message-ID: <7ecea7ca-2931-16bc-a110-1ecdaf17f0f2@gmail.com>
Date:   Wed, 7 Mar 2018 12:11:41 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180307140633.26182-1-jhogan@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <frowand.list@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62845
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: frowand.list@gmail.com
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

I initially misread the patch description (and imagined an entirely
different problem).


On 03/07/18 06:06, James Hogan wrote:
> On dtb files which contain hyphens, the dt_S_dtb command to build the> dtb.S files (which allow DTB files to be built into the kernel) results> in errors like the following:> > bcm3368-netgear-cvg834g.dtb.S: Assembler messages:> bcm3368-netgear-cvg834g.dtb.S:5: Error: : no such section> bcm3368-netgear-cvg834g.dtb.S:5: Error: junk at end of line, first unrecognized character is `-'> bcm3368-netgear-cvg834g.dtb.S:6: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_begin:'> bcm3368-netgear-cvg834g.dtb.S:8: Error: unrecognized opcode `__dtb_bcm3368-netgear-cvg834g_end:'> bcm3368-netgear-cvg834g.dtb.S:9: Error: : no such section> bcm3368-netgear-cvg834g.dtb.S:9: Error: junk at end of line, first unrecognized character is `-'
Please replace the following section:

> This is due to the hyphen being used in symbol names. Replace all
> hyphens 
> with underscores in the dt_S_dtb command to avoid this problem.
> 
> Quite a lot of dts files have hyphens, but its only a problem on MIPS
> where such files can be built into the kernel. For example when
> CONFIG_DT_NETGEAR_CVG834G=y, or on BMIPS kernels when the dtbs target is
> used (in the latter case it admitedly shouldn't really build all the
> dtb.o files, but thats a separate issue).

with:

   cmd_dt_S_dtb constructs the assembly source to incorporate a devicetree
   FDT (that is, the .dtb file) as binary data in the kernel image.
   This assembly source contains labels before and after the binary data.
   The label names incorporate the file name of the corresponding .dtb
   file.  Hyphens are not legal characters in labels, so transform all
   hyphens from the file name to underscores when constructing the labels.

> 
> Fixes: 695835511f96 ("MIPS: BMIPS: rename bcm96358nb4ser to bcm6358-neufbox4-sercom")
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Michal Marek <michal.lkml@markovi.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Kevin Cernekee <cernekee@gmail.com>
> Cc: devicetree@vger.kernel.org
> Cc: linux-kbuild@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> Cc: <stable@vger.kernel.org> # 4.9+
> ---
>  scripts/Makefile.lib | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/scripts/Makefile.lib b/scripts/Makefile.lib
> index 5589bae34af6..a6f538b31ad6 100644
> --- a/scripts/Makefile.lib
> +++ b/scripts/Makefile.lib
> @@ -297,11 +297,11 @@ cmd_dt_S_dtb=						\
>  	echo '\#include <asm-generic/vmlinux.lds.h>'; 	\
>  	echo '.section .dtb.init.rodata,"a"';		\
>  	echo '.balign STRUCT_ALIGNMENT';		\
> -	echo '.global __dtb_$(*F)_begin';		\
> -	echo '__dtb_$(*F)_begin:';			\
> +	echo '.global __dtb_$(subst -,_,$(*F))_begin';	\
> +	echo '__dtb_$(subst -,_,$(*F))_begin:';		\
>  	echo '.incbin "$<" ';				\
> -	echo '__dtb_$(*F)_end:';			\
> -	echo '.global __dtb_$(*F)_end';			\
> +	echo '__dtb_$(subst -,_,$(*F))_end:';		\
> +	echo '.global __dtb_$(subst -,_,$(*F))_end';	\
>  	echo '.balign STRUCT_ALIGNMENT'; 		\
>  ) > $@
>  
> 

Reviewed-by: Frank Rowand <frowand.list@gmail.com>
