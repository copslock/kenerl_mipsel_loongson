Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 21:29:14 +0100 (CET)
Received: from mail-qc0-f171.google.com ([209.85.216.171]:51825 "EHLO
        mail-qc0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006926AbaKXU3Mz59fr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 21:29:12 +0100
Received: by mail-qc0-f171.google.com with SMTP id r5so7401070qcx.2
        for <linux-mips@linux-mips.org>; Mon, 24 Nov 2014 12:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=scob5BDUt5qB1WPUyTXTKOXgmXn9coKraDO2BVG1uFA=;
        b=J1/NI25i8eGCewsTi1pcXBDm4kFuIbyLgcdPAhsAo+99h13xa5hBNORuQ1ag+5dC0d
         PWj/WYEAzPvMKrdC2T7JUmahKxMDqkGKB1GgC8AY+judr0KP8m7Wie7uVhAIQOo1HiRB
         LzDVKF+08sct5/5n0NoSN+SG7IQK9xYzwmPwlFfjV5NNuNsqOohTsw3A7fHyshnAiQUP
         C0Ta0CLCdN4OzM9bEreoW3znOJF2O2g60w6PKvw5/k/SSLA+nczz8htatP3JGp7Tl+16
         0GL4HYAj2PeZKOlBLBtX1VSZjd35D0Yy5iCm5qUeVX5C4L5OCPXrZbcDT+ijU9tiPRE8
         7fpw==
MIME-Version: 1.0
X-Received: by 10.224.120.67 with SMTP id c3mr31823696qar.3.1416860947385;
 Mon, 24 Nov 2014 12:29:07 -0800 (PST)
Received: by 10.96.89.33 with HTTP; Mon, 24 Nov 2014 12:29:07 -0800 (PST)
Date:   Mon, 24 Nov 2014 12:29:07 -0800
Message-ID: <CAADnVQJ6eXGiasoQwyAzuejLncEHdy6MOf+m3AHnpjgn0h3+OQ@mail.gmail.com>
Subject: Re: [PATCH/RFC 7/7] kernel: Force ACCESS_ONCE to work only on scalar types
From:   Alexei Starovoitov <alexei.starovoitov@gmail.com>
To:     Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
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
X-archive-position: 44401
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

On Mon, Nov 24, 2014 at 11:07 AM, Christian Borntraeger
<borntraeger@de.ibm.com> wrote:
>
> Anyone with a new propopal? ;-)                                        ^

one more proposal :)
#define __ACCESS_ONCE(x) ({ typeof(x) __var = 0; (volatile typeof(x) *)&(x); })
#define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))

works as lvalue...
the basic idea is the same:
constant zero can be used to initialize any scalar
(including pointers), but unions and structs will fail to compile as:
"error: invalid initializer"

If I'm reading pr58145 gcc bug report correctly, it
miscompiles only structs, so we can let ACCESS_ONCE
to work on unions. Then the following will rejects structs only:
#define __ACCESS_ONCE(x) ({ (typeof(x))0; (volatile typeof(x) *)&(x); })
#define ACCESS_ONCE(x) (*__ACCESS_ONCE(x))
