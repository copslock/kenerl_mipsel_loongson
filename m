Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 00:58:08 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:64066 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835051Ab3FIW6HAagQ5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Jun 2013 00:58:07 +0200
Received: by mail-pd0-f180.google.com with SMTP id 10so6731676pdi.39
        for <multiple recipients>; Sun, 09 Jun 2013 15:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=w3QGc1fGqhcrmVrG7DoW2msDaRZ8H839dHk+tu3kOiI=;
        b=XuLIpRiUpzq7k7UD812x9EvMANDyP3JelkQu9FdOcOoXaesUP8xzhKkwVc+d3m9+y8
         XTZRzsTf9BwP5U3jy2daX1dfpTB/mkmHqorHkJf41fyjpYA0ks7qkUGSluWdBV+S10Vo
         3Z5JbpMT4iWL7y44j9fS+u8D9T0GNR5a/fvSDWj2555nbLk9zbo6VeN98v/se8ei+cf4
         ZYW37CJB0qX3fOIhSUWDwfp7SPnaKIzhr5ajAyEbSQQ8GBMzyk7XKdxhjgop7t1CuCv7
         3q5r8GdG2Ge0AerR5V/h15ATD6et54IQQ1vg9FLaLpi2f+U7BOJuiRU4VQG+AAx+dNt5
         aDgQ==
X-Received: by 10.66.155.138 with SMTP id vw10mr11500651pab.91.1370818680434;
        Sun, 09 Jun 2013 15:58:00 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-124-149-174.dsl.pltn13.pacbell.net. [67.124.149.174])
        by mx.google.com with ESMTPSA id vv6sm12891000pab.6.2013.06.09.15.57.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 09 Jun 2013 15:57:59 -0700 (PDT)
Message-ID: <51B50873.8010104@gmail.com>
Date:   Sun, 09 Jun 2013 15:57:55 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Gleb Natapov <gleb@redhat.com>
CC:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        ralf@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v5 5/6] mips/kvm: Fix ABI by moving manipulation of CP0
 registers to KVM_{G,S}ET_ONE_REG
References: <1369248236-27237-1-git-send-email-ddaney.cavm@gmail.com> <1369248236-27237-6-git-send-email-ddaney.cavm@gmail.com> <20130608110503.GF15299@redhat.com>
In-Reply-To: <20130608110503.GF15299@redhat.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36759
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
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

On 06/08/2013 04:05 AM, Gleb Natapov wrote:
> On Wed, May 22, 2013 at 11:43:55AM -0700, David Daney wrote:
>> From: David Daney <david.daney@cavium.com>
>>
>> Because not all 256 CP0 registers are ever implemented, we need a
>> different method of manipulating them.  Use the
>> KVM_SET_ONE_REG/KVM_GET_ONE_REG mechanism.
>>
>> Now unused code and definitions are removed.
>>
> Just noticed that KVM_REG_MIPS_ definitions are wrong. You need to
> define KVM_REG_MIPS in include/uapi/linux/kvm.h (please use
> 0x7000000000000000ULL as 0x6000000000000000ULL is reserved for ARM64)
> and define all KVM_REG_MIPS_ values as "KVM_REG_MIPS | value". Can you
> send a patch to do that ASAP?

It will have to be tomorrow, I cannot test anything today.

Thanks,
David Daney
