Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 19:57:49 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5654 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903564Ab2EUR5l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 19:57:41 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4fba821c0000>; Mon, 21 May 2012 10:57:53 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 21 May 2012 10:55:54 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 21 May 2012 10:55:54 -0700
Message-ID: <4FBA81AA.9090801@cavium.com>
Date:   Mon, 21 May 2012 10:55:54 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH v3,2/9] MIPS: Optimise core library functions for microMIPS.
References: <1337615935-30482-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1337615935-30482-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 May 2012 17:55:54.0730 (UTC) FILETIME=[F7D854A0:01CD377A]
X-archive-position: 33406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

[...]
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -45,6 +45,12 @@
>   #define HUGETLB_PAGE_ORDER	({BUILD_BUG(); 0; })
>   #endif /* CONFIG_HUGETLB_PAGE */
>
> +/*
> + * Clear and copy array sizes for micro-assembly of clear_page/copy_page.
> + */
> +#define CLEAR_PAGE_ARRAY_SIZE	288
> +#define COPY_PAGE_ARRAY_SIZE	1344
> +

This is not so clean.  page.h really shouldn't have things like this.

Just put a label at the beginning and end of the code and have the 
compiler calculate the size from the difference.

David Daney
