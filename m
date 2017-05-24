Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 May 2017 20:26:14 +0200 (CEST)
Received: from bombadil.infradead.org ([65.50.211.133]:52857 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994780AbdEXS0EE0pHQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 May 2017 20:26:04 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5HblYqwP1y5IuT754qj1SKR7yPDuSb6SD+fh0wFOGt4=; b=Yt4/VEge/mgmzNB7u7YojvyXm
        oDmjqb16ikTey2Mu1n+DzBbXkU5+FqpdQMYB917AskV/ryG9GZa14hLNBxRxysvSI7ZWIVY/HaqHv
        0PgHVkMfSP/pDz85FOJGPtkZ9kFCwZZ2Zq0Lss7A7eZG4xTnFdWczt6Y2LCAMWuCkcOKVjKCn3fg0
        +pAhykDR7fhkFkhr5Q2uyn0CPUDUwJxMpllClKl4HZh4/vZHSvntDE9VRHfy4FGSiY5hsVZ34+eCL
        1OUOn+3k3IpFJvEOwJ6fTnGYmn7thJqf/+JWGTxrdvA6PUmYkqk1m4oGojcQtP9E1+uhz9XPP/XDx
        cCkdeQVIg==;
Received: from static-50-53-52-16.bvtn.or.frontiernet.net ([50.53.52.16] helo=[192.168.1.19])
        by bombadil.infradead.org with esmtpsa (Exim 4.87 #1 (Red Hat Linux))
        id 1dDayw-0005T9-5D; Wed, 24 May 2017 18:26:02 +0000
Subject: Re: [PATCH] MIPS: Alchemy: Delete an error message for a failed
 memory allocation in alchemy_pci_probe()
To:     SF Markus Elfring <elfring@users.sourceforge.net>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        linux-mips@linux-mips.org
Cc:     Paul Burton <paul.burton@imgtec.com>,
        =?UTF-8?Q?Ralf_B=c3=a4chle?= <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
References: <6ebb5193-239f-5c34-c5f6-2be8a2fa79a5@users.sourceforge.net>
 <CAOLZvyHq-7q0XxiBsyX3q0g0J3kjfFv4SU7amX1hpjRDyK+feQ@mail.gmail.com>
 <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <98579b27-3052-0300-ec67-84f75f761a35@infradead.org>
Date:   Wed, 24 May 2017 11:26:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <796029e7-60a3-a94b-8b5c-4686a0656560@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <rdunlap@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57994
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rdunlap@infradead.org
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

On 05/24/17 11:15, SF Markus Elfring wrote:
>>> +++ b/arch/mips/pci/pci-alchemy.c
>>> @@ -377,7 +377,6 @@ static int alchemy_pci_probe(struct platform_device *pdev)
>>>
>>>         ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
>>>         if (!ctx) {
>>> -               dev_err(&pdev->dev, "no memory for pcictl context\n");
>>>                 ret = -ENOMEM;
>>>                 goto out;
>>>         }
>>> --
>>> 2.13.0
>>
>> Why are you removing just this one dev_err()?

Agreed.  Why just this one error message when there are many in this function?

> How do you think about to achieve a small code reduction also for this software module?
> 
> 
>> What issue are you trying to address?
> 
> Do you find information from a Linux allocation failure report sufficient
> for such a function implementation?

Can you answer questions with statements instead of with questions?

thanks.
-- 
~Randy
