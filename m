Return-Path: <SRS0=8Koa=TQ=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3918C04AAF
	for <linux-mips@archiver.kernel.org>; Thu, 16 May 2019 14:05:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C7D920862
	for <linux-mips@archiver.kernel.org>; Thu, 16 May 2019 14:05:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="MhjOHc+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726995AbfEPOFN (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 16 May 2019 10:05:13 -0400
Received: from mail-ed1-f66.google.com ([209.85.208.66]:45021 "EHLO
        mail-ed1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfEPOFN (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 16 May 2019 10:05:13 -0400
Received: by mail-ed1-f66.google.com with SMTP id b8so5405429edm.11
        for <linux-mips@vger.kernel.org>; Thu, 16 May 2019 07:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bYyJnADr9ubhW5oaXdh9WlhTHjyzAGu0DQI2eQ+pHaE=;
        b=MhjOHc+12NO1kjqTg26hcfpFarWJK6UO4uKen3mnBZiVvgNz65ljzXS/ZRyK+jjEzc
         /JF15wWLnH7LRgIqtY0MD+nIanFGFyFhIksGgTJWi2bGoTMD18BMjjca67gxxRvxi8+0
         yQTTRxRIh7g2VDxBQ0zKZz1vXg1chuW2SN2qbepgb4FeuGMxhGooqxVI7+7FHAOj9N1M
         FHodeukkhZGpge8teMzG2zc9TJCjzMji+6KCaGF81DZdV6StlcqORhINQ4uQjbmc8vco
         TjK91z8PkXrFbRk1vdkCD5WKK6krFwmTdVA0wTPdFmhQ9BFoHPYiofHEVgNBJZi0CYJz
         Lvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bYyJnADr9ubhW5oaXdh9WlhTHjyzAGu0DQI2eQ+pHaE=;
        b=YiW4eDPbYNTmMgoCRNVzUYVzb8DkEcekJTvVbn2WyvjJLb9ZELePmmd96AXtMuos7r
         JJ8yMTF77if840hzqd83AoMjBKTLlkN97LWtNFGdMi23VWHanOIGtsbvbn7T9vG8+HZU
         hVcLJoW5p52Y3VHpRFOiNFSl0QdoYzl0IoEQioajjVn7xb9xxfgdoaL12GWQUaYvJkdY
         CnPaQGV5T4UunR44VdIGxIS5l4h180fTSTEgn7n7Tj6pYOzZP7YUVBt2vAOmBAQr9m4P
         aQZZ6JXgG00bFTor2AM69sxYgdKOyUAqzQ6oR/PtEuy4ed9EyZIc6h3zofR4YgVKLN0O
         IVPw==
X-Gm-Message-State: APjAAAUKZxTWB4ap0pKpNzm9EeL7e/lOnT3z0PTrwRgniJVWu0Z7Qvl3
        pDYfc5EENJoLoETzLrQSskv21w==
X-Google-Smtp-Source: APXvYqy/zkegU6awCybVYKMai3zZjnS7ZHStCqrWAP9elvrkEbm/ZCiD/6p0jcTly9aqPNEwI1KvNw==
X-Received: by 2002:a17:906:65d2:: with SMTP id z18mr20105763ejn.68.1558015510995;
        Thu, 16 May 2019 07:05:10 -0700 (PDT)
Received: from brauner.io ([193.96.224.243])
        by smtp.gmail.com with ESMTPSA id b53sm1120044edd.89.2019.05.16.07.05.09
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 16 May 2019 07:05:10 -0700 (PDT)
Date:   Thu, 16 May 2019 16:05:08 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Jann Horn <jannh@google.com>
Cc:     Daniel Colascione <dancol@google.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aleksa Sarai <cyphar@cyphar.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@amacapital.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-xtensa@linux-xtensa.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>
Subject: Re: [PATCH 1/2] pid: add pidfd_open()
Message-ID: <20190516140507.75crjbaulasw6mj6@brauner.io>
References: <20190515100400.3450-1-christian@brauner.io>
 <CAKOZuesPF+ftwqsNDMBy1LpwJgWTNuQm9-E=C90sSTBYEEsDww@mail.gmail.com>
 <20190516130813.i66ujfzftbgpqhnh@brauner.io>
 <CAG48ez05OtBi_yX+071TrrfK3zKOn9h1kFyPr5rttiqQAZ0sEA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAG48ez05OtBi_yX+071TrrfK3zKOn9h1kFyPr5rttiqQAZ0sEA@mail.gmail.com>
User-Agent: NeoMutt/20180716
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, May 16, 2019 at 04:03:27PM +0200, Jann Horn wrote:
> On Thu, May 16, 2019 at 3:08 PM Christian Brauner <christian@brauner.io> wrote:
> > On Wed, May 15, 2019 at 10:45:06AM -0700, Daniel Colascione wrote:
> > > On Wed, May 15, 2019 at 3:04 AM Christian Brauner <christian@brauner.io> wrote:
> > > >
> > > > This adds the pidfd_open() syscall. It allows a caller to retrieve pollable
> > > > pidfds for a process which did not get created via CLONE_PIDFD, i.e. for a
> > > > process that is created via traditional fork()/clone() calls that is only
> > > > referenced by a PID:
> [...]
> > > > +/**
> > > > + * pidfd_open() - Open new pid file descriptor.
> > > > + *
> > > > + * @pid:   pid for which to retrieve a pidfd
> > > > + * @flags: flags to pass
> > > > + *
> > > > + * This creates a new pid file descriptor with the O_CLOEXEC flag set for
> > > > + * the process identified by @pid. Currently, the process identified by
> > > > + * @pid must be a thread-group leader. This restriction currently exists
> > > > + * for all aspects of pidfds including pidfd creation (CLONE_PIDFD cannot
> > > > + * be used with CLONE_THREAD) and pidfd polling (only supports thread group
> > > > + * leaders).
> > > > + *
> > > > + * Return: On success, a cloexec pidfd is returned.
> > > > + *         On error, a negative errno number will be returned.
> > > > + */
> > > > +SYSCALL_DEFINE2(pidfd_open, pid_t, pid, unsigned int, flags)
> > > > +{
> [...]
> > > > +       if (pid <= 0)
> > > > +               return -EINVAL;
> > >
> > > WDYT of defining pid == 0 to mean "open myself"?
> >
> > I'm torn. It be a nice shortcut of course but pid being 0 is usually an
> > indicator for child processes. So unless the getpid() before
> > pidfd_open() is an issue I'd say let's leave it as is. If you really
> > want the shortcut might -1 be better?
> 
> Joining the bikeshed painting club: Please don't allow either 0 or -1
> as shortcut for "self". James Forshaw found an Android security bug a
> while back (https://bugs.chromium.org/p/project-zero/issues/detail?id=727)
> that passed a PID to getpidcon(), except that the PID was 0
> (placeholder for oneway binder transactions), and then the service
> thought it was talking to itself. You could pick some other number and
> provide a #define for that, but I think pidfd_open(getpid(), ...)
> makes more sense.

Yes, I agree. I left it as is for v1, i.e. no shortcut; getpid() should
do.

Christian
