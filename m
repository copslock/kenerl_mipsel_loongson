Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 04:32:06 +0100 (CET)
Received: from mail-ww0-f49.google.com ([74.125.82.49]:57169 "EHLO
        mail-ww0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491124Ab0CKDcD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 04:32:03 +0100
Received: by wwd20 with SMTP id 20so614877wwd.36
        for <multiple recipients>; Wed, 10 Mar 2010 19:31:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=MtZfKkdDa1tHbl1XPVKTr+Qj+Qz4oZXFnPa1e35nhPw=;
        b=MI+tFtiPHoqaT5h80750Bp7ey/Z3kI0JViwM06CpjR6LKbP3tik3rGK0cxVHEKPzbH
         oevtVHVkq1ZOkqoNUcbeNnFMO9jtBOKyQ/3lEfzTeuthb5Q+2X7SNbKkM8j1a3524AOc
         6127JV+ZJhH+EaGAJXFoZKKolBfxIxGvhE0qc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=oZZRQjs+oyGoL5iMfEG/HJwt5yuMPAeiGsm+pDeZFnkXtYk5BzI/LqtWD5iwDXwbIn
         Sz04EprycB+iGcnf6TrKfQ97D7UVBAr5cZfkZqDazcPPW3+x7bwur8I81CPMYOP5mjgJ
         ZRPUqGyXBiZhkPl14xs2NLcAy0UB/Z0L0k1yw=
Received: by 10.216.88.5 with SMTP id z5mr202177wee.192.1268278317084;
        Wed, 10 Mar 2010 19:31:57 -0800 (PST)
Received: from [202.201.12.142] ([202.201.12.142])
        by mx.google.com with ESMTPS id p37sm24112100gvf.25.2010.03.10.19.31.53
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 10 Mar 2010 19:31:56 -0800 (PST)
Subject: Re: [PATCH v2] Loongson: Lemote-2F: Fixup of _rdmsr and _wrmsr
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
In-Reply-To: <5c63967ed3f891da1f6bc1fc78c272d0407d5d25.1268276186.git.wuzhangjin@gmail.com>
References: <5c63967ed3f891da1f6bc1fc78c272d0407d5d25.1268276186.git.wuzhangjin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Organization: DSLab, Lanzhou University, China
Date:   Thu, 11 Mar 2010 11:25:26 +0800
Message-ID: <1268277926.17798.1.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.2 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26194
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2010-03-11 at 10:57 +0800, Wu Zhangjin wrote:
> From: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> Changes from the old version:
>   o Using raw spinlock instead of spinlock as suggested by David Daney.
[...]
> --- a/arch/mips/pci/ops-loongson2.c
> +++ b/arch/mips/pci/ops-loongson2.c
> @@ -180,15 +180,21 @@ struct pci_ops loongson_pci_ops = {
>  };
>  
>  #ifdef CONFIG_CS5536
> +DEFINE_RAW_SPINLOCK(msr_lock);
> +
>  void _rdmsr(u32 msr, u32 *hi, u32 *lo)
>  {
>  	struct pci_bus bus = {
>  		.number = PCI_BUS_CS5536
>  	};
>  	u32 devfn = PCI_DEVFN(PCI_IDSEL_CS5536, 0);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&msr_lock, flags);

Please ignore this patch for the operations should be raw_ too.

Regards,
	Wu Zhangjin
