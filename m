Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 19:24:56 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19276 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491194Ab0CCSYw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Mar 2010 19:24:52 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b8ea97b0000>; Wed, 03 Mar 2010 10:24:59 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 10:24:16 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 3 Mar 2010 10:24:16 -0800
Message-ID: <4B8EA94B.1020203@caviumnetworks.com>
Date:   Wed, 03 Mar 2010 10:24:11 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100225 Fedora/3.0.2-1.fc12 Thunderbird/3.0.2
MIME-Version: 1.0
To:     Yang Shi <yang.shi@windriver.com>
CC:     ralf@linux-mips.org, f.fainelli@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 3/3] MIPS: Octeon: Add add_wired_entry decralation in
 header file
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com> <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com> <50e36e8549769a26986f99a23772d23fd039c230.1267604875.git.yang.shi@windriver.com> <004eb64c73b3bcec90612663598ada4cf678f236.1267604875.git.yang.shi@windriver.com>
In-Reply-To: <004eb64c73b3bcec90612663598ada4cf678f236.1267604875.git.yang.shi@windriver.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Mar 2010 18:24:16.0388 (UTC) FILETIME=[BB833C40:01CABAFE]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/03/2010 12:43 AM, Yang Shi wrote:
> Octeon's setup.c uses add_wired_entry, but it is not declared
> anywhere. Copy add_wired_entry decralation from pgtable-32.h to
> pgtable-64.h and include asm/pgtable.h into Octeon's setup.c.
>
> Signed-off-by: Yang Shi<yang.shi@windriver.com>

NAK!

We are removing the use of add_wired_entry(), so adding a declaration 
will not be necessary.

David Daney


> ---
>   arch/mips/cavium-octeon/setup.c    |    1 +
>   arch/mips/include/asm/pgtable-64.h |    6 ++++++
>   2 files changed, 7 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index 8309d68..d63b8e6 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -30,6 +30,7 @@
>   #include<asm/bootinfo.h>
>   #include<asm/sections.h>
>   #include<asm/time.h>
> +#include<asm/pgtable.h>
>
>   #include<asm/octeon/octeon.h>
>
> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/pgtable-64.h
> index 26dc69d..85ee34d 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -23,6 +23,12 @@
>   #endif
>
>   /*
> + * - add_wired_entry() add a fixed TLB entry, and move wired register
> + */
> +extern void add_wired_entry(unsigned long entrylo0, unsigned long entrylo1,
> +			       unsigned long entryhi, unsigned long pagemask);
> +
> +/*
>    * Each address space has 2 4K pages as its page directory, giving 1024
>    * (== PTRS_PER_PGD) 8 byte pointers to pmd tables. Each pmd table is a
>    * single 4K page, giving 512 (== PTRS_PER_PMD) 8 byte pointers to page
