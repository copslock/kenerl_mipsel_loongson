Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jun 2013 01:34:26 +0200 (CEST)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:55405 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6834832Ab3FGXeZlHxeR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Jun 2013 01:34:25 +0200
Received: by mail-lb0-f180.google.com with SMTP id o10so2402096lbi.39
        for <linux-mips@linux-mips.org>; Fri, 07 Jun 2013 16:34:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=rGwz3cxt66WeNWW0VdfprEJawjRH0xSDWRH9oOIiCXQ=;
        b=cBegg25gAXUh87TMTpejYnBOuHsDW640sNJMOHYMZ4KLfg6qFau+tlAamug6W/BY9Y
         0CNR82qcVT6FEaM+eUoJdrRQ09vokVpSQjqtjkB//KMeBt+nepczelaA6k9Yzj1/sYXE
         b8aFQwOqZzIKeC6GrlgPcXol5DcJDucXhupZkXrT8I3DPoQCv+C9Fbhy3aVmy16e9qBC
         14ckxH0VGS4ZLtS8kDJe24WNpbwwaalbqcMBLfLnAgapkTG9MMzhlQr8CA7FbU+YF46g
         iqYpwP88s5rpjyk+5eYLUplAKh4kxPKA3f6zigU5VttFP9CZqWww7AUPW1H+5U3mSHfA
         BaoA==
X-Received: by 10.152.5.234 with SMTP id v10mr404020lav.52.1370648059869;
        Fri, 07 Jun 2013 16:34:19 -0700 (PDT)
Received: from wasted.dev.rtsoft.ru (ppp91-76-150-46.pppoe.mtu-net.ru. [91.76.150.46])
        by mx.google.com with ESMTPSA id 4sm320725lai.4.2013.06.07.16.34.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 07 Jun 2013 16:34:18 -0700 (PDT)
Message-ID: <51B26E02.8070802@cogentembedded.com>
Date:   Sat, 08 Jun 2013 03:34:26 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130509 Thunderbird/17.0.6
MIME-Version: 1.0
To:     David Daney <ddaney.cavm@gmail.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        kvm@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 20/31] mips/kvm: Hook into TLB fault handlers.
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com> <1370646215-6543-21-git-send-email-ddaney.cavm@gmail.com>
In-Reply-To: <1370646215-6543-21-git-send-email-ddaney.cavm@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQlVEVS5T5V66s3aT7CVqy9t/2z+CAmJREGKRvb/PEeF6RH6b1yNGDyT3FLZSgXvAnKeNF9f
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36750
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

On 06/08/2013 03:03 AM, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
>
> If the CPU is operating in guest mode when a TLB related excpetion
> occurs, give KVM a chance to do emulation.
>
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>   arch/mips/mm/fault.c       | 8 ++++++++
>   arch/mips/mm/tlbex-fault.S | 6 ++++++
>   2 files changed, 14 insertions(+)
>
> diff --git a/arch/mips/mm/fault.c b/arch/mips/mm/fault.c
> index 0fead53..9391da49 100644
> --- a/arch/mips/mm/fault.c
> +++ b/arch/mips/mm/fault.c
[...]
> @@ -50,6 +51,13 @@ asmlinkage void __kprobes do_page_fault(struct pt_regs *regs, unsigned long writ
>   	       field, regs->cp0_epc);
>   #endif
>   
> +#ifdef CONFIG_KVM_MIPSVZ
> +	if (test_tsk_thread_flag(current, TIF_GUESTMODE)) {
> +		if (mipsvz_page_fault(regs, write, address))

    Any reason not to collapse these into single *if*?

> +			return;
> +	}
> +#endif
> +
>
