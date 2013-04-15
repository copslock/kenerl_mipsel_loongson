Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Apr 2013 13:27:50 +0200 (CEST)
Received: from mail-la0-f46.google.com ([209.85.215.46]:49902 "EHLO
        mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834877Ab3DOL1tnCMyl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Apr 2013 13:27:49 +0200
Received: by mail-la0-f46.google.com with SMTP id ea20so4159728lab.5
        for <linux-mips@linux-mips.org>; Mon, 15 Apr 2013 04:27:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=fZhespGnAIwluCUz06C2YRIotM9e+WeygBkk+BlyAcI=;
        b=nGIkLDuUkV5qqWR1V3F27VtPcFIrIsh0WF+oLKOuR4G2ilDbcmhgPSAXWJIGzZbYjQ
         eceiGwnx8VJV2b4TB5VANOsCAxc6zgizS2q1O6NF/uiAFKZOfHPcNuDkB97q0oxlpLwA
         RjflInCE+/56WE66uY3LZKWQ9lAFic91aTwdsANT5etN7lVLEjNzboC/5CcIMwRAKhjY
         bv21UdYSAuLbslnZD+QgfSaLHsZbT4wpNK+7sS+D9RWyu0OwT8JlZ3WWwmCWlO4jxouI
         5KYcJtILVbNhuxqpQT8M3MddezwFdz+TWFq11q3ebVy/mx1UE09+iToUl6mRJiHO8RkI
         8EZg==
X-Received: by 10.112.74.98 with SMTP id s2mr10271171lbv.9.1366025264125;
        Mon, 15 Apr 2013 04:27:44 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-88-234.pppoe.mtu-net.ru. [91.79.88.234])
        by mx.google.com with ESMTPS id x9sm7703553lbi.15.2013.04.15.04.27.41
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Mon, 15 Apr 2013 04:27:42 -0700 (PDT)
Message-ID: <516BE3EF.1020108@cogentembedded.com>
Date:   Mon, 15 Apr 2013 15:26:39 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] MIPS: add detect_memory_region()
References: <1366022494-8355-1-git-send-email-blogic@openwrt.org>
In-Reply-To: <1366022494-8355-1-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQnh69DClj7tMTtvJxoX2bkuK0VeU5tFXe7SGS6Fz/7rPZGkdp/ImDgZsAmW38GhPO1KudVj
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36179
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 15-04-2013 14:41, John Crispin wrote:

> Add a generic way of detecting the available RAM. This function is based on the
> implementation already used by ath79.

> Signed-off-by: John Crispin <blogic@openwrt.org>
[...]

> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4c774d5..dfe776a 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
[...]
> @@ -122,6 +123,25 @@ void __init add_memory_region(phys_t start, phys_t size, long type)
>   	boot_mem_map.nr_map++;
>   }
>
> +void __init detect_memory_region(phys_t start, phys_t sz_min,  phys_t sz_max)

    Minor formatting nit: too many spaces after the last comma.

WBR, Sergei
