Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Nov 2014 17:42:46 +0100 (CET)
Received: from mail-ig0-f177.google.com ([209.85.213.177]:55610 "EHLO
        mail-ig0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011908AbaKJQmoQBQ2G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Nov 2014 17:42:44 +0100
Received: by mail-ig0-f177.google.com with SMTP id hl2so9410598igb.16
        for <linux-mips@linux-mips.org>; Mon, 10 Nov 2014 08:42:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=f5EG/EozXCBA0DADVnr8YT8xPDOkMCNNS+YShdOJbHo=;
        b=XIu8KqEIaf3emt9ZcoN6Eu1O6bvuoPUEfHp7bG3ns8I/9VXp3hNapxoLnt6SKvEAwu
         iAwgXBDj7uNiN5r7H3HN8KUEwDLigb6duA0fTi7x6Hg2DEnVZifg510Qn90YKaAAtJiM
         Xni1IdoZ4/H67AziHXh1f+yYmvLjHM5qCd6weK8TtHZtCBpXd02aMNzaOgpl8qJbvYEg
         6C8YazJCqympVlx+lZL+LgFe7jVRJxnANS/AYNCOLKoRgicSfY2cy1bkexqj/pzFjQa8
         vsz7h4myCEsjRdyTzgG2T1+0ucEiKmF3kTRGhIsZoe7oBrnIMxT0QduEZsgvj7FWtg/G
         RN8Q==
X-Received: by 10.42.74.136 with SMTP id w8mr37166220icj.11.1415637758189;
        Mon, 10 Nov 2014 08:42:38 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id au2sm4969608igc.4.2014.11.10.08.42.37
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 10 Nov 2014 08:42:37 -0800 (PST)
Message-ID: <5460EAFC.8020004@gmail.com>
Date:   Mon, 10 Nov 2014 08:42:36 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: kernel: traps: Replace printk with pr_info
 for MC exceptions
References: <1415636404-11979-1-git-send-email-markos.chandras@imgtec.com> <1415636404-11979-2-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1415636404-11979-2-git-send-email-markos.chandras@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43960
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

On 11/10/2014 08:20 AM, Markos Chandras wrote:
> printk should not be used without a KERN_ facility level
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>   arch/mips/kernel/traps.c | 12 ++++++------
>   1 file changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index 22b19c275044..51fa5c3aa4fe 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1380,12 +1380,12 @@ asmlinkage void do_mcheck(struct pt_regs *regs)
>   	show_regs(regs);
>
>   	if (multi_match) {
> -		printk("Index	: %0x\n", read_c0_index());
> -		printk("Pagemask: %0x\n", read_c0_pagemask());
> -		printk("EntryHi : %0*lx\n", field, read_c0_entryhi());
> -		printk("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
> -		printk("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
> -		printk("\n");
> +		pr_info("Index	: %0x\n", read_c0_index());
> +		pr_info("Pagemask: %0x\n", read_c0_pagemask());
> +		pr_info("EntryHi : %0*lx\n", field, read_c0_entryhi());
> +		pr_info("EntryLo0: %0*lx\n", field, read_c0_entrylo0());
> +		pr_info("EntryLo1: %0*lx\n", field, read_c0_entrylo1());
> +		pr_info("\n");

MachineCheck is a serious problem, If we change this at all, I would 
suggest pr_err() instead.

David Daney

>   		dump_tlb_all();
>   	}
>
>
