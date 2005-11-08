Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Nov 2005 17:24:10 +0000 (GMT)
Received: from zproxy.gmail.com ([64.233.162.199]:46408 "EHLO zproxy.gmail.com")
	by ftp.linux-mips.org with ESMTP id S8133862AbVKHRXu convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 8 Nov 2005 17:23:50 +0000
Received: by zproxy.gmail.com with SMTP id l8so583758nzf
        for <linux-mips@linux-mips.org>; Tue, 08 Nov 2005 09:25:08 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=fAx893bhQvt/PieCkwBJQn6Go5+kb/nbs7Q5tFN2jFJysqDpDne2NMWZdzif0Xt2xZ3JZyBzWJFN0ix2tFmSyrAADqIlQwleG6waBQFHaulyUl2qwDTkXb/9zclz+tbW4LlT52RoH9AbSnznHwwGV8WnMIfEpcq4P4eFJd/JQcM=
Received: by 10.36.101.3 with SMTP id y3mr2509087nzb;
        Tue, 08 Nov 2005 09:25:08 -0800 (PST)
Received: by 10.36.47.8 with HTTP; Tue, 8 Nov 2005 09:25:06 -0800 (PST)
Message-ID: <cda58cb80511080925l2d441604i@mail.gmail.com>
Date:	Tue, 8 Nov 2005 18:25:06 +0100
From:	Franck <vagabon.xyz@gmail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: git and tags...
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20051108110134.GA2689@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <cda58cb80511080249w7d902821n@mail.gmail.com>
	 <20051108110134.GA2689@linux-mips.org>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9447
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

2005/11/8, Ralf Baechle <ralf@linux-mips.org>:
> On Tue, Nov 08, 2005 at 11:49:48AM +0100, Franck wrote:
>
> > I'm trying to retrieve a linux kernel by tag using git. Let's say for
> > example I want my working tree to be a linux 2.6.12 copy from git
> > repository. How can I do that ?
> >
> > I tried these commands but it seems that there's no tag in git repository
> >
> > git clone rsync://ftp.linux-mips.org/git/linux.git linux.git
> > git pull http://www.linux-mips.org/pub/scm/linux.git tag linux_2_6_12
>
> ls .git/refs/tags to see the tag names.
>

OK, so tags have been renamed into "linux-2.6.x". Why not using the
same mainline name convention (v2.6.x) ?

I have another question (which is the first one in my previous email),
how can I make my working tree a kernel version 2.6.9 for example ?

And the last question related to mips git repository, why does kernel
v2.2, v2.4, v2.6 are in the same repository ? Why not seperate
different major version of the kernel in a seperate repository ?

Thanks
--
               Franck
