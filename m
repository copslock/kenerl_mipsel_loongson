Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 22:02:48 +0100 (CET)
Received: from mail-qg0-f47.google.com ([209.85.192.47]:52397 "EHLO
        mail-qg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012570AbaKXVCqOWyjO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 22:02:46 +0100
Received: by mail-qg0-f47.google.com with SMTP id z60so7345530qgd.6
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 13:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6z1+QScvfg9W0LtH5xXdDzQfqiWjF2h1xcHVJqRH7bM=;
        b=SljAsLt1VHPioLi3dHzyTw/ZSxaArgRiLKJ6S4dKSGvMbGWZdskGSsowae9iDN8I26
         7Ou07BJGDiQWc8wBEdfBMvIdQhu+j4ZbZ3eArvF+PwPjbr8AsWWBjfMSSh2GIg8jDZpD
         atyF9R+njOILZwC6Ur97dG+p0le2f+wTzwRz9SnEudZP+sQXWgzXFE8VkM30oHzZ5eti
         sMmdVU1otRmUPwvVZ6r+D9c9ufSOwV9hfgJ27oZkkIqRhw2quBMuU5cKgNrpYEfm1c7a
         t1MZzm3bh7rcVJiGHYOpCiZh1aPckT4fsFLgVotNpt5/eAlUq2/imGMJ+LD8oIv9rhB3
         p5Lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=6z1+QScvfg9W0LtH5xXdDzQfqiWjF2h1xcHVJqRH7bM=;
        b=SuuPpDX/ZUDa/j4yGCoDJeEn+ahv8KuLFN5k5nVGSXguGfB9DA/iuN87250hsEL9G0
         Nc+V3pQshMBzqrAsKRvKkZ/yFZG7+ByfJlQH3S8WJChPPERAd+fvMpH/7zTQ1Tjg+tPG
         0rTzy9q/3Dyc6IDPTZ74Ixpi/MDZBlaM9lo0U=
MIME-Version: 1.0
X-Received: by 10.224.53.132 with SMTP id m4mr31443133qag.85.1416862960416;
 Mon, 24 Nov 2014 13:02:40 -0800 (PST)
Received: by 10.140.39.170 with HTTP; Mon, 24 Nov 2014 13:02:40 -0800 (PST)
In-Reply-To: <54739AB2.8030002@de.ibm.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
        <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
        <15567.1416835858@warthog.procyon.org.uk>
        <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
        <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
        <547381D7.2070404@de.ibm.com>
        <12209.1416859494@warthog.procyon.org.uk>
        <CA+55aFwHJyyo1y=-u=t798PFTeZN796hnwd9-XzEnL=JaqVmDw@mail.gmail.com>
        <54739AB2.8030002@de.ibm.com>
Date:   Mon, 24 Nov 2014 13:02:40 -0800
X-Google-Sender-Auth: iGAM9Dek7rCxZSQwaUfuyO9KGDY
Message-ID: <CA+55aFz2bCbhQP3d1bh48AcWTh9bkoMO07JjmwbApGCanJFEMQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     David Howells <dhowells@redhat.com>,
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
X-archive-position: 44407
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

On Mon, Nov 24, 2014 at 12:53 PM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> That looks like a lot of changes all over ACCESS_ONCE -> ASSIGN_ONCE:
> git grep "ACCESS_ONCE.*=.*"
> gives me 200 placea not in Documentation.

Yeah, that's a bit annoying.

How about a combination of the two:

 - accept the fact that right now ACCESS_ONCE() is fairly widespread
(even for writing)

 - but also admit that we'd be better off with a nicer interface

and make the solution be:

 - make ACCESS_ONCE() only work on scalars, and deprecate it

 - add new "read_once()" and "write_once()" interfaces that *do* work
on (appropriately sized) structures and unions, and start migrating
things over. In particular, start with the ones that can no longer use
ACCESS_ONCE() because they aren't scalar..

That second point would make the conversion patches actually easier to
read. Instead of this:

 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-       struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
+       arch_spinlock_t tmp = {};

-       return tmp.tail != tmp.head;
+       tmp.head_tail =ACCESS_ONCE(lock->head_tail);
+       return tmp.tickets.tail != tmp.tickets.head;
 }

which isn't *complex*, but is also not an obvious conversion, we'd have just

 static inline int arch_spin_is_locked(arch_spinlock_t *lock)
 {
-       struct __raw_tickets tmp = ACCESS_ONCE(lock->tickets);
-       struct __raw_tickets tmp = read_once(lock->tickets);

        return tmp.tail != tmp.head;
 }

which is a much simpler and more obvious change.

And then we could slowly try to migrate existing ACCESS_ONCE() users
over (particularly writers).

Hmm? Too much?

                     Linus
