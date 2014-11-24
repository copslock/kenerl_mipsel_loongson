Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 21:19:18 +0100 (CET)
Received: from mail-qa0-f49.google.com ([209.85.216.49]:57018 "EHLO
        mail-qa0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006927AbaKXUTRE0VNu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 21:19:17 +0100
Received: by mail-qa0-f49.google.com with SMTP id s7so6887141qap.36
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 12:19:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oJLHL+hTwB6xvorEaKsqY61V3PsjTuS3NufraGhrGFs=;
        b=xAL7NdsDjwO48WQ/20KLKsLuUtz4R+jNrmMQBRvlWFYyy4gKJf2VOWAjA5V3i36VhX
         WujRsAwgpWwnaANs82nHSc4o/mr7TuyY66XE3l/cCS95bGzydG7uDF9hSe2LylKA+H1g
         Q12fHnqaEn/7MynaoE77lkRfI8uknsELD9ngLje+K0BjHz8ro8k6KkbOju1tgXkTglCO
         PzQt3UeKHFfFr8SO47uEigjBmzUwriMBj1dD6riIDXO/pTicXm2l0AYpdwZgn//Gz/aj
         NDZhcLgovonYcbBt/4rPxlTsqtUTHzlUDTjwjzJn1es4St1znwvZrDId00Lx2zcjyBFG
         Z4qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=oJLHL+hTwB6xvorEaKsqY61V3PsjTuS3NufraGhrGFs=;
        b=Tz6yQIM2t+/Xl52QOSQRkW7loQ2YzXpQB7++RzTqgRBbL75TtCkABGVF3DdbUN5Gqe
         XCf9FZk6rGSl0MCAcOFHor4u81U6yb3f3dYAUe72azF5K2AqgB293Y5J7KAEsoKkFMyz
         +wFO5ogTfiOQXQPYnDtP9HnpWJ5tjzuNn8PJA=
MIME-Version: 1.0
X-Received: by 10.229.111.201 with SMTP id t9mr31321661qcp.9.1416860351255;
 Mon, 24 Nov 2014 12:19:11 -0800 (PST)
Received: by 10.140.39.170 with HTTP; Mon, 24 Nov 2014 12:19:11 -0800 (PST)
In-Reply-To: <20141124194200.GR5050@linux.vnet.ibm.com>
References: <1416834210-61738-1-git-send-email-borntraeger@de.ibm.com>
        <1416834210-61738-8-git-send-email-borntraeger@de.ibm.com>
        <15567.1416835858@warthog.procyon.org.uk>
        <CAADnVQJQydX9OU_rem+BObR0eWc-jrrwirUYVKH9rnN=Z8LG6A@mail.gmail.com>
        <CA+55aFxc72VsGTw4yFdeC1Sq65RUjYLKPD1ORnXB2d18WBMzvg@mail.gmail.com>
        <547381D7.2070404@de.ibm.com>
        <CA+55aFy+dunTcdgB4-BXsYiLDk9pf8b_L74ky-dMixpbX3JQQA@mail.gmail.com>
        <20141124194200.GR5050@linux.vnet.ibm.com>
Date:   Mon, 24 Nov 2014 12:19:11 -0800
X-Google-Sender-Auth: S40EyHyVWG8YXdrYPWklmHtLI0k
Message-ID: <CA+55aFwJEqMv00zkwHmp_LOg74RU3e30-oo6RaYb=yGjgGr2cg@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Linus Torvalds <torvalds@linux-foundation.org>
To:     Paul McKenney <paulmck@linux.vnet.ibm.com>
Cc:     Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        David Howells <dhowells@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-mips <linux-mips@linux-mips.org>,
        linux-x86_64@vger.kernel.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus971@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44400
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

On Mon, Nov 24, 2014 at 11:42 AM, Paul E. McKenney
<paulmck@linux.vnet.ibm.com> wrote:
>
> OK, how about the following?

Ugh. Disgusting.

Why the heck isn't it just "sizeof(*__vp) <= sizeof(long)"?

If the architecture has a 3-byte scalar type, then it probably has a
3-byte load.

> It complains if the variable is too large, for example, long long on
> 32-bit systems or large structures.  It is OK loading from and storing
> to small structures as well, which I am having a hard time thinking of
> as a disadvantage.

.. but that's *exactly* the gcc bug in question. It's a word-sized
struct that gcc loads twice.

                          Linus
