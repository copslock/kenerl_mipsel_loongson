Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 05 Jun 2010 03:22:51 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:51886 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492103Ab0FEBWr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 5 Jun 2010 03:22:47 +0200
Received: by iwn34 with SMTP id 34so1880683iwn.36
        for <linux-mips@linux-mips.org>; Fri, 04 Jun 2010 18:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=Dph68Bzw3915xsYgLkppNZJhN5uU9pmxAbTe7dMJobQ=;
        b=sdO6/JgAaHQt2YidfvG7y+NlsPSQXN+YBuEgCJLNP61NQiT4A+S4ixysnGKLzHvVHJ
         7aBmZ3bkftz37f684fv5Gb2g+tYopl+i82cGdIJ5kS65jG3vEQOQgv/fxSL+tnWoDTr0
         EZ+tEr2+rW3iIu+EOJs7jvTeWQfuYncG+bkkM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=pzQgC7f+7yeCTqICTksUBC8cKYauKq2NCzswO0KLVHzVRAPmhXU1+aRmH9LbxVJdQQ
         pzM2yCOZTd6lOmKtH+75/EC+WvGTSj5elcGCsP5kt+clIZYTj+qhouCytHflH3gZlFo/
         yVmxnlymNYfY/Rr4Y1tlVds3e+jRg2VdCmY+Q=
Received: by 10.231.213.27 with SMTP id gu27mr1617614ibb.168.1275700963890;
        Fri, 04 Jun 2010 18:22:43 -0700 (PDT)
Received: from [192.168.50.141] ([12.169.7.247])
        by mx.google.com with ESMTPS id b3sm7911086ibf.1.2010.06.04.18.22.41
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 04 Jun 2010 18:22:42 -0700 (PDT)
Message-ID: <4C09A6DE.7010303@gmail.com>
Date:   Fri, 04 Jun 2010 20:22:38 -0500
From:   Ray Dudu <raydudu@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.1.9) Gecko/20100429 Lightning/1.0b2pre Thunderbird/3.0.4
MIME-Version: 1.0
To:     Deng-Cheng Zhu <dengcheng.zhu@gmail.com>
CC:     linux-mips@linux-mips.org
Subject: Re: [Q] MIPS: How to record the user stack backtrace in the kernel
References: <AANLkTikRaw_OLR7LenUA8acaedJy2V6HZKJ0cAd6PNRk@mail.gmail.com>
In-Reply-To: <AANLkTikRaw_OLR7LenUA8acaedJy2V6HZKJ0cAd6PNRk@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 27073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raydudu@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 3634

Hi,

I'm looking for the same thing, please comment it.

04.06.10 17:22, Deng-Cheng Zhu написав(ла):
> Hi, developers
> 
> 
> In the kernel, we don't have frame unwinder to work on the user stack.
> Given the different possible compiler flags, getting the backtrace for the
> user stack is especially challenging. Certainly, I don't want symbols -
> only to get a list of return addresses. Do you have any comments?
> 
> 
> Thanks!
> 
> Deng-Cheng
> 

-- 
Best regards,
RD18-UANIC
