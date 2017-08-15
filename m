Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Aug 2017 09:04:51 +0200 (CEST)
Received: from mail-vk0-x242.google.com ([IPv6:2607:f8b0:400c:c05::242]:35941
        "EHLO mail-vk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991359AbdHOHEpQh21t (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Aug 2017 09:04:45 +0200
Received: by mail-vk0-x242.google.com with SMTP id z187so53697vkd.3;
        Tue, 15 Aug 2017 00:04:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=z5E00vWASaBkWEFfoo5XoewxSW8TUJLrbLeW5Lk/8+8=;
        b=qLa5DQopD+IV5pl373rGy7KrBCGDCrdIgD9Mvbd2EgOE6QAEjQmBs8ltvC5CVdhSOa
         kfTKD78X6RAfzJCjiNX7v2BmEa/Y3Ov7OZBc/V3Lwz6OConzTdK1w52o/Zcwnhof2yoe
         EhbRYbn2N1hgMwBdLW8Ao5c6ckkqwcrzkaixk1dyPTCvN5Fcid0P9lHckoaloFtLHBwb
         crO3iqdJBHTWvNgpfCy7IV6qGC0sxK7UjgTi6JoDpttG83sPYd9vBTGyi18q8JGnXqxO
         FkwvugPi+f6MXnhqnIESPRTueyhGurkeV12sIuto/6+H2wpI0Bvdy1gRUb2Z/uGK53bF
         o8fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=z5E00vWASaBkWEFfoo5XoewxSW8TUJLrbLeW5Lk/8+8=;
        b=Roc/eBIkXXY5zE2or09OolT/xdJ5f8wYUSA12nmUEIRXnAaSeB+raiQ1bEfGgx9eDh
         4WKco8C71Eap2PSjKStDNApeyDVQCL2DkBOVNwm+JsqYQ6mP8t1oDCEQJCgW9kfg2FoV
         LYI5dMK8a5y0T2Fj8P0eRxCJnsxJr2/dAvEAv1zGRVLJHnqJi5XWkjS1BZFZRXTKnemW
         afEyCKrg9971CepZcv7yA+y/Qqjj3O/7/hwaykOKKKw3UlBhYkdMJOFQUtuSHaXSOuYZ
         PcJb8vhk5EW8bvr/D6F0Fk4hcakD+O71hR0yAgYGvXYimmDityfMr5mWgHkUYG5wwWW0
         AFJQ==
X-Gm-Message-State: AHYfb5gQGN66JryxoF4boB514jtbJ72jo5m6WMLAEQ+mDt9RN27z6JIN
        usGAQOYjaImKbzlwx/zMEL5NObSMAg==
X-Received: by 10.31.155.193 with SMTP id d184mr15067563vke.141.1502780679529;
 Tue, 15 Aug 2017 00:04:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.31.169.5 with HTTP; Tue, 15 Aug 2017 00:03:59 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1708141210580.17596@tp.orcam.me.uk>
References: <20170814102148.397474-1-manuel.lauss@gmail.com> <alpine.DEB.2.00.1708141210580.17596@tp.orcam.me.uk>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Tue, 15 Aug 2017 09:03:59 +0200
Message-ID: <CAOLZvyGj7QynWuN+oJTtvJzrHyJv-3AoUbj6juWY6W15Ff5AcA@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: math-emu: do not use bools for arithmetic
To:     "Maciej W. Rozycki" <macro@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Mon, Aug 14, 2017 at 1:25 PM, Maciej W. Rozycki <macro@imgtec.com> wrote:
> On Mon, 14 Aug 2017, Manuel Lauss wrote:
>
>> ---
>> v2: just use xor, as suggested by Maciej.  No size changes this time, but still
>> untested due to lack of hardfloat userland.
>
>  D'oh, I was wondering what you meant by writing: "binary size reduction"
> and didn't get that you meant a size reduction of the binary object file
> produced rather than a transformation made by the compiler to the binary
> expression used.  That looks odd indeed -- have you tried comparing the
> output from `objdump -d' with and without the original patch applied?
>
>  Your change looks obviously correct to me, however I can push it through
> GCC and/or glibc IEEE 754 math regression testing if it'll make you feel
> more confident about it.

No need.  I've updated to gcc-7.2 and the differences are gone, the binary
cp1emu.o created with and without this patch are completely identical.

Thanks!
     Manuel
