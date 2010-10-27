Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Oct 2010 10:11:17 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:60503 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491122Ab0J0ILK convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 27 Oct 2010 10:11:10 +0200
Received: by ywg4 with SMTP id 4so188638ywg.36
        for <multiple recipients>; Wed, 27 Oct 2010 01:11:02 -0700 (PDT)
Received: by 10.151.108.9 with SMTP id k9mr16814104ybm.269.1288167061925; Wed,
 27 Oct 2010 01:11:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.151.15.4 with HTTP; Wed, 27 Oct 2010 01:10:40 -0700 (PDT)
In-Reply-To: <4CC753BE.5010705@caviumnetworks.com>
References: <1287090174-15601-1-git-send-email-ddaney@caviumnetworks.com>
 <AANLkTi=M0Fk5EGy+JB2CZcGxspv3hPde10A-R5sUs3Jq@mail.gmail.com> <4CC753BE.5010705@caviumnetworks.com>
From:   Grant Likely <grant.likely@secretlab.ca>
Date:   Wed, 27 Oct 2010 09:10:40 +0100
X-Google-Sender-Auth: v7GJmMXVqfecm8k4QhJ0hHChyUM
Message-ID: <AANLkTin8QWBOTo1dYxY=vAPj8DM3hvDyFmb-xCc=q5k6@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Add some irq definitins required by OF
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <glikely@secretlab.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28252
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: grant.likely@secretlab.ca
Precedence: bulk
X-list: linux-mips

On Tue, Oct 26, 2010 at 11:18 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 10/14/2010 06:27 PM, Grant Likely wrote:
>>
>> On Thu, Oct 14, 2010 at 3:02 PM, David Daney<ddaney@caviumnetworks.com>
>>  wrote:
>
> [...]
>>>
>>> +#define NO_IRQ UINT_MAX
>>
>> Really?  The verdict came down a long time ago that 0 is to be the
>> value that means no irq, and only a few architectures still define
>> NO_IRQ as -1.  It is assumed that the architectures which do not
>> define NO_IRQ use 0 as the invalid value.  Mostly notably x86 does not
>> define NO_IRQ, and Linus nack'd the patch to add it.
>>
>
> I was not part of that discussion.
>
> I would however note, that all the irq functions return unsigned, so a value
> of -1 is meaningless.  Also my understanding is that 8259 based systems use
> the values of 0 - 15 as the interrupt numbers, making 0 unavailable for use
> as NO_IRQ.

This is an old discussion which has been debated thoroughly and
ultimately resolved by Linus[1].  NO_IRQ is in the (slow) process of
being removed entirely.  It is worth reading the entire thread for
background.

[1] http://lkml.org/lkml/2005/11/21/200

An irq value of 0 means no irq, and the correct cross-platform test is
"if (!irq)".  Note that this is the /linux/ irq number, not the
hardware irq number.  Of course interrupt controller hardware may
define an interrupt number zero, it must not be mapped to linux irq
number zero.

As you note, 8259 systems do define an irq number 0 which is mapped to
the timer, but it is not exported to driver code.  If an architecture
wants to use irq 0 directly, then it should be contained in the arch
code.

g.
