Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 23:03:59 +0100 (CET)
Received: from mail-ig0-f182.google.com ([209.85.213.182]:57510 "EHLO
        mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007050AbbBWWD5BAGBz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 23:03:57 +0100
Received: by mail-ig0-f182.google.com with SMTP id h15so22147748igd.3;
        Mon, 23 Feb 2015 14:03:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=8et4rEQTTF7RTWm4xKJAAUw/NAp9ax1CSOprBSrBfiA=;
        b=xE2YLcmwZUwFMNIkgl+PsXM3sUGu+scWLArbulcmFkcBBnlNRisHG/8oGtbHnUNE1v
         Zl5iT2WFO5Mb0SWnZLZt6wDiMrhbuho2lSbwbS0MwAsS3rmNC7l93YLZKkdUsBgmzdZ6
         MFxHG43UNqmD8AfLreL0+GxwyF4ShZY/96t825iRZMtDN6tthzgn3zVeojRM/RE1nH25
         nwIO4LA3gLo1g0hMM2a956gidt7Y4nq6klxNVrdfAPMq/tWZY/4OmkqHMPh+myt+aOiS
         Jud+H+1ECidIKVgmyqu3CPubdGI+zEPv1OKuusiC9FO+OC74eMcBXCR7ICAg8XEq7Pij
         pIYA==
X-Received: by 10.50.222.70 with SMTP id qk6mr15766835igc.47.1424729031209;
        Mon, 23 Feb 2015 14:03:51 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id g71sm14858361ioe.43.2015.02.23.14.03.48
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 23 Feb 2015 14:03:49 -0800 (PST)
Message-ID: <54EBA3C3.30108@gmail.com>
Date:   Mon, 23 Feb 2015 14:03:47 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Subject: Re: [PATCH RFC v2 41/70] MIPS: mm: tlbex: Use cpu_has_mips_r2_exec_hazard
 for the EHB instruction
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com> <1421405389-15512-42-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1421405389-15512-42-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45896
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

On 01/16/2015 02:49 AM, Markos Chandras wrote:
> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>
> MIPS uses the cpu_has_mips_r2_exec_hazard macro to determine whether the
> EHB instruction is available or not. This is necessary for MIPS R6
> which also supports the EHB instruction.
>
> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>

For the version of this patch currently in mips-for-linux-next: NACK

There are two problems:

1) It breaks OCTEON, which will now crash in early boot with:

   Kernel panic - not syncing: No TLB refill handler yet (CPU type: 80)

2) The logic is broken.

The meaning of cpu_has_mips_r2_exec_hazard is that the EHB instruction 
is required.  You change the meaning to be that EHB is part of the ISA.

Can we get this patch reverted from mips-for-linux-next?

David Daney


> ---
>   arch/mips/mm/tlbex.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index ff8d99ce3b9b..d75ff73a2012 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -501,7 +501,7 @@ static void build_tlb_write_entry(u32 **p, struct uasm_label **l,
>   	case tlb_indexed: tlbw = uasm_i_tlbwi; break;
>   	}
>
> -	if (cpu_has_mips_r2) {
> +	if (cpu_has_mips_r2_exec_hazard) {
>   		/*
>   		 * The architecture spec says an ehb is required here,
>   		 * but a number of cores do not have the hazard and
> @@ -1953,7 +1953,7 @@ static void build_r4000_tlb_load_handler(void)
>
>   		switch (current_cpu_type()) {
>   		default:
> -			if (cpu_has_mips_r2) {
> +			if (cpu_has_mips_r2_exec_hazard) {
>   				uasm_i_ehb(&p);
>
>   		case CPU_CAVIUM_OCTEON:
> @@ -2020,7 +2020,7 @@ static void build_r4000_tlb_load_handler(void)
>
>   		switch (current_cpu_type()) {
>   		default:
> -			if (cpu_has_mips_r2) {
> +			if (cpu_has_mips_r2_exec_hazard) {
>   				uasm_i_ehb(&p);
>
>   		case CPU_CAVIUM_OCTEON:
>
