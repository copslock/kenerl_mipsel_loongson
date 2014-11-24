Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 21:34:42 +0100 (CET)
Received: from mail-qa0-f48.google.com ([209.85.216.48]:59260 "EHLO
        mail-qa0-f48.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011494AbaKXUek7CpNs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 21:34:40 +0100
Received: by mail-qa0-f48.google.com with SMTP id v10so7021243qac.35
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 12:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w6LN+XmaFJXpl1vvPzY1IlIwSyzQYxommiOi4PctYWk=;
        b=qeC624X++R3kRnnUm15INASWjXVSoSl7ghs5hEY80Rx89NB+02K2zPmM03ZP3u9l/B
         Fsl+QCCT5bX7J6QrqCjM2orflPMJbZdHRcDkgojMlBUz9ic1yoxZtm96HrRL/dVEwm/N
         Lw3kpkr6kBJogAmFm0I+0CjedI4AnMfeYPypD1lfTqWbWHbfV9eFq7V5q1Z7Jsavxroe
         icxpEqLol9DR3C+NwIHEBpVje+hk8lqgITeAQh7YBCvd5Apz6AxBZVMcSKGVYeUORGNV
         nW4scfsfeSO+GSiJ6wDkkpppz0Jc9Vw31HgAoMNpLe8r4epjaMxFPdYHYaQqn5DXXwvG
         BmNA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=w6LN+XmaFJXpl1vvPzY1IlIwSyzQYxommiOi4PctYWk=;
        b=cxGnK+TNbFvYgqJygf+Fr9T6PtIY0GKC+20dsglmCB8FW2EodQgjZADBQGJBPqMp3Q
         F1d3qBtMhHiv2c2RnQg7cf6wFjwWp35v0ZWm9fWAev5Ejgyu9XJq6HDrPF5wsLw3TizD
         1AZsLZJD7S9uvwvL42h+4pCQvgbdy5/0wOc4A=
MIME-Version: 1.0
X-Received: by 10.224.53.132 with SMTP id m4mr31268277qag.85.1416861275230;
 Mon, 24 Nov 2014 12:34:35 -0800 (PST)
Received: by 10.140.39.170 with HTTP; Mon, 24 Nov 2014 12:34:35 -0800 (PST)
In-Reply-To: <12209.1416859494@warthog.procyon.org.uk>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
        <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
        <15567.1416835858@warthog.procyon.org.uk>
        <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
        <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
        <547381D7.2070404@de.ibm.com>
        <12209.1416859494@warthog.procyon.org.uk>
Date:   Mon, 24 Nov 2014 12:34:35 -0800
X-Google-Sender-Auth: VActRMrBy4irOfx9ZVi3KcHXGRQ
Message-ID: <CA+55aFwHJyyo1y=-u=t798PFTeZN796hnwd9-XzEnL=JaqVmDw@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
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
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: torvalds@linux-foundation.org
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

On Mon, Nov 24, 2014 at 12:04 PM, David Howells <dhowells@redhat.com> wrote:
>
> Reserve ACCESS_ONCE() for reading and add an ASSIGN_ONCE() or something like
> that for writing?

I wouldn't mind that. We've had situations where reading and writing
isn't really similar - like alpha where reading a byte is atomic, but
writing one isn't.

Then we could also make it have the "get_user()/put_user()" kind of
semantics - .and then use the same "sizeopf()" tricks that we use for
get_user/put_user.

That would actually work around the gcc bug a completely different way:

  #define ACCESS_ONCE(p) \
      ({ typeof(*p) __val; __read_once_size(p, &__val, sizeof(__val)); __val; })

and then we can do things like this:

  static __always_inline void __read_once_size(volatile void *p, void
*res, int size)
  {
       switch (size) {
       case 1: *(u8 *)res = *(volatile u8 *)p; break;
       case 2: *(u16 *)res = *(volatile u16 *)p; break;
       case 4: *(u32 *)res = *(volatile u32 *)p; break;
#ifdef CONFIG_64BIT
       case 8: *(u64 *)res = *(volatile u64 *)p; break;
#endif
       }
  }

and same for ASSIGN_ONCE(val, p).

That also hopefully avoids the whole "oops, gcc has a bug", because
the actual volatile access is always done using a scalar type, even if
the type of "__val" may in fact be a structure.

Christian, how painful would that be? Sorry to try to make you do a
totally different approach..

                  Linus
