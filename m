Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Oct 2014 22:39:51 +0100 (CET)
Received: from mail-pa0-f48.google.com ([209.85.220.48]:63797 "EHLO
        mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011726AbaJ1VjuGX-sP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Oct 2014 22:39:50 +0100
Received: by mail-pa0-f48.google.com with SMTP id ey11so1662979pad.7
        for <linux-mips@linux-mips.org>; Tue, 28 Oct 2014 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=X8wEd54BlH7KNQ032nL/CKfZ/clkLaqI0H1l7KrtWu8=;
        b=N5EimjDncIjUVhDK12yTEJH7Bsu7zSsKa967+fAxmyiwyj4smEERVm+mNqXeQHKP/A
         h5XZTZzk89Vzn3es55wx79t5IsFSkEBF3S4M/CO33PAQr50GNsFgd50WZjDFUnLpS2oY
         rFNncmDN37xHhjR7vfA4qVlEyznHyU8+W8uShWoUvoTjvr8tZX16xktnoWEkg9Q08026
         3zmafyJR9tzXwNwFZJnqmeRb9a1fitlTv7d/e9HDkRMlAH5VzzuCalie1CRHZOrkXfdO
         EjGjtsyyU5ioRCqwCWtqYXeBNdkQ9O/XEnsUliAy4sjnADMdXpy8Wyra6SOEcuCCjUOX
         7+4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=X8wEd54BlH7KNQ032nL/CKfZ/clkLaqI0H1l7KrtWu8=;
        b=J52l72fKEXE2vDd/TpsUcqKuZoyt2D4Az0AlPCbJMRhhSbLyq9QCaPcttZPuSo0/60
         A1Rg8AbE46sG/BvYk4GoxYxRqQ9bAdxxzQjbNU40MorSbrpKybZvPHpbuftSNzhQKjLI
         q7RRbfdJyVs7oo4nizhQh8gSkGxJ0dpPw0zMI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=X8wEd54BlH7KNQ032nL/CKfZ/clkLaqI0H1l7KrtWu8=;
        b=MP7nLIcDKpjsj4PDXEjzz6xnUnYFWySlfhvdg5rEEYdmWULgW1CuqrReSpwmOltry+
         s2bgsmA5LQ5SOQGhwf3PHZ/kGuyHgAhDdyA6nydeWs22GW7Np3AghCdyaBZ0RFNfqB5i
         X8fgxYm6JP9MTk88peN52Fswb6qCQz6uBbe5n1JXdFVVmNa8NM06sy5cGsLtO7hDP3In
         2EguaC7Gm5wUUQUfWeBAw39Ycbn4uRP+7MADupjy+ElTEystOZFOAP85ywDlx6MlMoYo
         Bqrvcc6alizweMbKrWepksQEWqsWjZ1WB7Cuw8vEDUpej7CtvMYwBMWqQVsC0lHYs6Nt
         sFYw==
X-Gm-Message-State: ALoCoQnIuhR+bU0ZRqYW0aG2/vfVlxOcu2++9ReBGftJUEvQmmKy7cSuwGkL5TdBwNrNZBRow7Oj
MIME-Version: 1.0
X-Received: by 10.68.57.199 with SMTP id k7mr6261332pbq.80.1414532383439; Tue,
 28 Oct 2014 14:39:43 -0700 (PDT)
Received: by 10.70.118.170 with HTTP; Tue, 28 Oct 2014 14:39:43 -0700 (PDT)
In-Reply-To: <CAJiQ=7Bk4jiByynau2nR_BO6o5Rg3LpumNpDOpb=UQaYQCSknQ@mail.gmail.com>
References: <1414445904-4781-1-git-send-email-abrestic@chromium.org>
        <1414445904-4781-3-git-send-email-abrestic@chromium.org>
        <CAJiQ=7Bk4jiByynau2nR_BO6o5Rg3LpumNpDOpb=UQaYQCSknQ@mail.gmail.com>
Date:   Tue, 28 Oct 2014 14:39:43 -0700
X-Google-Sender-Auth: JmHFR44naL7p0zsqNB4GLr4Bws0
Message-ID: <CAL1qeaEw-1RYcAo9Vo2e3gsV1JBVsJVOP0WSqpfrErCw0xufNw@mail.gmail.com>
Subject: Re: [PATCH 3/3] irqchip: mips-gic: Use __raw_{readl,writel} for GIC registers
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

Hi Kevin,

On Mon, Oct 27, 2014 at 3:29 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Mon, Oct 27, 2014 at 2:38 PM, Andrew Bresticker
> <abrestic@chromium.org> wrote:
>> No byte swapping is necessary for accessing the GIC registers.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>  drivers/irqchip/irq-mips-gic.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
>> index 61ac482..7ec3c18 100644
>> --- a/drivers/irqchip/irq-mips-gic.c
>> +++ b/drivers/irqchip/irq-mips-gic.c
>> @@ -37,12 +37,12 @@ static void __gic_irq_dispatch(void);
>>
>>  static inline unsigned int gic_read(unsigned int reg)
>>  {
>> -       return readl(gic_base + reg);
>> +       return __raw_readl(gic_base + reg);
>>  }
>>
>>  static inline void gic_write(unsigned int reg, unsigned int val)
>>  {
>> -       writel(val, gic_base + reg);
>> +       __raw_writel(val, gic_base + reg);
>>  }
>
> Hi Andrew,
>
> I just ran into a related problem on bcm3384, a big-endian platform on
> which readl/writel perform extra endian swaps (CONFIG_SWAP_IO_SPACE).
> My solution was twofold:
>
>  - Change the irq_reg_{readl,writel} macros so that they can be
> configured to use the __raw_ variants on individual platforms
>
>  - Use irq_reg_{readl,writel} instead of directly invoking
> __raw_{readl,writel} in our irqchip driver, so that the irqchip driver
> code always uses the same I/O accessors as the helper functions we're
> using from kernel/irq/generic-chip.c

You could also specify your own irq_reg_{readl,writel} in your
platform's irq.h.  Though since it seems like this is pretty common on
MIPS platforms, maybe it makes more sense to have a Kconfig option.
I've added the irqchip maintainers to see what they think.

> Do you think a similar approach might be suitable for the irq-mips-gic driver?

The MIPS GIC driver doesn't use generic irqchip (and I'm not planning
on converting it since it doesn't quite fit in the generic irqchip
model), so I've had it use __raw_{readl,writel} directly.
