Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2018 01:32:26 +0100 (CET)
Received: from mail-pg0-x241.google.com ([IPv6:2607:f8b0:400e:c05::241]:36059
        "EHLO mail-pg0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeBQAcShRLYP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2018 01:32:18 +0100
Received: by mail-pg0-x241.google.com with SMTP id j9so3695310pgv.3
        for <linux-mips@linux-mips.org>; Fri, 16 Feb 2018 16:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=5I1KFWRVR5aEzYt/C5DIWy4P6JyBHIxXvEXC7bTgnsE=;
        b=hUQvTgmGL3vMs7xGooatWYIlfycYhhImCrH4x1X/8XG/eiVQJhGwNmqdVylxXzqAkp
         HoMfXq00DcUEgsisWIZL++/3ehML7peX5N+WheVq3FgmkY3PgZvHDCv5UetXPhKjJGWX
         4eydgOc+JaTtuTDWc7fDvnEw7/GRA4apYCGQo7PsS6SKVCXfoSwLf3AbsWmssMtRFwff
         H6lvUca9Plrz4BHS5TBT75hS/WqfJk3aJOtZlX5ihnDaXzebwFfUC7Q40vEYD10oLh2v
         as8pesuCrrHxlSfRdIgwhKJnroLlwDPtOhp2+up4MZUxD3nuH3i7OfIA+ivX8Fqeah98
         XtdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=5I1KFWRVR5aEzYt/C5DIWy4P6JyBHIxXvEXC7bTgnsE=;
        b=rY+YEgK8ZSB+m++3dV416unaFY5jZ+PhPs4ToYI+L47CfbwzBOZoBGPf5xuuf3aOfv
         QGcAj9nxI6m4E6M3I16HtvzkcMeEKDb5Dufmp0OqcE+/QBA6T2ngKKqnSKRODgzC+lGf
         W/En7pHfHEKVufGcYh4UvNryU+ZaPvn5E15cwYJk3/XYxnqU91ARDdpgY3ioEdVdf495
         fLPfcTjy/mc+Or1gjfMh2KklTR8Ng88IbxPwnxr8DYgBGCfGQSwzo9qZ7kjCKrXRDng8
         Qht6HXk1oT5h1u3fDLT0cEmpo3EDajodb8w8q6djnjlXzNHfshrCU3le3eiZnTei9Wfi
         S3zA==
X-Gm-Message-State: APf1xPCbloNTq7pVREV23Ln2mx0oJwaC77pNrbyHuo6A8/p8l4+CYwxc
        I5Zry9806SUCAQkIaX/j+i+13A==
X-Google-Smtp-Source: AH8x2270Yq482ilufLHVXH2kPukP/qEqPenuLcDyKOav4jghJUcZyuqIqgwlyxq2xOJMEdXcDyxN3A==
X-Received: by 10.99.120.205 with SMTP id t196mr6275655pgc.392.1518827531906;
        Fri, 16 Feb 2018 16:32:11 -0800 (PST)
Received: from localhost ([12.206.222.5])
        by smtp.gmail.com with ESMTPSA id n66sm45457503pfn.111.2018.02.16.16.32.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 16 Feb 2018 16:32:11 -0800 (PST)
Date:   Fri, 16 Feb 2018 16:32:11 -0800 (PST)
X-Google-Original-Date: Fri, 16 Feb 2018 16:32:09 PST (-0800)
Subject:     Re: [PATCH] lib: Rename compiler intrinsic selects to GENERIC_LIB_*
In-Reply-To: <20180213224937.GF4290@saruman>
CC:     matt.redfearn@mips.com, antonynpavlov@gmail.com,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@sifive.com>
To:     jhogan@kernel.org
Message-ID: <mhng-e6250604-af06-4308-abe1-b5bc8f4c8b75@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <palmer@sifive.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62573
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: palmer@sifive.com
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

On Tue, 13 Feb 2018 14:49:37 PST (-0800), jhogan@kernel.org wrote:
> On Tue, Feb 13, 2018 at 01:48:18PM -0800, Palmer Dabbelt wrote:
>> On Fri, 09 Feb 2018 05:22:52 PST (-0800), matt.redfearn@mips.com wrote:
>> > When these are included into arch Kconfig files, maintaining
>> > alphabetical ordering of the selects means these get split up. To allow
>> > for keeping things tidier and alphabetical, rename the selects to
>> > GENERIC_LIB_*
>> >
>> > Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>> 
>> Thanks!  Do you want me to take this in my tree?
>> 
>> Reviewed-by: Palmer Dabbelt <palmer@sifive.com>
>
> Since a new version of the "MIPS: use generic GCC library routines from
> lib/" series would depend on it, and it makes sense for that series to
> go via the MIPS tree, I think it would be simpler for this patch to also
> be taken (with your ack) via the MIPS tree. Is that okay?

That's great, thanks!

>
> Thanks
> James
>
>> 
>> > ---
>> >  arch/riscv/Kconfig |  6 +++---
>> >  lib/Kconfig        | 12 ++++++------
>> >  lib/Makefile       | 12 ++++++------
>> >  3 files changed, 15 insertions(+), 15 deletions(-)
>> >
>> > diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> > index 2c6adf12713a..5f1e2188d029 100644
>> > --- a/arch/riscv/Kconfig
>> > +++ b/arch/riscv/Kconfig
>> > @@ -99,9 +99,9 @@ config ARCH_RV32I
>> >  	bool "RV32I"
>> >  	select CPU_SUPPORTS_32BIT_KERNEL
>> >  	select 32BIT
>> > -	select GENERIC_ASHLDI3
>> > -	select GENERIC_ASHRDI3
>> > -	select GENERIC_LSHRDI3
>> > +	select GENERIC_LIB_ASHLDI3
>> > +	select GENERIC_LIB_ASHRDI3
>> > +	select GENERIC_LIB_LSHRDI3
>> >
>> >  config ARCH_RV64I
>> >  	bool "RV64I"
>> > diff --git a/lib/Kconfig b/lib/Kconfig
>> > index c5e84fbcb30b..946d0890aad6 100644
>> > --- a/lib/Kconfig
>> > +++ b/lib/Kconfig
>> > @@ -584,20 +584,20 @@ config STRING_SELFTEST
>> >
>> >  endmenu
>> >
>> > -config GENERIC_ASHLDI3
>> > +config GENERIC_LIB_ASHLDI3
>> >  	bool
>> >
>> > -config GENERIC_ASHRDI3
>> > +config GENERIC_LIB_ASHRDI3
>> >  	bool
>> >
>> > -config GENERIC_LSHRDI3
>> > +config GENERIC_LIB_LSHRDI3
>> >  	bool
>> >
>> > -config GENERIC_MULDI3
>> > +config GENERIC_LIB_MULDI3
>> >  	bool
>> >
>> > -config GENERIC_CMPDI2
>> > +config GENERIC_LIB_CMPDI2
>> >  	bool
>> >
>> > -config GENERIC_UCMPDI2
>> > +config GENERIC_LIB_UCMPDI2
>> >  	bool
>> > diff --git a/lib/Makefile b/lib/Makefile
>> > index d11c48ec8ffd..7e1ef77e86a3 100644
>> > --- a/lib/Makefile
>> > +++ b/lib/Makefile
>> > @@ -252,9 +252,9 @@ obj-$(CONFIG_SBITMAP) += sbitmap.o
>> >  obj-$(CONFIG_PARMAN) += parman.o
>> >
>> >  # GCC library routines
>> > -obj-$(CONFIG_GENERIC_ASHLDI3) += ashldi3.o
>> > -obj-$(CONFIG_GENERIC_ASHRDI3) += ashrdi3.o
>> > -obj-$(CONFIG_GENERIC_LSHRDI3) += lshrdi3.o
>> > -obj-$(CONFIG_GENERIC_MULDI3) += muldi3.o
>> > -obj-$(CONFIG_GENERIC_CMPDI2) += cmpdi2.o
>> > -obj-$(CONFIG_GENERIC_UCMPDI2) += ucmpdi2.o
>> > +obj-$(CONFIG_GENERIC_LIB_ASHLDI3) += ashldi3.o
>> > +obj-$(CONFIG_GENERIC_LIB_ASHRDI3) += ashrdi3.o
>> > +obj-$(CONFIG_GENERIC_LIB_LSHRDI3) += lshrdi3.o
>> > +obj-$(CONFIG_GENERIC_LIB_MULDI3) += muldi3.o
>> > +obj-$(CONFIG_GENERIC_LIB_CMPDI2) += cmpdi2.o
>> > +obj-$(CONFIG_GENERIC_LIB_UCMPDI2) += ucmpdi2.o
