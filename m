Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Aug 2017 04:28:34 +0200 (CEST)
Received: from mail-it0-x231.google.com ([IPv6:2607:f8b0:4001:c0b::231]:35961
        "EHLO mail-it0-x231.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990510AbdHBC21Z4nFD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Aug 2017 04:28:27 +0200
Received: by mail-it0-x231.google.com with SMTP id 77so17006058itj.1
        for <linux-mips@linux-mips.org>; Tue, 01 Aug 2017 19:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HPMOGuXU4RwQKFNCXFLkGgfSfuUtuzX/ZiBHJ2xtVB8=;
        b=oTlFjJvjQqcviQd/CiubJHl/HKcuAPbtm3CFRbG4iTmjQxiO9ZdLUw+iTMLvXX7U6N
         +fy4I8CF3G6ZEbR8GoFkNXJnfsSeyT637Lf8yd04Nlfo7C/2cFePauKc4LrrCpKJREaF
         QGdgUfx05FLy3u/dC4SQAhJNvl80MKAWYjPZd61yjPUAtNCbWXFUzRf2xgEGKe8zU39t
         UYdFEzEOHF7dTfB7YemF9OpKPYNv0i+p7PcPKXKTH22Ir3ulIB9/6AjPGefn8n5I8TXe
         1mBFtG1GRbdoicnizBRpXnhbCcvk57WkioaO7aJUF/AJc2lMgSD/SRUiHs/2tTD+E8hS
         Bm+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=HPMOGuXU4RwQKFNCXFLkGgfSfuUtuzX/ZiBHJ2xtVB8=;
        b=jbbwEyN5F+HjgkR3e+MO58GyGtISyLQyjarfnKcFh9B8ZVKTBYWmiMup8kDSogVDTt
         rV0lhdiXUZ6DxXh5/eRCt/D3L07lacHOypnmaNC92+I5fwrf12Il+zouWD8KTWgBO6vo
         7oQNiVodRJoUTliZl4SVba5b92fMd3zx70i3w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=HPMOGuXU4RwQKFNCXFLkGgfSfuUtuzX/ZiBHJ2xtVB8=;
        b=aP/N3gsh1A9B/ew6t3dpvPEgN0JRgibjzNAyUotXVeQeIOTjL+BQJpdOLtcOsctbco
         Jk/d9IDMgfRUJNKq3uy1aVzBt3U3whfn+19gKZrBPDkDY7UCJ1Olx85sKftoA7HIXCwq
         GwB7TUiistKvvMFpDO+FmTb22CDDgpfN3FDqAO4CgODdFyZTOQxEhtpiZlfuRCJoYcb0
         MQWEOntFosAO9h+13ACswRVpRQYlkuQPUiItIMCkA0wUVC9zlcon8QUHR935oUaBMloB
         SSFWTMENyQmTN2LbD7m/djnxlR5cvCTKKCwc1vemaC+HpF+B31cYGG+AqpSM3JgDWID0
         b9ug==
X-Gm-Message-State: AIVw112GC8YDARhKYOD7q5iceH78cmNV5PGe7ho8lmPI8Jsacx1ntKRf
        mkd+ehArl8H8V3PP71bH2iebGUkOm5wY
X-Received: by 10.36.159.194 with SMTP id c185mr3929811ite.31.1501640901435;
 Tue, 01 Aug 2017 19:28:21 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.138.161 with HTTP; Tue, 1 Aug 2017 19:28:20 -0700 (PDT)
In-Reply-To: <20170802001200.GD18884@wotan.suse.de>
References: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com> <20170802001200.GD18884@wotan.suse.de>
From:   Kees Cook <keescook@chromium.org>
Date:   Tue, 1 Aug 2017 19:28:20 -0700
X-Google-Sender-Auth: QFfyy-ULnxRcYGEzg629qef_yn8
Message-ID: <CAGXu5jJw74M0hTL8JGUtshgZpGjzWia2d=oK3t8oJF6qo9Xp_A@mail.gmail.com>
Subject: Re: [RFC PATCH] exec: Avoid recursive modprobe for binary format handlers
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Jessica Yu <jeyu@redhat.com>, Michal Marek <mmarek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Petr Mladek <pmladek@suse.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <keescook@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: keescook@chromium.org
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

On Tue, Aug 1, 2017 at 5:12 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Fri, Jul 21, 2017 at 03:05:20PM +0100, Matt Redfearn wrote:
>> Commit 6d7964a722af ("kmod: throttle kmod thread limit") which was
>> merged in v4.13-rc1 broke this behaviour since the recursive modprobe is
>> no longer caught, it just ends up waiting indefinitely for the kmod_wq
>> wait queue. Hence the kernel appears to hang silently when starting
>> userspace.
>
> Indeed, the recursive issue were no longer expected to exist.

Errr, yeah, recursive binfmt loads can still happen.

> The *old* implementation would also prevent a set of binaries to daisy chain
> a set of 50 different binaries which require different binfmt loaders. The
> current implementation enables this and we'd just wait. There's a bound to
> the number of binfmd loaders though, so this would be bounded. If however
> a 2nd loader loaded the first binary we'd run into the same issue I think.
>
> If we can't think of a good way to resolve this we'll just have to revert
> 6d7964a722af for now.

The weird but "normal" recursive case is usually a script calling a
script calling a misc format. Getting a chain of modprobes running,
though, seems unlikely. I *think* Matt's patch is okay, but I agree,
it'd be better for the request_module() to fail.

-Kees

-- 
Kees Cook
Pixel Security
