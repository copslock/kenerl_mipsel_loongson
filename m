Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jan 2017 18:55:03 +0100 (CET)
Received: from mail-ua0-x230.google.com ([IPv6:2607:f8b0:400c:c08::230]:33197
        "EHLO mail-ua0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992535AbdAERy4Q1c-u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Jan 2017 18:54:56 +0100
Received: by mail-ua0-x230.google.com with SMTP id i68so280686709uad.0
        for <linux-mips@linux-mips.org>; Thu, 05 Jan 2017 09:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=2ZYgPXy1w2kZo9j4AemzbZTpBHZ8JBZp0zLb5A+zQzM=;
        b=GVQRQ9WlQN/J15IbfCQeZG7E/9YrsNiiQheqRjex2qzcQh/vvRTNxPNQrsgeBhebZZ
         vhquWhMuggWDh2mXQdPZpR2VWZSfzaFiu5J6E+M8RaRUJz1MuSiaTZAlyfNEU5KxA3+j
         mRoYY4ZsU85n6qY7Z1/2AMffRSeBAaC0w5fuaZ/5G8wqa6GmwcH8VW6oPkRlS8fpcwPE
         QbjTN2NWmXxg3ppRa2d4CVDbCt8CfiUQeRVjEFaiFcHHeMKt8WzVILUpVam0xF2Y26mQ
         UvEMhQIz6314xnpop/lmpHhhSJq2GzWqFAXkp5p7JQXTz+BX6Jnar8TxAX8CSSJfa7Ic
         153Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=2ZYgPXy1w2kZo9j4AemzbZTpBHZ8JBZp0zLb5A+zQzM=;
        b=OOY1dNQtC33oep64XZOopoQg70L5lZFZc4AnSRiKRxdGbwtmv22pZBTul5UCRLIY9P
         qltDMw34qRQwifpiUrhk6UNlIgEQDDHeKaTZeJ181iNP6y06BrsBdv1zUZT86TOYC02X
         MJweY1YOKOSvOVtYgXUkfNqBPzZD3QIvb4mVkbwctpSOEFlCq6XBdev9hy2Ag2Mc+CZx
         dUIoQu2V99EAv+Tpfebfkpy9gcx6JuYf9UnSHvFKGU7uEKVZA9K+pbQYZYNEtYRHg2Om
         3h2IUaeVG5kZXDWRXP8wUHvE/lalPXEbjlb6iglusmk7zo7getiNBojuWih5veD83iFw
         9v6Q==
X-Gm-Message-State: AIkVDXIGO+//TZiWtSTZdD72uLsjg0+QTR2gWLNRKYPJtblKbDTgCtne4TADa06a1zrFvYhSFrTB09gs5DUkdiYu
X-Received: by 10.176.6.231 with SMTP id g94mr54005034uag.91.1483638890507;
 Thu, 05 Jan 2017 09:54:50 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.139.66 with HTTP; Thu, 5 Jan 2017 09:54:30 -0800 (PST)
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB0258289@AcuExch.aculab.com>
References: <20161230155634.8692-1-dsafonov@virtuozzo.com> <20161230155634.8692-2-dsafonov@virtuozzo.com>
 <063D6719AE5E284EB5DD2968C1650D6DB0258289@AcuExch.aculab.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Thu, 5 Jan 2017 09:54:30 -0800
Message-ID: <CALCETrXUB8AeEzJ-WtW3kW9c189AcOe+GBq8TE7GPE+xrvXS8g@mail.gmail.com>
Subject: Re: [RFC 1/4] mm: remove unused TASK_SIZE_OF()
To:     David Laight <David.Laight@aculab.com>
Cc:     Dmitry Safonov <dsafonov@virtuozzo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        Helge Deller <deller@gmx.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Will Deacon <will.deacon@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "0x7f454c46@gmail.com" <0x7f454c46@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "David S. Miller" <davem@davemloft.net>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56168
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: luto@amacapital.net
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

On Thu, Jan 5, 2017 at 1:51 AM, David Laight <David.Laight@aculab.com> wrote:
> From: Dmitry Safonov
>> Sent: 30 December 2016 15:57
>> All users of TASK_SIZE_OF(tsk) have migrated to mm->task_size or
>> TASK_SIZE_MAX since:
>> commit d696ca016d57 ("x86/fsgsbase/64: Use TASK_SIZE_MAX for
>> FSBASE/GSBASE upper limits"),
>> commit a06db751c321 ("pagemap: check permissions and capabilities at
>> open time"),
> ...
>> +#define TASK_SIZE            (current->thread.task_size)
>
> I'm not sure I like he hidden 'current' argument to an
> apparent constant.

Me neither.  But this patch is merely changing the implementation.
