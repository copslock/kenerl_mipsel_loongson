Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Apr 2017 15:10:10 +0200 (CEST)
Received: from mail-wm0-f67.google.com ([74.125.82.67]:36567 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992178AbdDJNKCBzWLC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 10 Apr 2017 15:10:02 +0200
Received: by mail-wm0-f67.google.com with SMTP id q125so9576833wmd.3
        for <linux-mips@linux-mips.org>; Mon, 10 Apr 2017 06:10:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=duxNvzgjwlmvuozGNJluTWjwtlquJd7oUQCM4W+jCpQ=;
        b=kJJ+L82QJhkOxxx/p6q7xh1meqPyNAIOt7MHS7aOOp3Vxc9Tu4qi/nwmpXsX2b+F7b
         04oujEn+b+fXF3UpWabc7T/oTDVmSb4ECfaqDAzfSy5a0mNyr5C6ZbQdfTs3IIkCZ+V3
         ejwLIL/YoVqZTfizr5o0TzsUbifLw5ATpWEIsp65hjwWuKHn4ZdxA9Djy+pILLGwd6CK
         HDFNxXBQu9VUJalbx1QBZdM3toT/6aaVINs1fAkbDFtObKUmvnDzxAyDiwGohSqPGp8T
         HPnr0l+QXlEXJLIEfenL5iq7eAciZ+V3zZDKP0DIfF2BIoO9OYhanFOsyt31RnJubv6I
         gQAg==
X-Gm-Message-State: AN3rC/7AEGBKXuVDzRMY3YRMTRbHHMfueey91/UyZ/qgW0ecq7QLDt3kvvukhmeQw5g4AA==
X-Received: by 10.28.63.71 with SMTP id m68mr9935487wma.46.1491829795542;
        Mon, 10 Apr 2017 06:09:55 -0700 (PDT)
Received: from ?IPv6:2a01:4240:2e27:ad85:aaaa::19f? (f.9.1.0.0.0.0.0.0.0.0.0.a.a.a.a.5.8.d.a.7.2.e.2.0.4.2.4.1.0.a.2.v6.cust.nbox.cz. [2a01:4240:2e27:ad85:aaaa::19f])
        by smtp.gmail.com with ESMTPSA id u9sm10275277wme.8.2017.04.10.06.09.54
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Apr 2017 06:09:54 -0700 (PDT)
Subject: Re: [patch added to 3.12-stable] MIPS: Lantiq: Fix cascaded IRQ setup
To:     Amit Pundir <amit.pundir@linaro.org>
References: <20170410125930.26495-1-jslaby@suse.cz>
 <20170410125930.26495-47-jslaby@suse.cz>
 <CAMi1Hd1P9w6H2N6A9D6=ZYJY2Txd4yPww7Atw3iUSjJGSb4NLg@mail.gmail.com>
Cc:     stable@vger.kernel.org, Felix Fietkau <nbd@nbd.name>,
        linux-mips@linux-mips.org, James Hogan <james.hogan@imgtec.com>
From:   Jiri Slaby <jslaby@suse.cz>
Message-ID: <9a7aaf66-96bd-9440-6f8c-9365654a5526@suse.cz>
Date:   Mon, 10 Apr 2017 15:09:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAMi1Hd1P9w6H2N6A9D6=ZYJY2Txd4yPww7Atw3iUSjJGSb4NLg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <jirislaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

On 04/10/2017, 03:07 PM, Amit Pundir wrote:
> Hi Jiri,
> 
> On 10 April 2017 at 18:29, Jiri Slaby <jslaby@suse.cz> wrote:
>> From: Felix Fietkau <nbd@nbd.name>
>>
>> This patch has been added to the 3.12 stable tree. If you have any
>> objections, please let us know.
>>
>> ===============
>>
>> commit 6c356eda225e3ee134ed4176b9ae3a76f793f4dd upstream.
>>
>> With the IRQ stack changes integrated, the XRX200 devices started
>> emitting a constant stream of kernel messages like this:
>>
>> [  565.415310] Spurious IRQ: CAUSE=0x1100c300
>>
>> This is caused by IP0 getting handled by plat_irq_dispatch() rather than
>> its vectored interrupt handler, which is fixed by commit de856416e714
>> ("MIPS: IRQ Stack: Fix erroneous jal to plat_irq_dispatch").
>>
>> Fix plat_irq_dispatch() to handle non-vectored IPI interrupts correctly
>> by setting up IP2-6 as proper chained IRQ handlers and calling do_IRQ
>> for all MIPS CPU interrupts.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> Acked-by: John Crispin <john@phrozen.org>
>> Cc: linux-mips@linux-mips.org
>> Patchwork: https://patchwork.linux-mips.org/patch/15077/
>> [james.hogan@imgtec.com: tweaked commit message]
>> Signed-off-by: James Hogan <james.hogan@imgtec.com>
>> Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
> 
> Just to let you know that I cherry-picked this patch from LEDE source
> for 4.4 and 4.9 stable but James pointed out that this patch fixes a
> Mips IRQ bug introduced in later (4.10+) kernels. So we dropped it
> from 4.4 and 4.9 plan as such. Thanks.

Dropped too. Thanks!


-- 
js
suse labs
