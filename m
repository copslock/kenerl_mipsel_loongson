Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2016 11:14:15 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35831 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007650AbcFYJOMPqzD0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 25 Jun 2016 11:14:12 +0200
Received: by mail-wm0-f67.google.com with SMTP id a66so11198903wme.2
        for <linux-mips@linux-mips.org>; Sat, 25 Jun 2016 02:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=OzcZuzHy4J8yDa7T51gmRrayH60a1zu7L0C7rVd4PoU=;
        b=K2tb+JGPx+9LwafBSLnm9DKMy/T4O84C9m4Q44eFf+YUJfNvtotUz16Al5SXQ1cdjG
         BLaEziVSFBiX6JP5NMl8vlnvSmiwGQx2vLz5zkuslsA7jYf8+ZA/90AKHqyfUwjp0jpS
         IAk8f0wBnGHE8A7F5flokNYui6CehwbPIikKzXeB8VugoA/Z0+pRLZPMtxFqnB5n8pSU
         aH2GZQxTPutHbbUwd0qbPETup8BfGfuMTg+/pQp/VARM2l5nEcoDSJ10ETRgfphDQPew
         QPSosNXMdR74MsmwU3EPOLwjvGtPLjjNbEKHtDeRXO5mApREzReoonLec5YOKfzmFZOQ
         AMRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=OzcZuzHy4J8yDa7T51gmRrayH60a1zu7L0C7rVd4PoU=;
        b=kj42bkUCUmMY40yxeQb95tChh9QFoPPNwH5MHIBYDngV1H3GaxK689SKCo3azibWQc
         n481s7j+yDoExqgx4VYzy4o1zXW6DTvtkldNiWueRCdGGqxKBhNz/2ZLhCLwol4zo8wU
         LdoqhFGm51yTNSroQGFsBFWUEtbuoKkcR6xq0OA4DSzlv+sYVpLEJ7Yv5pDkG+EaoJ7Q
         9zHDNdsrwR/vGX1FsIBZi4dFN2IXRvE3JbnjKtYrpXC/sSu3rKFCMiAEgdo7rJAQj+4q
         gPk3HXZbcqcuzAuiXOICC1j4JcSbE/0ahcWblvtZnZnX6iWBA0T3vsn5gjNeCjHzLRxs
         YXhw==
X-Gm-Message-State: ALyK8tLgjE1alOYz3mbWgw6UhNYNFaoQjYEPIVbR4osPfmtq0JIzF8BeWrZ90/vFgOAcxQ==
X-Received: by 10.194.114.163 with SMTP id jh3mr8126211wjb.173.1466846046902;
        Sat, 25 Jun 2016 02:14:06 -0700 (PDT)
Received: from Qaiss-MacBook-Pro.local (host109-155-88-107.range109-155.btcentralplus.com. [109.155.88.107])
        by smtp.gmail.com with ESMTPSA id 124sm675143wml.12.2016.06.25.02.14.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 25 Jun 2016 02:14:06 -0700 (PDT)
Subject: Re: [PATCH] irqchip/mips-gic: Fix IRQs in gic_dev_domain
To:     Jason Cooper <jason@lakedaemon.net>, g@io.lakedaemon.net
References: <1464001552-31174-1-git-send-email-harvey.hunt@imgtec.com>
 <CA+mqd+7mh3v-1mk4xpxBjxtt4_JjycisWj6VnV7AaOH=i=y3Qw@mail.gmail.com>
 <20160623181117.GH9922@io.lakedaemon.net>
Cc:     Harvey Hunt <harvey.hunt@imgtec.com>, linux-mips@linux-mips.org,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org, marc.zyngier@arm.com
From:   Qais Yousef <qsyousef@gmail.com>
Message-ID: <576E4B5B.5010508@gmail.com>
Date:   Sat, 25 Jun 2016 10:14:03 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160623181117.GH9922@io.lakedaemon.net>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <qsyousef@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: qsyousef@gmail.com
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

On 23/06/2016 19:11, Jason Cooper wrote:
> Qais,
>
> On Tue, May 24, 2016 at 11:43:07AM +0100, Qais Yousef wrote:
>> Hmm I certainly did test this on real hardware with GIC. Are you using the
>> new dev domain? The idea is that GIC is logically divided and shouldn't be
>> used directly. Sorry I'm travelling and can't check the code.
> Any update on this patch?  Should I stop tracking it?

Apologies I didn't realise I was holding this up. I thought I received 
an email that this was committed so I didn't take a look.

I just had a look and we set the hwirq for the IPI domain in the same 
function. My memory failed me and I thought maybe the problem was due to 
someone trying to access the gic_irq_domain directly. I don't know why 
when I tested this on Malta I didn't see this problem.

Anyways I'm OK with this change if that's what you're asking.

Thanks,
Qais

>
> thx,
>
> Jason.
>
>> On 23 May 2016 12:06, "Harvey Hunt" <harvey.hunt@imgtec.com> wrote:
>>
>>> When allocating a new device IRQ, gic_dev_domain_alloc() correctly calls
>>> irq_domain_set_hwirq_and_chip(), but gic_irq_domain_alloc() does not. This
>>> means that gic_irq_domain believes all IRQs from the dev domain have an
>>> hwirq of 0 and creates incorrect mappings in the linear_revmap. As
>>> gic_irq_domain is a parent of the gic_dev_domain, this leads to an
>>> inability to boot on devices with a GIC. Excerpt of the error:
>>>
>>> [    2.297649] irq 0: nobody cared (try booting with the "irqpoll" option)
>>> ...
>>> [    2.436963] handlers:
>>> [    2.439492] Disabling IRQ #0
>>>
>>> Fix this by calling irq_domain_set_hwirq_and_chip() for both the dev and
>>> irq domain.
>>>
>>> Now that we are modifying the parent domain, be sure to clear it up in
>>> case of an allocation error.
>>>
>>> Fixes: c98c1822ee13 ("irqchip/mips-gic: Add device hierarchy domain")
>>> Fixes: 2af70a962070 ("irqchip/mips-gic: Add a IPI hierarchy domain")
>>> Signed-off-by: Harvey Hunt <harvey.hunt@imgtec.com>
>>> Tested-by: Govindraj Raja <Govindraj.Raja@imgtec.com> # On Pistachio SoC
>>> Reviewed-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>> Cc: <linux-mips@linux-mips.org>
>>> Cc: <linux-kernel@vger.kernel.org>
>>> Cc: Qais Yousef <qsyousef@gmail.com>
>>> ---
>>>   drivers/irqchip/irq-mips-gic.c | 12 +++++++++++-
>>>   1 file changed, 11 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/irqchip/irq-mips-gic.c
>>> b/drivers/irqchip/irq-mips-gic.c
>>> index 4dffccf..40fb120 100644
>>> --- a/drivers/irqchip/irq-mips-gic.c
>>> +++ b/drivers/irqchip/irq-mips-gic.c
>>> @@ -734,6 +734,12 @@ static int gic_irq_domain_alloc(struct irq_domain *d,
>>> unsigned int virq,
>>>                  /* verify that it doesn't conflict with an IPI irq */
>>>                  if (test_bit(spec->hwirq, ipi_resrv))
>>>                          return -EBUSY;
>>> +
>>> +               hwirq = GIC_SHARED_TO_HWIRQ(spec->hwirq);
>>> +
>>> +               return irq_domain_set_hwirq_and_chip(d, virq, hwirq,
>>> +
>>> &gic_level_irq_controller,
>>> +                                                    NULL);
>>>          } else {
>>>                  base_hwirq = find_first_bit(ipi_resrv, gic_shared_intrs);
>>>                  if (base_hwirq == gic_shared_intrs) {
>>> @@ -855,10 +861,14 @@ static int gic_dev_domain_alloc(struct irq_domain
>>> *d, unsigned int virq,
>>>
>>> &gic_level_irq_controller,
>>>                                                      NULL);
>>>                  if (ret)
>>> -                       return ret;
>>> +                       goto error;
>>>          }
>>>
>>>          return 0;
>>> +
>>> +error:
>>> +       irq_domain_free_irqs_parent(d, virq, nr_irqs);
>>> +       return ret;
>>>   }
>>>
>>>   void gic_dev_domain_free(struct irq_domain *d, unsigned int virq,
>>> --
>>> 2.8.2
>>>
>>>
