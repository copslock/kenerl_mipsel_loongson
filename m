Return-Path: <SRS0=RX9m=TV=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EA06C04E87
	for <linux-mips@archiver.kernel.org>; Tue, 21 May 2019 13:04:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 24DC4217D4
	for <linux-mips@archiver.kernel.org>; Tue, 21 May 2019 13:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="XJSG1EyP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbfEUNEo (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Tue, 21 May 2019 09:04:44 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:33998 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728273AbfEUNEo (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Tue, 21 May 2019 09:04:44 -0400
Received: by mail-wr1-f67.google.com with SMTP id f8so12144692wrt.1
        for <linux-mips@vger.kernel.org>; Tue, 21 May 2019 06:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=UoeHu3yoNUcPPl9PKQVlxSlKB7SL3/RQXELHWxMzhXU=;
        b=XJSG1EyPYqVFv06qjxl82rQK6DnXz+zzZ5SuDKstpUJiXRNS8tQ5JU13/0R23pzYo8
         CBflOikG7l96+4gPyOlywhufFiPRmoYNDl41896XQ/0MJatuwnRejMHB6TDC98rsUSsk
         2AmSYFgAwYwyiIa3Uw0OG4PN7UgonE+wdbkLG/dhBH8kdQoOGpBbAw+wyKcjrVvNwBmM
         VMKMZI30ibz9pqFsG/Cn36t1s2Pm2QH0dtNNkeKYHL7aO5r+71RV9j9Ohu/+y3mncQUm
         NMgjzNYEt1ik5sf8wphXNVOj5VnbG86Jclu6wpcMm3hVcqUXQ13o2yCTql/kibMeVk3R
         6GZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=UoeHu3yoNUcPPl9PKQVlxSlKB7SL3/RQXELHWxMzhXU=;
        b=ZuPiF0g36iYIg3sX48/UeOF0OiFM394Nw0ITL20yBUiCB6nOGgCA6RIjeNauvaX/9L
         LYxKVH2v1opMOzwAAhPEa3dPGk0ZgkDO82awWDwE9qexiPgy0mdWgolSziDQ2zywsn69
         gI44lf9rCzZbwGNlx9oEbqEEECZCH2qHtNf8fx0MTIaBRkA6zdAsjUinGKfnjAOkuW8J
         MpMj2dnE6s9iJbp0fYjPQhfFRwBh+Z3KVyf542Or8hJC0RppwS/5Y7FBFl8ryAAhwClO
         reccBrIJdxQj0zGaXrUxhswo7y8KRXOc3IW7JxU2FkkzX/lyXYexCM3an91pxZdD3xsl
         /NQw==
X-Gm-Message-State: APjAAAVZrCWytS6vcddsyRAKCaK9apyom3OH67C4L75jSkUYmHmsx7HL
        rdwn76TJ/N6rmUfZ5eZZeSkyug==
X-Google-Smtp-Source: APXvYqxG2D4TpRJtgA1by9C5SwilBq6kPP4Jw28l+Fw52p05f/l2TsKOiCci80kJtWr6XsY8G818bQ==
X-Received: by 2002:a5d:6b12:: with SMTP id v18mr34420146wrw.306.1558443882738;
        Tue, 21 May 2019 06:04:42 -0700 (PDT)
Received: from brauner.io (p548C9938.dip0.t-ipconnect.de. [84.140.153.56])
        by smtp.gmail.com with ESMTPSA id x64sm5789182wmg.17.2019.05.21.06.04.41
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Tue, 21 May 2019 06:04:42 -0700 (PDT)
Date:   Tue, 21 May 2019 15:04:39 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Florian Weimer <fweimer@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        jannh@google.com, oleg@redhat.com, tglx@linutronix.de,
        torvalds@linux-foundation.org, arnd@arndb.de, shuah@kernel.org,
        dhowells@redhat.com, tkjos@android.com, ldv@altlinux.org,
        miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH 1/2] open: add close_range()
Message-ID: <20190521130438.q3u4wvve7p6md6cm@brauner.io>
References: <20190521113448.20654-1-christian@brauner.io>
 <87tvdoau12.fsf@oldenburg2.str.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87tvdoau12.fsf@oldenburg2.str.redhat.com>
User-Agent: NeoMutt/20180716
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Tue, May 21, 2019 at 02:09:29PM +0200, Florian Weimer wrote:
> * Christian Brauner:
> 
> > +/**
> > + * __close_range() - Close all file descriptors in a given range.
> > + *
> > + * @fd:     starting file descriptor to close
> > + * @max_fd: last file descriptor to close
> > + *
> > + * This closes a range of file descriptors. All file descriptors
> > + * from @fd up to and including @max_fd are closed.
> > + */
> > +int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
> > +{
> > +	unsigned int cur_max;
> > +
> > +	if (fd > max_fd)
> > +		return -EINVAL;
> > +
> > +	rcu_read_lock();
> > +	cur_max = files_fdtable(files)->max_fds;
> > +	rcu_read_unlock();
> > +
> > +	/* cap to last valid index into fdtable */
> > +	if (max_fd >= cur_max)
> > +		max_fd = cur_max - 1;
> > +
> > +	while (fd <= max_fd)
> > +		__close_fd(files, fd++);
> > +
> > +	return 0;
> > +}
> 
> This seems rather drastic.  How long does this block in kernel mode?
> Maybe it's okay as long as the maximum possible value for cur_max stays
> around 4 million or so.

That's probably valid concern when you reach very high numbers though I
wonder how relevant this is in practice.
Also, you would only be blocking yourself I imagine, i.e. you can't DOS
another task with this unless your multi-threaded.

> 
> Solaris has an fdwalk function:
> 
>   <https://docs.oracle.com/cd/E88353_01/html/E37843/closefrom-3c.html>
> 
> So a different way to implement this would expose a nextfd system call

Meh. If nextfd() then I would like it to be able to:
- get the nextfd(fd) >= fd
- get highest open fd e.g. nextfd(-1)

But then I wonder if nextfd() needs to be a syscall and isn't just
either:
fcntl(fd, F_GET_NEXT)?
or
prctl(PR_GET_NEXT)?

Technically, one could also do:

fd_range(unsigned fd, unsigend end_fd, unsigned flags);

fd_range(3, 50, FD_RANGE_CLOSE);

/* return highest fd within the range [3, 50] */
fd_range(3, 50, FD_RANGE_NEXT);

/* return highest fd */
fd_range(3, UINT_MAX, FD_RANGE_NEXT);

This syscall could also reasonably be extended.

> to userspace, so that we can use that to implement both fdwalk and
> closefrom.  But maybe fdwalk is just too obscure, given the existence of
> /proc.

Yeah we probably don't need fdwalk.

> 
> I'll happily implement closefrom on top of close_range in glibc (plus
> fallback for older kernels based on /proc—with an abort in case that
> doesn't work because the RLIMIT_NOFILE hack is unreliable
> unfortunately).
> 
> Thanks,
> Florian
