Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Mar 2012 17:38:52 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:49829 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903553Ab2CZPir (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Mar 2012 17:38:47 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca [147.11.189.40])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id q2QFcYt0026217
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 26 Mar 2012 08:38:34 -0700 (PDT)
Received: from [128.224.146.65] (128.224.146.65) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server id 14.1.255.0; Mon, 26 Mar 2012
 08:38:35 -0700
Message-ID: <4F708D78.2040102@windriver.com>
Date:   Mon, 26 Mar 2012 11:38:32 -0400
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.27) Gecko/20120216 Thunderbird/3.1.19
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Randy Dunlap <rdunlap@xenotime.net>
CC:     Paul Gortmaker <paul.gortmaker@gmail.com>,
        <klassert@mathematik.tu-chemnitz.de>, <netdev@vger.kernel.org>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH] netdev: fix compile issues for !CONFIG_PCI in 3c59x
References: <1332724306-8799-1-git-send-email-paul.gortmaker@windriver.com> <CAP=VYLpOJOueFfzxFGCu5cKQ9--F8CqC5JWjBxej7u=8z3K0xQ@mail.gmail.com> <4F70834E.3000308@mvista.com>
In-Reply-To: <4F70834E.3000308@mvista.com>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.146.65]
X-archive-position: 32753
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 12-03-26 10:55 AM, Sergei Shtylyov wrote:
> Hello.
> 
> On 03/26/2012 05:38 PM, Paul Gortmaker wrote:
> 
>>> I hate to add in more #ifdef CONFIG_PCI but there are already
>>> quite a few in this driver, and it seems like it hasn't been
>>> built with CONFIG_PCI set to off in quite some time.
> 
>> Actually, please scrap this patch.  The uglyness of more ifdefs
>> made me look at it again.  It should be do-able in a cleaner way
>> with stubs, and it appears this may even be similar to an old fail
>> from the past:
> 
>> http://lkml.indiana.edu/hypermail/linux/kernel/1107.3/00109.html
> 
>     Also, see this patch:
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=0da0ead90122578ef6e4afba9ba4bcd3455fd8e8
> 
>     The driver patch this was done for is still in the -mm tree after all these 
> years.:-)
> 
>> I'll dig into it some more and follow up.
> 
>     I thought I addressed all issues with compilation of this driver with 
> CONFIG_PCI=n. Apparently not, and some seem to have accumulated over time...

I got sidetracked working on other things, but I did manage to
learn this so far - It turns out that Randy fixed it and then
James un-fixed it in this commit:

commit 97a29d59fc222b36bac3ee3a8ae994f65bf7ffdf
Author: James Bottomley <James.Bottomley@HansenPartnership.com>
Date:   Mon Jan 30 10:40:47 2012 -0600

    [PARISC] fix compile break caused by iomap: make IOPORT/PCI mapping functions conditional

Reverting the above and mips builds 3c59x just fine.  Note that MIPS
allmodconfig does not have either CONFIG_GENERIC_IOMAP or the other
CONFIG_GENERIC_PCI_IOMAP options.

Paul.
--

> 
>> Thanks,
>> Paul.
> 
> WBR, Sergei
