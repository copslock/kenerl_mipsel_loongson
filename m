Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 18:30:51 +0100 (CET)
Received: from mail-la0-f53.google.com ([209.85.215.53]:60387 "EHLO
        mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006884AbaKXRas6ethM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 18:30:48 +0100
Received: by mail-la0-f53.google.com with SMTP id gm9so4953298lab.26
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 09:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ICmavVYm4r/AkKOrVngrW/TTVQZDHIscjLT2q7DRTtw=;
        b=gS1qYBFA/sUMySgQia+Rz7O3857VBJqH6kEBtFpCozQNpdye2hYfsNSzgmp/oO4k/w
         dMZJEA5vaUb9yJK0ZABFnE0X/yCvNeEaVJtZkr2B1+jQgAUFBfbEggp9MYAaP5wJu4Tq
         i2C5IMlSktBbr4erkfxukMW9Yg69Lmr5YR9Il9aTlihz90ICLYlObv9h/Yz1SbWfARK+
         9IjPgz65QBqfHJquzIB2qppToVUXtO7H0QVlCwOIXpZNXlxIAre+asxBcEBPjAlCofuL
         EG2ci27o2xOd7Whg2ZszlxQ7c1pPAppG/3tfakO67pnkSJHlqFH3zPr46WGBAdme3oc/
         sHLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=ICmavVYm4r/AkKOrVngrW/TTVQZDHIscjLT2q7DRTtw=;
        b=D5UZi4uRxgJgR72yOjxbsbNcNIycb4oxj0Eanx9XP70kIppdc6DoW4CFSPcf8Og20j
         f84yfqZ0mKKJP3xVo00TD8QoHLBhPS6hAqHLpqxlohfyryAZAHzJ8VIxcZHW/PYW+xQk
         hSZaT5sxGs5fs/STeMmnPECjljU5Ei45BqUqA=
MIME-Version: 1.0
X-Received: by 10.112.16.39 with SMTP id c7mr21421943lbd.19.1416850243609;
 Mon, 24 Nov 2014 09:30:43 -0800 (PST)
Received: by 10.112.169.98 with HTTP; Mon, 24 Nov 2014 09:30:43 -0800 (PST)
In-Reply-To: <15567.1416835858@warthog.procyon.org.uk>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
        <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
        <15567.1416835858@warthog.procyon.org.uk>
Date:   Mon, 24 Nov 2014 09:30:43 -0800
X-Google-Sender-Auth: WSZ8a2SwKmKP0SxSp4DEK1DAHg4
Message-ID: <CA+55aFyhFfB52HCpnDeg0pbR-0=t=hsVjOACwnmMEQ=fhvaO2Q@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
X-archive-position: 44384
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

On Mon, Nov 24, 2014 at 5:30 AM, David Howells <dhowells@redhat.com> wrote:
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
>
>> +#define get_scalar_volatile_pointer(x) ({ \
>> +     typeof(x) *__p = &(x); \
>> +     volatile typeof(x) *__vp = __p; \
>> +     (void)(long)*__p; __vp; })
>> +#define ACCESS_ONCE(x) (*get_scalar_volatile_pointer(x))
>
> Might this cause two loads from memory under some conditions?  Once for the
> fourth line and once for the fifth?

Hmm. Since the fourth line isn't volatile, I'd expect gcc to optimize
it away. But you're right, it might be safer to make sure the "test
type" part is something like

   (void)sizeof((long)*__p)

instead - the "sizeof()" means that it will never actually get
evaluated, but the type-checking of casting *__p to (long) will still
catch the case of *__p being some non-scalar type that cannot be cast.

                   Linus
