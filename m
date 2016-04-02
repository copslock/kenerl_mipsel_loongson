Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 02 Apr 2016 14:19:16 +0200 (CEST)
Received: from mail-lb0-f194.google.com ([209.85.217.194]:35755 "EHLO
        mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014287AbcDBMTN4lUcR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 2 Apr 2016 14:19:13 +0200
Received: by mail-lb0-f194.google.com with SMTP id gk8so10522189lbc.2;
        Sat, 02 Apr 2016 05:19:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZEEJWKgqHSQdaqOLu56vOqKen0y1SgofRSsrJJ6WHNo=;
        b=IjwAMF9W9oMZdfG9StYPK0lkO1d4Eiq3kRUA+yEez6oe/SGmqUDPHe88yIP7F7c9Wf
         8eR7CNTlJS/XLDp3PLV/UdNmDaJIAh6IrSTlvB6hHcp0KDCZOTasLYeYDyz1ARp/iIdt
         70bNufM3pofpwV9/nUAHb8m2hq64Ivy1lFGk65DGjf7hPeuf6AYPY7uvxm2vTVo3TUrZ
         /6MuRAr5sUYvnToCprze4lS9fN28zU3/Xv6iXWQY1FY1sopFO43S68+E/0I/NtZwAe04
         iA4h/fMToZ+RnjulUaW8eZ03EV5KgV7CkPon2S+SJaJ3PSBd/LtZ5b4A9Foz/hcmUmnf
         IcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZEEJWKgqHSQdaqOLu56vOqKen0y1SgofRSsrJJ6WHNo=;
        b=as+68859q1G4eN+XBPp2gaacAUStXn1Flfa4tUrwDcsC75osqHqySrQnzrxWDfqY3c
         v/x3vDmB23SJR7Q8WLRqhKVOPHqJGeqsLiudK5AgKPYNuxgl0Icz46/q9WSK5w9Wr4+y
         xhYRHqd7iV4upLcO93OTNpDLYQIunUU+tue4r1O7zZ/+X1zAJOpKcVYEa4VDigJKEd6d
         MZngIF41j939BaMf98X39H1E7+ma1EQJzzGPhYA/ZI6PFP4qqMZEtjhlfsWuUvp6+2O+
         KCgxnc+pAKDkyM2gDFJp+yJrV2a5OwqgBP9C/oZS2IocyrZROujyCx/JSg8J5O3d1/VB
         E5ag==
X-Gm-Message-State: AD7BkJLdKo76h/jSiahFWbHnkIkfcZMktTehURIp2q2VlEBP0Y2aUUb53pQRGJoQ4MtcrQ==
X-Received: by 10.28.24.80 with SMTP id 77mr3205357wmy.16.1459599548516;
        Sat, 02 Apr 2016 05:19:08 -0700 (PDT)
Received: from Qaiss-MacBook-Pro.local (92.40.248.138.threembb.co.uk. [92.40.248.138])
        by smtp.gmail.com with ESMTPSA id w202sm2424491wmw.18.2016.04.02.05.19.07
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 02 Apr 2016 05:19:07 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Fix broken malta qemu
To:     Paul Burton <paul.burton@imgtec.com>, ralf@linux-mips.org
References: <1458248889-24663-1-git-send-email-qsyousef@gmail.com>
 <20160401124852.GA5145@NP-P-BURTON>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
From:   Qais Yousef <qsyousef@gmail.com>
Message-ID: <56FFB8B7.8050607@gmail.com>
Date:   Sat, 2 Apr 2016 13:19:03 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:38.0)
 Gecko/20100101 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <20160401124852.GA5145@NP-P-BURTON>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <qsyousef@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52836
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

Hi Paul,

On 01/04/2016 13:48, Paul Burton wrote:
> On Thu, Mar 17, 2016 at 09:08:09PM +0000, Qais Yousef wrote:
>> Malta defconfig compiles with GIC on. Hence when compiling for SMP it causes the
>> new IPI code to be activated. But on qemu malta there's no GIC causing a
>> BUG_ON(!ipidomain) to be hit in mips_smp_ipi_init().
>>
>> Since in that configuration one can only run a single core SMP (!), skip IPI
>> initialisation if we detect that this is the case. It is a sensible behaviour
>> to introduce and should keep such possible configuration to run rather than die
>> hard unnecessarily.
> Hi Qais/Ralf,
>
> This patch is insufficient I'm afraid. It's entirely possible to use SMP
> with multiple VPEs in a single core on Malta boards that don't have a
> GIC - we have code handling IPIs in that case guarded by #ifdef
> CONFIG_MIPS_MT_SMP in arch/mips/mti-malta/malta-int.c. I think the
> BUG_ON needs to be removed entirely, unless that single-core multi-VPE
> IPI code is also converted to use an IPI irqdomain.
>

I was under the impression that SMP is only supported under GIC and 
older forms of SMP are deprecated.

I think the problem you're describing is different to the one this is 
trying to fix. The right fix for your issue is to make 
CONFIG_GENERIC_IRQ_IPI selected when CONFIG_MIPS_GIC && !CONFIG_MIPS_MT_SMP.

Would it be easy for you to create such a patch and test it?

Thanks,
Qais
