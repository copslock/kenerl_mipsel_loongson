Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 21:28:59 +0200 (CEST)
Received: from mail-lb0-f173.google.com ([209.85.217.173]:35059 "EHLO
        mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010760AbaJGT2oOw-GH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 21:28:44 +0200
Received: by mail-lb0-f173.google.com with SMTP id 10so6771547lbg.18
        for <linux-mips@linux-mips.org>; Tue, 07 Oct 2014 12:28:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=23Bx2btoWbuieeZLGaVjvudNyqP9A6VRRI8GuAatTz0=;
        b=cW6kkFbWGb334w0j4ADzeyF+mur2AbwmmQdrDjKqbzmcH+Mm7y4aqEreVldyWNTULH
         mjT7xcwHXpks/EdIQwAwaPnKaxsygoY7yB7LhW9rcjy8MQE2E5UYOqsUi3QvB6BM9bEs
         yjNhPspREl33dq5zV6DjIki6nfa6IgHG1WHNARnOpxPHrizcDbkB4N5GOGAqNrJB6odN
         3bQNOn1qEZLDs/+CBHtpiVVgDMPo8dAyy8Jd6BfHhx+r1wO+EDoiVBTXND1U8SFHkbBI
         mdorouV4JTBFfhv+H7Tf1RP43KyD1cU8vx0rlcr8HQoXhTgaeUIMoiNce+D04ZyTRZEK
         rCcw==
X-Gm-Message-State: ALoCoQm1avaUfWfY4RIR+Re5qM4B/LOQqRq2SFZM2hsoc5llQW1ExXnRaoYkASdqDZTYhN7x4OM9
X-Received: by 10.112.183.233 with SMTP id ep9mr6048985lbc.56.1412710118712;
 Tue, 07 Oct 2014 12:28:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.152.36.106 with HTTP; Tue, 7 Oct 2014 12:28:18 -0700 (PDT)
In-Reply-To: <20141007192107.GN23797@brightrain.aerifal.cx>
References: <54332A64.5020605@caviumnetworks.com> <20141007000514.GD23797@brightrain.aerifal.cx>
 <543334CE.8060305@caviumnetworks.com> <20141007004915.GF23797@brightrain.aerifal.cx>
 <54337127.40806@gmail.com> <6D39441BF12EF246A7ABCE6654B0235320F1E173@LEMAIL01.le.imgtec.org>
 <543431DA.4090809@imgtec.com> <CALCETrUQEbb=DotSzsneN7Hano_eC-EoTMko6uKcyZXvEcktkw@mail.gmail.com>
 <20141007190943.GM23797@brightrain.aerifal.cx> <54343C2B.2080801@imgtec.com> <20141007192107.GN23797@brightrain.aerifal.cx>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 7 Oct 2014 12:28:18 -0700
Message-ID: <CALCETrU8qPL1qKGk7FqM=LCnoeSfuwDV_bG_a=5zcOKtWfkdGw@mail.gmail.com>
Subject: Re: [PATCH resend] MIPS: Allow FPU emulator to use non-stack area.
To:     Rich Felker <dalias@libc.org>
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        David Daney <david.s.daney@gmail.com>,
        David Daney <ddaney@caviumnetworks.com>,
        David Daney <ddaney.cavm@gmail.com>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        David Daney <david.daney@cavium.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43092
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

On Tue, Oct 7, 2014 at 12:21 PM, Rich Felker <dalias@libc.org> wrote:
> On Tue, Oct 07, 2014 at 12:16:59PM -0700, Leonid Yegoshin wrote:
>> On 10/07/2014 12:09 PM, Rich Felker wrote:
>> >I agree completely here. We should not break things (or, as it
>> >seems, leave them broken) for common usage cases that affect
>> >everyone just to coddle proprietary vendor-specific instructions.
>> >The latter just should not be used in delay slots unless the chip
>> >vendor also promises to provide fpu branch in hardware. Rich
>> And what do you propose - remove a current in-stack emulation and
>> you still think it doesn't break a status-quo?
>
> The in-stack trampoline support could be left but used only for
> emulating instructions the kernel doesn't know. This would make all
> normal binaries immediately usable with non-executable stack, and
> would avoid the only potential source of regressions. Ultimately I
> think the "xol" stuff should be removed, but that could be a long term
> goal.

Does anything break if the xol stuff is disabled for PT_GNU_STACK tasks?

>
> Rich



-- 
Andy Lutomirski
AMA Capital Management, LLC
