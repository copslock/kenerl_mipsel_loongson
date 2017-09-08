Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 23:23:56 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:35781
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993948AbdIHVXuaFINj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 23:23:50 +0200
Received: by mail-oi0-x243.google.com with SMTP id p187so2238879oic.2
        for <linux-mips@linux-mips.org>; Fri, 08 Sep 2017 14:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=NARXulrieHfmaFRaIseULG/EGdMmVe1SSpnpFyDBZp4=;
        b=Q9CGA3PuBygygj1L61rexNkIld2vj/KIa+qQIb+E0OaYNuaBE/5uXH48BHlAGIfLG9
         fKCf4vIuPRFC4fmpFAVeDWW1WRpvuzU+rqFd/U7SJDbjyS+oe2K/D+SyaJ+jqS2OpfpQ
         EeObea+wOaB/9SgErk+US6kJeEN623d/qe46KoE02dyX+/YzwfPgXLW7lCyjocAVp3gs
         vx3VOX7ZqCz8SNile6waVAz2tLz4necr2cMZxQPzDY55DmWbpzfJqj9B+y8FXr3orC9t
         0RLbndgUbRlQsuPZUEk6WUNJPYqJtdf39OWhTYbyo69OqEnA1mZgFa4bih4OseDrKB/T
         GqOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=NARXulrieHfmaFRaIseULG/EGdMmVe1SSpnpFyDBZp4=;
        b=QJ8nAy0uvNEFewugqw9r0EGDoYMq5zObjEzGxJPlgLDjlXx/5Q9VnCg9C9H2WUjKIB
         0KqxdjsZa9F4Yyg5b4S5Oju6Hww+LItuikkxJQLZ/eMcvnWtLmM1aWTI7Le+e+g6c4V5
         t7/m/cT9GpIMViveRhOKxKUBHKgpwmmIBDwgdd+tk8y+pDekoe3ZQ5K1hArGbUZPko/M
         ts9YnuTsaX6gsb4+52HSx3OSTrl14NgMSXNWRQPeqG+1gqPJJ3GsfR6IIW2JkWNgYfiy
         caM6FzSL//+ynEmL3c7ZvKKVZoMJhmCuJki8kyltSuqQPhZjtuqnIDZ84+qsBmb1UDOn
         eHDA==
X-Gm-Message-State: AHPjjUgv/POIDzxYlBsbpN5RTYT/mqUGtUXKDqjumEHcN/StgKfxAZrA
        4GSPSvy0tBxtzjD6jOHzQvgCCVJXOQ==
X-Google-Smtp-Source: AOwi7QDmfEGe2vs/8CWwTRus0K3ebfaG2N4/gPnu6cjiMxV91jLyNxJIfxLyB2hHQE0MpeZ4MZ8ZVEXDLlgsK6cf73I=
X-Received: by 10.202.10.150 with SMTP id k22mr3752716oiy.84.1504905824102;
 Fri, 08 Sep 2017 14:23:44 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.59.207 with HTTP; Fri, 8 Sep 2017 14:23:23 -0700 (PDT)
In-Reply-To: <20170809000942.GV27873@wotan.suse.de>
References: <1500645920-28490-1-git-send-email-matt.redfearn@imgtec.com>
 <20170802001200.GD18884@wotan.suse.de> <20170809000942.GV27873@wotan.suse.de>
From:   Lucas De Marchi <lucas.de.marchi@gmail.com>
Date:   Fri, 8 Sep 2017 14:23:23 -0700
Message-ID: <CAKi4VA+11OV=28_uFa+JLY64oQ11+V8pF8eM5Y_Nx1UfCnAhCg@mail.gmail.com>
Subject: Re: [RFC PATCH] exec: Avoid recursive modprobe for binary format handlers
To:     "Luis R. Rodriguez" <mcgrof@kernel.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Mian Yousaf Kaukab <yousaf.kaukab@suse.com>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Jessica Yu <jeyu@redhat.com>, Michal Marek <mmarek@suse.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, Petr Mladek <pmladek@suse.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <lucas.de.marchi@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59967
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lucas.de.marchi@gmail.com
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

Hi,

On Tue, Aug 8, 2017 at 5:09 PM, Luis R. Rodriguez <mcgrof@kernel.org> wrote:
> On Wed, Aug 02, 2017 at 02:12:00AM +0200, Luis R. Rodriguez wrote:
>> On Fri, Jul 21, 2017 at 03:05:20PM +0100, Matt Redfearn wrote:
>> > diff --git a/fs/exec.c b/fs/exec.c
>> > index 62175cbcc801..004bb50a01fe 100644
>> > --- a/fs/exec.c
>> > +++ b/fs/exec.c
>> > @@ -1644,6 +1644,9 @@ int search_binary_handler(struct linux_binprm *bprm)
>> >             if (printable(bprm->buf[0]) && printable(bprm->buf[1]) &&
>> >                 printable(bprm->buf[2]) && printable(bprm->buf[3]))
>> >                     return retval;
>> > +           /* Game over if we need to load a module to execute modprobe */
>> > +           if (strcmp(bprm->filename, modprobe_path) == 0)
>> > +                   return retval;
>>
>> Wouldn't this just break having a binfmt used for modprobe always?
>
> The place where you put the check is when a system has CONFIG_MODULES
> and a first search for built-in handlers yielded no results so it would
> not break that for built-in.
>
> Thinking about this a little further, having an binfmd handler not built-in
> seems to really be the issue in this particular case and indeed having one as
> modular really just makes no sense as modprobe would be needed.
>
> Although the alternative patch I suggested still makes sense for a *generic
> loop detection complaint/error fix, putting this check in place and bailing
> still makes sense as well, but this sort of thing seems to be the type of
> system build error userspace could try to pick up on pro-actively, ie you
> should not get to the point you boot into this, the build system should somehow
> complain about it.
>
> Cc'ing linux-modules folks to see if perhaps kmod could do something about this
> more proactively.

Tracking at runtime with modprobe/libkmod would be really difficult as
a module can be loaded
from different sources. I don't see a reliable way to do that. One
thing often forgotten
is that due to install rules the user can even add anything as a
dependency with kmod not
even knowing about (softdep is related, but at least kmod knows what
the user is trying to do
and use it to handle dependencies).

For this particular case, not going through the modprobe helper would
be a way to accomplish that since
you wouldn't need the corresponding binfmt module to run modprobe.
Udev handles module
loading via libkmod , but the only way to trigger it is via the rules
rather than via a request from kernel.


Lucas De Marchi
