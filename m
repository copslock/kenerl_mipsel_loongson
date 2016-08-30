Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Aug 2016 23:45:42 +0200 (CEST)
Received: from mail-ua0-f174.google.com ([209.85.217.174]:36473 "EHLO
        mail-ua0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992009AbcH3Vpd2fGcB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 30 Aug 2016 23:45:33 +0200
Received: by mail-ua0-f174.google.com with SMTP id m60so56624072uam.3
        for <linux-mips@linux-mips.org>; Tue, 30 Aug 2016 14:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=F6POe9n2rp+KU3kkrhZuiR3HHwxv9Az5u7b6K7/u/oQ=;
        b=d8i5gSfna7B4FePvnRn/yFoe/7W5TBjeYYFYVu91rVr3ZsWTAg9+QO04Obj+mW4H8D
         6bfx9vb1FATlB4EKYo+mFFAR3hz1iNDqo21iZrdnzbEII7beyp8zedd9FM0ugHZ3MBTl
         oSDHhhsRhJnYUe1Z4QF8XXyT1JNipnTajn0GWMCanwYFMzXF2wqU+UTV+0NdjgzX8oqw
         wkUH2P1IXg4JVUf6aLeGkFvcgimZA1FfIvcFrnIz7R8cbc+Az0wkj3ySqeeFc6YX/sxy
         II9WwX08LKUFkqKz4vNn768H+PHcV+qfwzl30IxvLtbJlBTI8rpRZx+Vvdy+qKX0ahAo
         vyYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=F6POe9n2rp+KU3kkrhZuiR3HHwxv9Az5u7b6K7/u/oQ=;
        b=gZUSbs3E8YrazXX65JFTfp8CWp7cbbr2U/Dk/RxH19W3mpQKWV9PVppQ4fFaRIInjX
         OvoqdIUShUVj3u/fb2IRWHkvz9dezgzFgYkIAEOBLPqU2a86wEktc8WRj7FN60jacR9s
         FzCRZdO5SqzXVVi6APkbb4zTM3juTh66Xq/koPwL9wz9s6cLYjsFhMddJjrUUE1SlcPj
         ebLh4Y0mH9JEIJYxvN09/bXLRPERPVRoL3jsu2zrJGGqp00wa8jH0pScnCkrUvaas9EC
         rGE+4NoUwRLrv5SfowZpVTNp4QojMr/B1l54BzKtjS8CHvHVx2f/a5xrum3/pBvamVpN
         fsUw==
X-Gm-Message-State: AE9vXwOuh7GuJepdhNQ39PRFEIH2HWTExlKTLE0fXvq7RmgXqNoQ6l+SkEcIO91e6U0vOmgQZZ+R1rCCFZMkY7tt
X-Received: by 10.176.82.249 with SMTP id w54mr3522595uaw.98.1472593525558;
 Tue, 30 Aug 2016 14:45:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.103.76.146 with HTTP; Tue, 30 Aug 2016 14:45:05 -0700 (PDT)
In-Reply-To: <20160830165830.5e494c43@gandalf.local.home>
References: <1472463007-6469-1-git-send-email-marcin.nowakowski@imgtec.com>
 <CALCETrW1m9ozck-ugX6AKnL7oNA8rvMTjhFGqtVSvKL9BMXMZA@mail.gmail.com>
 <f40020e1-200c-f113-5174-5fe4d4c000dc@imgtec.com> <CALCETrWy5cUDJmTVrjSSqWHc4KyxTPjoD7yU7iqTSHfkK4UwvA@mail.gmail.com>
 <20160830152955.17633511@gandalf.local.home> <CALCETrXA0XbYuqYzWMJA+KjFS31YL0cTVtrvCnmRY_GMK6oNpw@mail.gmail.com>
 <20160830165830.5e494c43@gandalf.local.home>
From:   Andy Lutomirski <luto@amacapital.net>
Date:   Tue, 30 Aug 2016 14:45:05 -0700
Message-ID: <CALCETrW_bnmqBRp3qWoaWUu=m7Bi19VcH9kMBifyL06JuGGVzg@mail.gmail.com>
Subject: Re: [PATCH 1/2] tracing/syscalls: allow multiple syscall numbers per syscall
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Linux API <linux-api@vger.kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        open list <linux-kernel@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <luto@amacapital.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54872
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

On Aug 30, 2016 1:58 PM, "Steven Rostedt" <rostedt@goodmis.org> wrote:
>
> On Tue, 30 Aug 2016 12:53:53 -0700
> Andy Lutomirski <luto@amacapital.net> wrote:
>
>
> > Egads!  OK, I see why this is a mess.
>
> :-)
>
> >
> > I guess we should be creating the metadata from the syscall tables
> > instead of from the syscall definitions, but I guess that's currently
> > a nasty per-arch mess.
>
> Yep.
>

I wonder: could more of it be dynamically allocated?  I.e. statically
generate metadata with args and name and whatever but without any nr.
Then dynamically allocate the map from nr to metadata?

> >
> > Could we at least have an array of (arch, nr) instead of just an array
> > of nrs in the metadata?
>
> I guess I'm not following you on what would be used for "arch".

Whatever syscall_get_arch() would return for the syscall.  For x86,
for example, most syscalls have a compat nr and a non-compat nr.  How
does tracing currently handle that?

--Andy
