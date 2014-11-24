Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 23:58:17 +0100 (CET)
Received: from mail-qc0-f174.google.com ([209.85.216.174]:52411 "EHLO
        mail-qc0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006920AbaKXW6Og0Qbp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 23:58:14 +0100
Received: by mail-qc0-f174.google.com with SMTP id c9so7594889qcz.33
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 14:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=A7CqLxbf5+mEeMcOomfFVMppuLQTPDrHv3e3eSHQft8=;
        b=TmctrsM5qOyGp52mlel/U5WqKH4pMvDOlTYEYiN/6D6EvCJIusAFFqKo+0ScTGhAzr
         l3YH+bxeh8wvQEm37q4iGzOeqXT/C6nRbw6VKsSmhuR6EzopgLn0WDGfHTsvzOs+lSTs
         4iX7KNvn+qkhlaso1oVc88Z2pmtz0aoO+gDWUVBeEk56DbCftDcKiY9KbqbjCpsdPWXD
         fkYlLUXo9bUNMwLiWZD/3dIg+vpjMi3US/KX13Jl6TB6HmtKW77YY0yBsQ9xTU6S8YEc
         Z9XzidNadUyTx7PfDnFz0fUBAQWzB1e4g3XkZEl0C4W363OOE+MuasuUPdAQAfLpo+zU
         J0uw==
MIME-Version: 1.0
X-Received: by 10.229.249.68 with SMTP id mj4mr32313091qcb.23.1416869888878;
 Mon, 24 Nov 2014 14:58:08 -0800 (PST)
Received: by 10.96.89.33 with HTTP; Mon, 24 Nov 2014 14:58:08 -0800 (PST)
Date:   Mon, 24 Nov 2014 14:58:08 -0800
Message-ID: <CAADnVQ+8d0GC5OwQTdJKkmG8=vshUVqK1pPou1GCGa_iuU2v-g@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Paul McKenney <paulmck@linux.vnet.ibm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alexei.starovoitov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44411
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexei.starovoitov@gmail.com
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

On Mon, Nov 24, 2014 at 12:34 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Mon, Nov 24, 2014 at 12:04 PM, David Howells <dhowells@redhat.com> wrote:
>>
>> Reserve ACCESS_ONCE() for reading and add an ASSIGN_ONCE() or something like
>> that for writing?
>
> I wouldn't mind that. We've had situations where reading and writing
> isn't really similar - like alpha where reading a byte is atomic, but
> writing one isn't.
>
> Then we could also make it have the "get_user()/put_user()" kind of
> semantics - .and then use the same "sizeopf()" tricks that we use for
> get_user/put_user.
>
> That would actually work around the gcc bug a completely different way:
>
>   #define ACCESS_ONCE(p) \
>       ({ typeof(*p) __val; __read_once_size(p, &__val, sizeof(__val)); __val; })
>
> and then we can do things like this:
>
>   static __always_inline void __read_once_size(volatile void *p, void
> *res, int size)
>   {
>        switch (size) {
>        case 1: *(u8 *)res = *(volatile u8 *)p; break;
>        case 2: *(u16 *)res = *(volatile u16 *)p; break;
>        case 4: *(u32 *)res = *(volatile u32 *)p; break;
> #ifdef CONFIG_64BIT
>        case 8: *(u64 *)res = *(volatile u64 *)p; break;
> #endif
>        }
>   }
>
> and same for ASSIGN_ONCE(val, p).
>
> That also hopefully avoids the whole "oops, gcc has a bug", because
> the actual volatile access is always done using a scalar type, even if
> the type of "__val" may in fact be a structure.

I've changed gcc pr58145-1.c reproducer to use
__read_once_size() approach above, but it
didn't help to workaround the bug.
gcc 'sra' pass still lost 'volatile' modifier.

modified reproducer:
struct S { unsigned int data; };
void bar(int val)
{
  struct S _s = { .data = val };
  *(volatile struct S *) 0x880000UL = ACCESS_ONCE(&_s);
}
assembler code looks as expected, but
internal gcc state after 'sra' pass is
missing volatile...
