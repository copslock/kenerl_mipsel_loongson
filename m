Return-Path: <SRS0=P1YI=TX=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41D0BC282E1
	for <linux-mips@archiver.kernel.org>; Thu, 23 May 2019 14:15:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 133342177E
	for <linux-mips@archiver.kernel.org>; Thu, 23 May 2019 14:15:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=brauner.io header.i=@brauner.io header.b="agfu05mc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730709AbfEWOPB (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Thu, 23 May 2019 10:15:01 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:35539 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730741AbfEWOPA (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Thu, 23 May 2019 10:15:00 -0400
Received: by mail-it1-f195.google.com with SMTP id u186so8758127ith.0
        for <linux-mips@vger.kernel.org>; Thu, 23 May 2019 07:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=brauner.io; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=rgSvHJdgJSnF7/xiB9jp3IYiH1RwVXYwyOL2WgM6elM=;
        b=agfu05mcW6DVn/laHbq7o5peWWMubiiXLa3+mtVVF+i5l0QEt93/bvKWl3JbPoVwXl
         0k64ioj3Ph2BkMXRRbAHKAFfkxjOHDSRt5NCBWr2asYnRnNKZL4zjdQz3kH7Jqukj0z6
         2og5izGp8YNUen+yStzQvEMwIJdLGCCPJJnwa/rcJXm71w0kxDdqtXnMzoicLjGDEAWi
         ZhH0AtrgRENAHSCoFkVjHZZZaCx513l14vIozc4GzDXmosIFXifqXJPpo1kJBs9fbYoH
         SAsp9lAUDI9bdzdzBP2B3VcM+Tv5WeTYZNB/it3XGBVA35In6f74kJj0SxBCXK8Oqary
         LS0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=rgSvHJdgJSnF7/xiB9jp3IYiH1RwVXYwyOL2WgM6elM=;
        b=iG07oeZnz4D0N0mvEoDtDdfgi41kzV5ngwQMvVp8PgA3pyf0TTGmN69ta2Bntwnh2q
         xc+q7IpnEwmNvUqX3E9icKtoXfan7GONe5Q1R8lwsq62cWJ9dJRp2sUGWopLWSP9D6RA
         qcQ9VSf88UKUe8MbRAavPr75QHdt3nVqHIdfL1WFl71Xm8BcRo/yFaGl8PKIEYUogmSh
         BErVUjqahj/GA8ZbWn0FnqaMNOy9Hqk/F/sR1fzBMe2Q9VS0ZevBTV1ITlgQV+lG5bg3
         9qEynA2FXVom9/34KmWhwumf5FYC6Rn1MRvKnInVWT/3NJJerBGzTsje9DNR7GEX0Xel
         UvZw==
X-Gm-Message-State: APjAAAVo6ORCv3W4JBo4WZoUurdwIWdy1azivFQX8KzPEff6162SQPqg
        L/0nXD1Zcjd6MmwoIdGSAVztFQ==
X-Google-Smtp-Source: APXvYqy9XAMrNMkQarBeYE8e7HlYFHTwYh86KxFNh1Z1HbzreF/S6QYjLd8wwHWfkp2KJKFiXZBbVg==
X-Received: by 2002:a24:590f:: with SMTP id p15mr12892482itb.12.1558620899772;
        Thu, 23 May 2019 07:14:59 -0700 (PDT)
Received: from brauner.io ([172.56.12.187])
        by smtp.gmail.com with ESMTPSA id q142sm4141521itb.17.2019.05.23.07.14.51
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Thu, 23 May 2019 07:14:58 -0700 (PDT)
Date:   Thu, 23 May 2019 16:14:48 +0200
From:   Christian Brauner <christian@brauner.io>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        torvalds@linux-foundation.org, fweimer@redhat.com,
        jannh@google.com, tglx@linutronix.de, arnd@arndb.de,
        shuah@kernel.org, dhowells@redhat.com, tkjos@android.com,
        ldv@altlinux.org, miklos@szeredi.hu, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org,
        x86@kernel.org
Subject: Re: [PATCH v1 1/2] open: add close_range()
Message-ID: <20190523141447.34s3kc3fuwmoeq7n@brauner.io>
References: <20190522155259.11174-1-christian@brauner.io>
 <20190522165737.GC4915@redhat.com>
 <20190523115118.pmscbd6kaqy37dym@brauner.io>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190523115118.pmscbd6kaqy37dym@brauner.io>
User-Agent: NeoMutt/20180716
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

On Thu, May 23, 2019 at 01:51:18PM +0200, Christian Brauner wrote:
> On Wed, May 22, 2019 at 06:57:37PM +0200, Oleg Nesterov wrote:
> > On 05/22, Christian Brauner wrote:
> > >
> > > +static struct file *pick_file(struct files_struct *files, unsigned fd)
> > >  {
> > > -	struct file *file;
> > > +	struct file *file = NULL;
> > >  	struct fdtable *fdt;
> > >  
> > >  	spin_lock(&files->file_lock);
> > > @@ -632,15 +629,65 @@ int __close_fd(struct files_struct *files, unsigned fd)
> > >  		goto out_unlock;
> > >  	rcu_assign_pointer(fdt->fd[fd], NULL);
> > >  	__put_unused_fd(files, fd);
> > > -	spin_unlock(&files->file_lock);
> > > -	return filp_close(file, files);
> > >  
> > >  out_unlock:
> > >  	spin_unlock(&files->file_lock);
> > > -	return -EBADF;
> > > +	return file;
> > 
> > ...
> > 
> > > +int __close_range(struct files_struct *files, unsigned fd, unsigned max_fd)
> > > +{
> > > +	unsigned int cur_max;
> > > +
> > > +	if (fd > max_fd)
> > > +		return -EINVAL;
> > > +
> > > +	rcu_read_lock();
> > > +	cur_max = files_fdtable(files)->max_fds;
> > > +	rcu_read_unlock();
> > > +
> > > +	/* cap to last valid index into fdtable */
> > > +	if (max_fd >= cur_max)
> > > +		max_fd = cur_max - 1;
> > > +
> > > +	while (fd <= max_fd) {
> > > +		struct file *file;
> > > +
> > > +		file = pick_file(files, fd++);
> > 
> > Well, how about something like
> > 
> > 	static unsigned int find_next_opened_fd(struct fdtable *fdt, unsigned start)
> > 	{
> > 		unsigned int maxfd = fdt->max_fds;
> > 		unsigned int maxbit = maxfd / BITS_PER_LONG;
> > 		unsigned int bitbit = start / BITS_PER_LONG;
> > 
> > 		bitbit = find_next_bit(fdt->full_fds_bits, maxbit, bitbit) * BITS_PER_LONG;
> > 		if (bitbit > maxfd)
> > 			return maxfd;
> > 		if (bitbit > start)
> > 			start = bitbit;
> > 		return find_next_bit(fdt->open_fds, maxfd, start);
> > 	}
> 
> > 
> > 	unsigned close_next_fd(struct files_struct *files, unsigned start, unsigned maxfd)
> > 	{
> > 		unsigned fd;
> > 		struct file *file;
> > 		struct fdtable *fdt;
> > 	
> > 		spin_lock(&files->file_lock);
> > 		fdt = files_fdtable(files);
> > 		fd = find_next_opened_fd(fdt, start);
> > 		if (fd >= fdt->max_fds || fd > maxfd) {
> > 			fd = -1;
> > 			goto out;
> > 		}
> > 
> > 		file = fdt->fd[fd];
> > 		rcu_assign_pointer(fdt->fd[fd], NULL);
> > 		__put_unused_fd(files, fd);
> > 	out:
> > 		spin_unlock(&files->file_lock);
> > 
> > 		if (fd == -1u)
> > 			return fd;
> > 
> > 		filp_close(file, files);
> > 		return fd + 1;
> > 	}
> 
> Thanks, Oleg!
> 
> I kept it dumb and was about to reply that your solution introduces more
> code when it seemed we wanted to keep this very simple for now.
> But then I saw that find_next_opened_fd() already exists as
> find_next_fd(). So it's actually not bad compared to what I sent in v1.
> So - with some small tweaks (need to test it and all now) - how do we
> feel about?:

That's obviously not correct atm but I'll send out a tweaked version in
a bit.

Christian
