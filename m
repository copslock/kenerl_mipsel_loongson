Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 May 2009 15:56:32 +0100 (BST)
Received: from wa-out-1112.google.com ([209.85.146.176]:13914 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024489AbZE1O40 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 28 May 2009 15:56:26 +0100
Received: by wa-out-1112.google.com with SMTP id n4so895645wag.0
        for <multiple recipients>; Thu, 28 May 2009 07:56:23 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=Xoj8kyaH+XoTcAuWA8HLOUd3/i9hZeqv8s2jwIPwcYg=;
        b=drgMTW4ccIJmDmJAHieoW4oxd73vPYiXkoX5lPQrdBFDvJOtkpc8W4wSpez4eRpgDp
         jhftWJIf79oYtqB+YxHnYfDWurXyfE5L8OP6KYCDlQ30AUjIYfNDEUiJYEmEIa/9Kfh1
         HYUZyUJvGYMMsHXaZjNtM3KaVAbIioDpe5U9I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=HLSv00rvwWDctyKxYGgzL2oT47Zx3zZXsafs6gKDLUJ1bp/5Lxj1jf8txZWgF3WLhk
         lKJHSkeUQJy+AV/N5iWPJLUyoQGgQXJ3FFyIQCqezk5gBEsFEMVTLXJh8zzrwbqyk8Q1
         7QZSwHgrxisDod5KzcSwRY9YnQxiYx0rdp19g=
Received: by 10.114.175.16 with SMTP id x16mr1647516wae.134.1243522574768;
        Thu, 28 May 2009 07:56:14 -0700 (PDT)
Received: from ?192.168.2.239? ([202.201.14.140])
        by mx.google.com with ESMTPS id g25sm127430wag.43.2009.05.28.07.56.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 28 May 2009 07:56:14 -0700 (PDT)
Subject: Re: [PATCH] mips-specific ftrace support
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Thomas Gleixner <tglx@linutronix.de>
Cc:	Steven Rostedt <rostedt@goodmis.org>, linux-mips@linux-mips.org,
	LKML <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Ingo Molnar <mingo@elte.hu>,
	Andrew Morton <akpm@linux-foundation.org>,
	Nicholas Mc Guire <der.herr@hofr.at>
In-Reply-To: <alpine.LFD.2.00.0905281644210.3397@localhost.localdomain>
References: <73465d64a9a6773936f5eab3735a69f651c13187.1243458732.git.wuzj@lemote.com>
	 <alpine.DEB.2.00.0905280948410.27708@gandalf.stny.rr.com>
	 <alpine.LFD.2.00.0905281644210.3397@localhost.localdomain>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Thu, 28 May 2009 22:56:05 +0800
Message-Id: <1243522565.5183.8.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, 2009-05-28 at 16:45 +0200, Thomas Gleixner wrote:
> On Thu, 28 May 2009, Steven Rostedt wrote:
> > On Thu, 28 May 2009, wuzhangjin@gmail.com wrote:
> > Could you possibly break this patch up into porting the tracers one by 
> > one. That is:
> > 
> > First patch: make function tracing work.
> > Second patch: make dynamic tracing work.
> > Third patch: add Function graph tracing.
> > Forth patch: the time stamp updates
> > 
> > This would make things a lot easier to review, and if one of the changes 
> > breaks something, it will be easier to bisect.
> 
> > >  include/linux/clocksource.h    |    4 +-
> > >  kernel/sched_clock.c           |    2 +-
> > >  kernel/trace/ring_buffer.c     |    3 +-
> > >  kernel/trace/trace_clock.c     |    2 +-
> > >  scripts/Makefile.build         |    1 +
> > >  scripts/recordmcount.pl        |   31 +++-
> 
> The changes to these generic files need to be separate as well.
> 

Acked, will update it later.

thanks!
Wu Zhangjin
