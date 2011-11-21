Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Nov 2011 20:26:04 +0100 (CET)
Received: from mail-gx0-f177.google.com ([209.85.161.177]:45706 "EHLO
        mail-gx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903796Ab1KUTZ4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Nov 2011 20:25:56 +0100
Received: by ggki1 with SMTP id i1so2007804ggk.36
        for <multiple recipients>; Mon, 21 Nov 2011 11:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ponTTO+wZvcKPS31iBFPz3DXm2cDH6IuD0Xi3kE7ynI=;
        b=ttJ0VwFP+eKJFhJnEJaAIJDa533GnAd6oM8OA09uWDo0maSQgeIZGTj3+m6tm6ajhz
         L5yOOJwmbFBK25G49SW+mZZJAD+Olse4yzZbEeHLjFgaZidB5+fn1DYWzLnL+K69kEse
         tNPa89sriR8PDjThIoPkbGUEyWhbscTqD9aq4=
Received: by 10.236.154.166 with SMTP id h26mr21643722yhk.88.1321903550231;
        Mon, 21 Nov 2011 11:25:50 -0800 (PST)
Received: from dd1.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id 22sm31881863anp.12.2011.11.21.11.25.48
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Nov 2011 11:25:49 -0800 (PST)
Message-ID: <4ECAA5B8.3080908@gmail.com>
Date:   Mon, 21 Nov 2011 11:25:44 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Hillf Danton <dhillf@gmail.com>
CC:     David Rientjes <rientjes@google.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch] mips, mm: avoid using HPAGE constants without CONFIG_HUGETLB_PAGE
References: <alpine.DEB.2.00.1111191855410.5457@chino.kir.corp.google.com> <CAJd=RBBmODwpUi1_eObE47yCQVfEGLHyy45=aqUtxM-9Bpki6A@mail.gmail.com>
In-Reply-To: <CAJd=RBBmODwpUi1_eObE47yCQVfEGLHyy45=aqUtxM-9Bpki6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 31896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 17696

On 11/19/2011 09:27 PM, Hillf Danton wrote:
[...]
>
> --- a/arch/mips/include/asm/page.h	Sun Nov 20 13:08:44 2011
> +++ b/arch/mips/include/asm/page.h	Sun Nov 20 13:17:43 2011
> @@ -38,6 +38,11 @@
>   #define HPAGE_SIZE	(_AC(1,UL)<<  HPAGE_SHIFT)
>   #define HPAGE_MASK	(~(HPAGE_SIZE - 1))
>   #define HUGETLB_PAGE_ORDER	(HPAGE_SHIFT - PAGE_SHIFT)
> +#else
> +#define HPAGE_SHIFT	({ BUG(); 0; })
> +#define HPAGE_SIZE	({ BUG(); 0; })
> +#define HPAGE_MASK	({ BUG(); 0; })

These three are taken care of in linux/hugetlb.h by the patches that 
Andrew Morton has in his tree, the full discussion starts at:

http://www.linux-mips.org/archives/linux-mips/2011-11/msg00412.html

> +#define HUGETLB_PAGE_ORDER	({ BUG(); 0; })

This value doesn't appear to be necessary at this point.

David Daney
