Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Nov 2013 21:10:35 +0100 (CET)
Received: from mail-ie0-f170.google.com ([209.85.223.170]:50306 "EHLO
        mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827340Ab3KKUKdkR2m8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Nov 2013 21:10:33 +0100
Received: by mail-ie0-f170.google.com with SMTP id to1so3202669ieb.15
        for <linux-mips@linux-mips.org>; Mon, 11 Nov 2013 12:10:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=bzlfBUjRQ8uuJjKVqw+pWiQSiBkckVEQt4es6xqAztg=;
        b=gJDvtUK8D5RnA5WW47ixzCWwAixmZqJfXzopNkkUZnAPEp5MYPaL6VT5Ev41XsJd4j
         4BCGlkruqlXoVBpNiWubRfDH56c8PfIDjCP0aWWf8jUdVIoHZjZ8OmltCp54yR54/TJE
         BdcLFOzvJtC700I5qYZWeetpx+SmC/8plS46SeHVWaNZpzbSW45QkuLjAp7n/DrJqHW6
         fOTYmZu1qzu/catsHE4iFDDODyVymUSc41Xs2VAYAO/xKsV03pXyGWv8Z31kOJqiAGYf
         CYt/bjvk0An834oKIunT6SeHTVS5SbAmmiX0hhvC3v0p40KdbAHcajAxlsFilrXAmJfd
         qg8Q==
X-Received: by 10.50.8.102 with SMTP id q6mr13502094iga.57.1384200627795;
        Mon, 11 Nov 2013 12:10:27 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id y10sm20442778igl.4.2013.11.11.12.10.26
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 11 Nov 2013 12:10:27 -0800 (PST)
Message-ID: <528139B1.9010909@gmail.com>
Date:   Mon, 11 Nov 2013 12:10:25 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH 4/6] MIPS: mm: Use the TLBINVF instruction to flush the
 VTLB
References: <1383844120-29601-1-git-send-email-markos.chandras@imgtec.com> <1383844120-29601-5-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1383844120-29601-5-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38501
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

On 11/07/2013 09:08 AM, Markos Chandras wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> The TLBINVF instruction can be used to flush the entire VTLB.
> This eliminates the need for the TLBWI loop and improves performance.
>
> Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>


This should be split into two patches.  One for each file.

Also...

> ---
>   arch/mips/include/asm/mipsregs.h | 13 +++++++++++++
>   arch/mips/mm/tlb-r4k.c           | 18 ++++++++++++------
>   2 files changed, 25 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index 412fe99..9cd0e13 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -685,6 +685,19 @@ static inline int mm_insn_16bit(u16 insn)
>   }
>
>   /*
> + * TLB Invalidate Flush
> + */
> +static inline void tlbinvf(void)
> +{
> +	__asm__ __volatile__(
> +		".set push\n\t"
> +		".set noreorder\n\t"

... Why do you need noreorder here?

> +		".word 0x42000004\n\t" /* tlbinvf */
> +		".set pop");
> +}
> +
> +
> +/*
>    * Functions to access the R10000 performance counters.	 These are basically
>    * mfc0 and mtc0 instructions from and to coprocessor register with a 5-bit
>    * performance counter number encoded into bits 1 ... 5 of the instruction.
> diff --git a/arch/mips/mm/tlb-r4k.c b/arch/mips/mm/tlb-r4k.c
> index 363aa03..427dcac 100644
> --- a/arch/mips/mm/tlb-r4k.c
> +++ b/arch/mips/mm/tlb-r4k.c
> @@ -83,13 +83,19 @@ void local_flush_tlb_all(void)
>   	entry = read_c0_wired();
>
>   	/* Blast 'em all away. */
> -	while (entry < current_cpu_data.tlbsize) {
> -		/* Make sure all entries differ. */
> -		write_c0_entryhi(UNIQUE_ENTRYHI(entry));
> -		write_c0_index(entry);
> +	if (cpu_has_tlbinv && current_cpu_data.tlbsize) {
> +		write_c0_index(0);
>   		mtc0_tlbw_hazard();
> -		tlb_write_indexed();
> -		entry++;
> +		tlbinvf();  /* invalidate VTLB */
> +	} else {
> +		while (entry < current_cpu_data.tlbsize) {
> +			/* Make sure all entries differ. */
> +			write_c0_entryhi(UNIQUE_ENTRYHI(entry));
> +			write_c0_index(entry);
> +			mtc0_tlbw_hazard();
> +			tlb_write_indexed();
> +			entry++;
> +		}
>   	}
>   	tlbw_use_hazard();
>   	write_c0_entryhi(old_ctx);
>
