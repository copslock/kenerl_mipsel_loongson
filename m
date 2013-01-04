Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jan 2013 19:14:26 +0100 (CET)
Received: from mail-da0-f50.google.com ([209.85.210.50]:53360 "EHLO
        mail-da0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816521Ab3ADSOZq3gtN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jan 2013 19:14:25 +0100
Received: by mail-da0-f50.google.com with SMTP id h15so7626689dan.9
        for <multiple recipients>; Fri, 04 Jan 2013 10:14:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:message-id:date:from:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=2wvmZ8TQzoebBFkKr93wPyWHqgIwGcFwipYnbXi6YxI=;
        b=l0JZDLBmAz293hEWXdN7kNG/Cv1XK4kkBFmqJ1RfRc+SV1CMWz4AA9IqyvfX7MDrrb
         ALMvHsoTglydn+E3xJGmcwI6HfwUL0n0YgLt/htqyax4A9dOgq6GL1tmVMLBWQdFJq19
         6puXRNCp/jot6T04CGTrzHvejp/lS7kULp5lKQsHZHBk+4pe6Bw70k9jiS95JXnSRgfP
         GmqVAayA+ZuHl816tgqDEkUOOUr3FCRJl+ac0gz60dT2yH+u33hsJqcmRgSRPeNEDI8C
         EGFPbMMcyak5llKRxphlRorshsqN/uSIBHpmKnK8pXvXnpx5B69nCUJ6EEtcZnDz7Ajt
         kgOQ==
X-Received: by 10.66.86.71 with SMTP id n7mr156601970paz.77.1357323258764;
        Fri, 04 Jan 2013 10:14:18 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id m3sm33581884pav.4.2013.01.04.10.14.17
        (version=SSLv3 cipher=OTHER);
        Fri, 04 Jan 2013 10:14:17 -0800 (PST)
Message-ID: <50E71BF8.3050308@gmail.com>
Date:   Fri, 04 Jan 2013 10:14:16 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     "Steven J. Hill" <sjhill@mips.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        jchandra@broadcom.com
Subject: Re: [PATCH v3] MIPS: Optimise TLB handlers for MIPS32/64 R2 cores.
References: <1357322355-31622-1-git-send-email-sjhill@mips.com>
In-Reply-To: <1357322355-31622-1-git-send-email-sjhill@mips.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 35369
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/04/2013 09:59 AM, Steven J. Hill wrote:
> From: "Steven J. Hill" <sjhill@mips.com>
>
> The EXT and INS instructions can be used to decrease code size and
> thus speed up TLB handlers on MIPS32R2 and MIPS64R2 cores.
>
> Signed-off-by: Steven J. Hill <sjhill@mips.com>
[...]
> +#ifdef CONFIG_64BIT
> +			(PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1));
> +#else
> +			(PGDIR_SHIFT - PAGE_SHIFT - 1));
> +#endif
> +		UASM_i_INS(p, ptr, tmp, (PTE_T_LOG2 + 1),



As far as I can tell, (PAGE_SHIFT - PTE_ORDER - PTE_T_LOG2 - 1) and 
(PGDIR_SHIFT - PAGE_SHIFT - 1) are the same thing.  So why the two cases?

Can you give an example of where they might differ?

David Daney
