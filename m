Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2012 16:56:25 +0200 (CEST)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:47459 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903650Ab2CZO4Q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2012 16:56:16 +0200
Received: by bkcjk13 with SMTP id jk13so5316537bkc.36
        for <linux-mips@linux-mips.org>; Mon, 26 Mar 2012 07:56:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=LFEFTNnQVCJISqpum8ZY2UmqbHmbxq2HG83wk6ppitQ=;
        b=FuVlt5SqY10i/LzjxnAaDb0jq1Rq9L4/pisF02r/s5G19tU2YX17LcXrOI4bXgxWQ9
         EoJn1HrxMtUqcALE9slUq4G2e+T4nxB0SP3U7a1ldZJxbWIh/pbwUSMEp7dDRx1M9Ox+
         9YZIcOH+ndI36zqSH/BTy1xJwM040yfwyNw/V2Nrp/j8HnSXCBF7U74qVyjF1RpD940M
         lTYc30NGmT4+HkMjSLMvwKUT9MzhPs+2vCiAKTBtJhz3bo3YKbrBq9vvNGWECRqD748P
         6T4AzMNwzXuPDv3Itu+9IljYwNwYY0MSnE6wEpOfb3EfPSbQOQu3unWCn7Vjl0YanTJP
         3lAg==
Received: by 10.205.138.9 with SMTP id iq9mr8341377bkc.139.1332773770963;
        Mon, 26 Mar 2012 07:56:10 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id z17sm24537879bkw.12.2012.03.26.07.56.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 26 Mar 2012 07:56:09 -0700 (PDT)
Message-ID: <4F70834E.3000308@mvista.com>
Date:   Mon, 26 Mar 2012 18:55:10 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120312 Thunderbird/11.0
MIME-Version: 1.0
To:     Paul Gortmaker <paul.gortmaker@gmail.com>
CC:     klassert@mathematik.tu-chemnitz.de, netdev@vger.kernel.org,
        linux-mips@linux-mips.org,
        Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] netdev: fix compile issues for !CONFIG_PCI in 3c59x
References: <1332724306-8799-1-git-send-email-paul.gortmaker@windriver.com> <CAP=VYLpOJOueFfzxFGCu5cKQ9--F8CqC5JWjBxej7u=8z3K0xQ@mail.gmail.com>
In-Reply-To: <CAP=VYLpOJOueFfzxFGCu5cKQ9--F8CqC5JWjBxej7u=8z3K0xQ@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQmmf/zSNyJqe6YoL8dvgkAZBmozVc80DsUFrxL+/56RzLK2ArnizdkPBjEfuqrREU5VcKYb
X-archive-position: 32752
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 03/26/2012 05:38 PM, Paul Gortmaker wrote:

>> I hate to add in more #ifdef CONFIG_PCI but there are already
>> quite a few in this driver, and it seems like it hasn't been
>> built with CONFIG_PCI set to off in quite some time.

> Actually, please scrap this patch.  The uglyness of more ifdefs
> made me look at it again.  It should be do-able in a cleaner way
> with stubs, and it appears this may even be similar to an old fail
> from the past:

> http://lkml.indiana.edu/hypermail/linux/kernel/1107.3/00109.html

    Also, see this patch:

http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0da0ead90122578ef6e4afba9ba4bcd3455fd8e8

    The driver patch this was done for is still in the -mm tree after all these 
years.:-)

> I'll dig into it some more and follow up.

    I thought I addressed all issues with compilation of this driver with 
CONFIG_PCI=n. Apparently not, and some seem to have accumulated over time...

> Thanks,
> Paul.

WBR, Sergei
