Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 09:20:05 +0100 (CET)
Received: from mail-bw0-f219.google.com ([209.85.218.219]:48435 "EHLO
        mail-bw0-f219.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491020Ab0CCIT7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 09:19:59 +0100
Received: by bwz19 with SMTP id 19so1021654bwz.26
        for <multiple recipients>; Wed, 03 Mar 2010 00:19:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:organization:to
         :subject:date:user-agent:cc:references:in-reply-to:mime-version
         :content-type:content-transfer-encoding:message-id;
        bh=kr9uGS0MAVwzwYAwm0iw6w9wM1ehG4UlOvA6gWqUcUM=;
        b=FmmE9SIC7noNb+GYpANFKy0LsO2hqdRPanM6IwbhAd0wMvKJyv0JCC4nqHhd/RLPnU
         zHPWXAla4D6BYHJrzfgGTwaKWtVz/rHkN3UK9Im3G6SDrTButRZ6IYsXaqAHgor10JHl
         wYxnGSsdUtdrbhHsbw0JoiI1rE39cTSHfwqzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        b=x4+HVHq6xRHXn7CSgnWMkvElIuxYVl/QDQI2P0QLZimfIROrWHj2OVCxMinMfW1Vu/
         eHl4saYraJnYjehW7hxAAQ3ssbiOH28auKNqJUcs7dzOqH8fx7Ef+3O0YqyPC6AGxdF+
         pO7RxU2CUtKoCV45oPcgnd731WvUlbRPuBssg=
Received: by 10.204.144.78 with SMTP id y14mr5653639bku.194.1267604393186;
        Wed, 03 Mar 2010 00:19:53 -0800 (PST)
Received: from flexo.localnet (bobafett.staff.proxad.net [213.228.1.121])
        by mx.google.com with ESMTPS id x16sm816522bku.17.2010.03.03.00.19.52
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 03 Mar 2010 00:19:52 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Yang Shi <yang.shi@windriver.com>
Subject: Re: [PATCH 3/3] MIPS: Octeon: Add add_wired_entry decralation in header file
Date:   Wed, 3 Mar 2010 09:19:35 +0100
User-Agent: KMail/1.12.2 (Linux/2.6.31-17-server; KDE/4.3.2; x86_64; ; )
Cc:     ddaney@caviumnetworks.com, ralf@linux-mips.org,
        linux-mips@linux-mips.org
References: <1267601172-17919-1-git-send-email-yang.shi@windriver.com> <3118b3d0f3ed042df1ee2771325c3824e6fc7ba9.1267600234.git.yang.shi@windriver.com> <9e4e80f8edd43f8a164fe618c978c1dc8cd48a69.1267600234.git.yang.shi@windriver.com>
In-Reply-To: <9e4e80f8edd43f8a164fe618c978c1dc8cd48a69.1267600234.git.yang.shi@windriver.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <201003030919.36006.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Yang,

On Wednesday 03 March 2010 08:26:12 Yang Shi wrote:
> Octeon's setup.c uses add_wired_entry, but it is not declared
> anywhere. Copy add_wired_entry decralation fomr pgtable-32.h to
> pgtable-64.h and include asm/pgtable.h into Octeon's setup.c.
> 
> Signed-off-by: Yang Shi <yang.shi@windriver.com>
> ---
>  arch/mips/cavium-octeon/setup.c    |    1 +
>  arch/mips/include/asm/pgtable-64.h |    6 ++++++
>  2 files changed, 7 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/cavium-octeon/setup.c
>  b/arch/mips/cavium-octeon/setup.c index 8309d68..f35ba16 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -30,6 +30,7 @@
>  #include <asm/bootinfo.h>
>  #include <asm/sections.h>
>  #include <asm/time.h>
> +#include <asm/pagtable.h>

You probably meant to include <asm/pgtable.h> instead.

> 
>  #include <asm/octeon/octeon.h>
> 
> diff --git a/arch/mips/include/asm/pgtable-64.h
>  b/arch/mips/include/asm/pgtable-64.h index 26dc69d..85ee34d 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -23,6 +23,12 @@
>  #endif
> 
>  /*
> + * - add_wired_entry() add a fixed TLB entry, and move wired register
> + */
> +extern void add_wired_entry(unsigned long entrylo0, unsigned long
>  entrylo1, +			       unsigned long entryhi, unsigned long pagemask);
> +
> +/*
>   * Each address space has 2 4K pages as its page directory, giving 1024
>   * (== PTRS_PER_PGD) 8 byte pointers to pmd tables. Each pmd table is a
>   * single 4K page, giving 512 (== PTRS_PER_PMD) 8 byte pointers to page
> 

-- 
Regards, Florian
