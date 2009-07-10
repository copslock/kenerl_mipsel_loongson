Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jul 2009 12:47:47 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:50215 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1491959AbZGJKrm (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 10 Jul 2009 12:47:42 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n6AAliGS003400;
	Fri, 10 Jul 2009 11:47:44 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n6AAlhqw003398;
	Fri, 10 Jul 2009 11:47:43 +0100
Date:	Fri, 10 Jul 2009 11:47:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Chris Dearman <chris@mips.com>
Cc:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>,
	yuasa@linux-mips.org, linux-mips@linux-mips.org,
	git@vger.kernel.org
Subject: Re: What's happening with vr41xx_giu.c?
Message-ID: <20090710104743.GB1288@linux-mips.org>
References: <4A5680B5.2090405@necel.com> <4A56B060.7090106@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A56B060.7090106@mips.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jul 09, 2009 at 08:07:12PM -0700, Chris Dearman wrote:

This is smelling like a git issue so I'm adding git@vger.kernel.org to cc
list.

> Shinya Kuribayashi wrote:
>
>> skuribay@ubuntu:linux.git$ make distclean
>> skuribay@ubuntu:linux.git$
>> skuribay@ubuntu:linux.git$
>> skuribay@ubuntu:linux.git$ git status
>> # On branch master
>> # Changed but not updated:
>> #   (use "git add/rm <file>..." to update what will be committed)
>> #   (use "git checkout -- <file>..." to discard changes in working  
>> directory)
>> #
>> #       deleted:    drivers/char/vr41xx_giu.c
>> #
>> no changes added to commit (use "git add" and/or "git commit -a")
>> skuribay@ubuntu:linux.git$
>>
>
> Commit 27fdd325dace4a1ebfa10e93ba6f3d25f25df674 turned  
> drivers/char/vr41xx_giu.c into an empty file instead of deleting it when  
> the file was moved to drivers/gpio
>
> "make distclean" deletes any 0 length .c files that it finds.
>
> Leaving drivers/char/vr41xx_giu.c as a zero length file may have been a  
> git bug but was probably just an oversight. I'll send a patch to clean  
> it up as a followup.

And issue is reproducable.  When I go back to commit
27fdd325dace4a1ebfa10e93ba6f3d25f25df674^ and apply Yoichi's patch using
git am or git apply this will leave a zero byte drivers/char/vr41xx_giu.c.
Patch(1) otoh will remove that file as expected.  The patch file Yoichi
sent looks perfectly ok; here the headers of the vr41xx_giu.c bit:

[...]
diff -pruN -X /home/yuasa/Memo/dontdiff linux-orig/drivers/char/vr41xx_giu.c linux/drivers/char/vr41xx_giu.c
--- linux-orig/drivers/char/vr41xx_giu.c        2009-06-29 10:06:58.329177629 +0900
+++ linux/drivers/char/vr41xx_giu.c     1970-01-01 09:00:00.000000000 +0900
@@ -1,680 +0,0 @@
-/*
[...]

This is with git 1.6.0.6 (git-1.6.0.6-4.fc10.x86_64 from Fedora 10).

The patch is available at http://www.linux-mips.org/cgi-bin/extract-mesg.cgi?a=linux-mips&m=2009-06&i=20090629111105.9ff024bf.yyuasa%40linux.com
and the git tree in question is Linus' kernel tree available from
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.

  Ralf
