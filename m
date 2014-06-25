Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 19:55:19 +0200 (CEST)
Received: from mail-qg0-f51.google.com ([209.85.192.51]:37306 "EHLO
        mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6859932AbaFYRzPkdb8L (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Jun 2014 19:55:15 +0200
Received: by mail-qg0-f51.google.com with SMTP id z60so2014276qgd.10
        for <linux-mips@linux-mips.org>; Wed, 25 Jun 2014 10:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gDN2q5MRv7anjTqhgj8so5gSVzJCFuf3+I387bR8Nuc=;
        b=cEfQKf7vE2m2qsoCXexf8ot95LfabiuZrliFd/6MwdBpo+nCy1AVgO2iHsWcoiuqP8
         xOdO390AIUl2yKP96zQI6+ecvrZG2YdUqshbHbUGmdrVyaRPzhyF7z79er953l/b7Idc
         u09WiMAcepyncR42+a1tLoBBAkrSIT7SV/dYG2Tdq9Qw9DcqR4P1NZ3vkdTYanRqB0MF
         vxc34D2fGT2bLp5fkqh75twQ7pvFfT4v+Dc19vp232uBzHmqVYDQLkuzrgCaXDJBeFpb
         LRbGCvLJNOMePHr+W7kVp4dG7V9g8Vpt2RsNAS9li8W5xZ5eX080w8dHbGp50wYAkDKE
         Sy2g==
X-Received: by 10.140.94.225 with SMTP id g88mr12962699qge.101.1403718909838;
 Wed, 25 Jun 2014 10:55:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.102.147 with HTTP; Wed, 25 Jun 2014 10:54:49 -0700 (PDT)
Reply-To: mtk.manpages@gmail.com
In-Reply-To: <CAGXu5j+99NOtJq2-TWYm8mwNw1ki0y3rRH21wX66MVM8=jz1bQ@mail.gmail.com>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <20140624205615.GW5412@outflux.net> <20140625140440.6870eac1@alan.etchedpixels.co.uk>
 <CAGXu5j+99NOtJq2-TWYm8mwNw1ki0y3rRH21wX66MVM8=jz1bQ@mail.gmail.com>
From:   "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Date:   Wed, 25 Jun 2014 19:54:49 +0200
Message-ID: <CAKgNAkgU+igKYKtzk3u83ZTcR-ov7kq_J9mbTeHuOt7Zkbpy6Q@mail.gmail.com>
Subject: Re: [PATCH v8 1/1] man-pages: seccomp.2: document syscall
To:     Kees Cook <keescook@chromium.org>
Cc:     One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Andy Lutomirski <luto@amacapital.net>,
        Alexei Starovoitov <ast@plumgrid.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Daniel Borkmann <dborkman@redhat.com>,
        Will Drewry <wad@chromium.org>,
        Julien Tinnes <jln@chromium.org>,
        David Drysdale <drysdale@google.com>,
        Linux API <linux-api@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, linux-mips@linux-mips.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-security-module <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mtk.manpages@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40826
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mtk.manpages@gmail.com
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

On Wed, Jun 25, 2014 at 5:10 PM, Kees Cook <keescook@chromium.org> wrote:
> On Wed, Jun 25, 2014 at 6:04 AM, One Thousand Gnomes
> <gnomes@lxorguk.ukuu.org.uk> wrote:
>> On Tue, 24 Jun 2014 13:56:15 -0700
>> Kees Cook <keescook@chromium.org> wrote:
>>
>>> Combines documentation from prctl, in-kernel seccomp_filter.txt and
>>> dropper.c, along with details specific to the new syscall.
>>
>> What is the license on the example ? Probably you want to propogate the
>> minimal form of the text in seccomp/dropper into the document example to
>> avoid confusion ?
>
> What is the license of the other code examples in man-pages?

Typically, just the same as the rest if the page text. Perhaps that
should be rethought for future examples. I haven't thought about it at
length, but, at first glance, I'm not against having separate licenses
for the page text and the code sample.

Cheers,

Michael

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Linux/UNIX System Programming Training: http://man7.org/training/
