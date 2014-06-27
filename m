Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jun 2014 22:08:49 +0200 (CEST)
Received: from mail-lb0-f182.google.com ([209.85.217.182]:60004 "EHLO
        mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859959AbaF0UIqdGW7p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Jun 2014 22:08:46 +0200
Received: by mail-lb0-f182.google.com with SMTP id c11so4245376lbj.41
        for <linux-mips@linux-mips.org>; Fri, 27 Jun 2014 13:08:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=iKHGe7AnI5PW99ucn2ysx7l/YB0EoJaksBXUvumoJkg=;
        b=IN0FPD9GOA34UfBwD6XIQ9ba4klykVBknwk4sMGaxVyklimUZv6WZY4xK+02+aTY4l
         NqRfw4G43HDb6gAcCqmFBL2O3AVF1bgnjBP4keFrSB6xpvTbJxNxPX+uwiaqKIkUoIxG
         ynthY5ryZOHPS6CpL760JlT7+wUt37ScGYaD/jKmHmBwkSQ3/+KSLH9Kl2271+t6bJ6s
         89B4G1lX1Gjn2+xS0rDO4/skg0G71zgI4tMYmeEy/pOof4MAE5UkyBFC1k+KYTBc9xqa
         v19vaFlHvvliU4DLmTjh6/ECAMhYK4t6VbNZ0eycITGesLGPA5/hrVqg7tEeD7KDzYFN
         7cYA==
X-Gm-Message-State: ALoCoQnFthPOUn31lLr8AphHD4ryOEQ6RBbJFP7bgXmMQvOGvkfG2F8C7/BvUQLfX6BSh5Myo8Ee
X-Received: by 10.153.6.37 with SMTP id cr5mr17843872lad.7.1403899720641; Fri,
 27 Jun 2014 13:08:40 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.108.130 with HTTP; Fri, 27 Jun 2014 13:08:20 -0700 (PDT)
In-Reply-To: <20140627195559.GA31661@redhat.com>
References: <CAGXu5j+J11zJnuFR8bYKAXizAHhCx4R+uJE_QH6zC3q2udkpaQ@mail.gmail.com>
 <CALCETrVrs8sb19+UUqyFEpAFzTih5dkAwn-WpQjfgPcPJMpP5g@mail.gmail.com>
 <20140625173245.GA17695@redhat.com> <CALCETrUc65H+fn6dtMdYnB_xR39wcmgDdTbdR3fFRjyrndJhgA@mail.gmail.com>
 <20140625175136.GA18185@redhat.com> <CAGXu5jL17k6=GXju6x+eLU20FMwBHhnuRiHoQD1Bzj_EmpiKjg@mail.gmail.com>
 <CALCETrVNwhWSPNiBiZmgP1nD9zLJPTk6cH0yo=85rbxTPTYFRg@mail.gmail.com>
 <CAGXu5jLavA8FJD8m-1y4wO0uzh3qvvMmajAg0Lrr1Cn_Om3a3w@mail.gmail.com>
 <20140627192753.GA30752@redhat.com> <CALCETrVbJqfG6oBaZEjj7H3pPa1oVJx6QXAYc5zZ6o-niV=WKQ@mail.gmail.com>
 <20140627195559.GA31661@redhat.com>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Fri, 27 Jun 2014 13:08:20 -0700
Message-ID: <CALCETrUxGbTet--zJiKX4BqbOaw2MDBPqT18HaQOdf7zwWWtEw@mail.gmail.com>
Subject: Re: [PATCH v8 5/9] seccomp: split mode set routines
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40881
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

On Fri, Jun 27, 2014 at 12:55 PM, Oleg Nesterov <oleg@redhat.com> wrote:
> On 06/27, Andy Lutomirski wrote:
>>
>> On Fri, Jun 27, 2014 at 12:27 PM, Oleg Nesterov <oleg@redhat.com> wrote:
>> > On 06/27, Kees Cook wrote:
>> >>
>> >> It looks like SMP ARM issues dsb for rmb, which seems a bit expensive.
>> >> http://infocenter.arm.com/help/index.jsp?topic=/com.arm.doc.dui0204g/CIHJFGFE.htm
>> >>
>> >> ...
>> >>
>> >> I really want to avoid adding anything to the secure_computing()
>> >> execution path. :(
>> >
>> > I must have missed something but I do not understand your concerns.
>> >
>> > __secure_computing() is not trivial, and we are going to execute the
>> > filters. Do you really think rmb() can add the noticeable difference?
>> >
>> > Not to mention that we can only get here if we take the slow syscall
>> > enter path due to TIF_SECCOMP...
>> >
>>
>> On my box, with my fancy multi-phase seccomp patches, the total
>> seccomp overhead for a very short filter is about 13ns.  Adding a full
>> barrier would add several ns, I think.
>
> I am just curious, does this 13ns overhead include the penalty from the
> slow syscall enter path triggered by TIF_SECCOMP ?

Yes, which is more or less the whole point of that patch series.  I
rewrote part of the TIF_SECCOMP-but-no-tracing case in assembly :)

I'm playing with rewriting it in C, but it's looking like it'll be a
bit more far-reaching than I was hoping.

--Andy
