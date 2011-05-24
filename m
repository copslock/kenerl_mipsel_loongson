Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 May 2011 21:10:11 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:45793 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491178Ab1EXTKF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 May 2011 21:10:05 +0200
Received: by ywf9 with SMTP id 9so3175870ywf.36
        for <multiple recipients>; Tue, 24 May 2011 12:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=kDahWKPcMHq1awBxrzLMgFM8mDDzF9xXkJHUGH7tl4E=;
        b=PVkRLiujBAgdyT6YrOW6UAxDV6FQgqUFx77N7mDhHY5XBxaNCdMMh4eaa1YZF9Thcn
         /2cWRjKmlc1MOXojLpWqtYHEY8RnF4dCnukGSa+tJ+AtKq/TsO6k1fYwMMYUGxCgr0xB
         LqCO6hdwFC0PqPpg3QYmYUj5nM5PTcgotOy0E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oz7OB4VbruSyGUsniKwuu++w7oo0WOWwUXC3Zv1twdda6kt8M3Ruep+BicTpLMz0FB
         qoCGuSCRewesemeCyalNk4HNiUSYbK2KwC69LtIYzVrhATAJpnWAABS3fxEqykLm6HWB
         B8DG7QB2M0VDnUf7mddCjWKWMR3b45w7InuJE=
MIME-Version: 1.0
Received: by 10.236.176.39 with SMTP id a27mr1352802yhm.312.1306264198738;
 Tue, 24 May 2011 12:09:58 -0700 (PDT)
Received: by 10.236.102.137 with HTTP; Tue, 24 May 2011 12:09:58 -0700 (PDT)
In-Reply-To: <201105242059.59770.rjw@sisk.pl>
References: <1306247112.2066.8.camel@Tux>
        <201105242059.59770.rjw@sisk.pl>
Date:   Tue, 24 May 2011 21:09:58 +0200
Message-ID: <BANLkTimYuJiiCbqO9QxgaAKHAZWe04vhgA@mail.gmail.com>
Subject: Re: [PATCH] MIPS:i8259.c remove resume and shutdown to syscore_ops
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     "Rafael J. Wysocki" <rjw@sisk.pl>
Cc:     wanlong.gao@gmail.com, Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Pengfei Zhang <zoppof.zhang@gmail.com>,
        Linux PM mailing list <linux-pm@lists.linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30138
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, May 24, 2011 at 8:59 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, May 24, 2011, Wanlong Gao wrote:
>>
>> > On Tue, May 24, 2011 at 08:19:18PM +0800, Pengfei Zhang wrote:
>> >
>> > > Remove the resume and shutdown of i8259A from the sysdev_class
>> > > to the syscore_ops since these members had removed from the
>> > > structure sysdev_class.
>> >
>> > I don't see why one would want to want to first call
>> > register_syscore_ops
>> > then sysdev_class_register and sysdev_register?
>> >
>> Hi Ralf:
>> If these not moved to syscore_ops, building will get error.
>>
>> Hi Thomas:
>> Does you mean that we can just remove the sysfs entry now ?
>
> I had the appended patch in my tree before the merge window started,
> but it conflicted with analogous changes in the MIPS tree, so I had
> dropped it.  Was it a mistake?
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> Acked-and-tested-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  arch/mips/alchemy/common/dbdma.c |   92 +++++++++++----------------------------
>  arch/mips/alchemy/common/irq.c   |   62 +++++++++-----------------

I took care of these two, they were the reason for the conflict in -next.

Manuel
