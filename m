Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2008 10:16:01 +0100 (BST)
Received: from fg-out-1718.google.com ([72.14.220.155]:19386 "EHLO
	fg-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S20036616AbYEEJP5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 May 2008 10:15:57 +0100
Received: by fg-out-1718.google.com with SMTP id d23so91195fga.32
        for <linux-mips@linux-mips.org>; Mon, 05 May 2008 02:15:53 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        bh=yJHrhUWPm80nO9pg3l7+5CF9in2efx8o1cL5G3M2aIY=;
        b=TuVUwDepvr/y/ngeebB1kLyhvXWma1TBCDXyAnouPsHVXd8/alZw4h/eeOdfEVwfM1OXSKk9hqa1dQm3cV4Xh1HBFexb6DuptfByR/t1dNAR7VnjeqB0sOmDpz8OQTl6ih9LweabwEZUMC7Zux3YlWrhgxDuFZLdwnTObqzbXBQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=kMGZpkyX+ewQQ2eYahy7WrEm2zS69ON+UQRxAa7Y7S/2hmm7yz5qF15E7eJKJOyRVJi1Y5tZMRIlt6O/WLtPa48g3w1iL0Bj64i6WvydC9kOmR8R7O0MIZFne6HJvzYzr2eDx14ePQBYc6DypZiRRFHfhF+PG/7U9Lx4yZoqGQI=
Received: by 10.86.90.13 with SMTP id n13mr10192966fgb.64.1209978953407;
        Mon, 05 May 2008 02:15:53 -0700 (PDT)
Received: by 10.86.71.16 with HTTP; Mon, 5 May 2008 02:15:53 -0700 (PDT)
Message-ID: <517f3f820805050215s689ae274yf8a4ad270cb5981c@mail.gmail.com>
Date:	Mon, 5 May 2008 11:15:53 +0200
From:	"Michael Kerrisk" <mtk.manpages@gmail.com>
To:	DM <dm.n9107@gmail.com>
Subject: Re: [PATCH v2] unify sys_pipe implementation
Cc:	"Ulrich Drepper" <drepper@redhat.com>,
	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	torvalds@linux-foundation.org
In-Reply-To: <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200805031801.m43I109q032242@devserv.devel.redhat.com>
	 <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
X-Google-Sender-Auth: 4e80ca2b3fe2a603
Return-Path: <mtk.linux.lists@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19103
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mtk.manpages@gmail.com
Precedence: bulk
X-list: linux-mips

On 5/5/08, DM <dm.n9107@gmail.com> wrote:
> On Sat, May 3, 2008 at 8:01 PM, Ulrich Drepper <drepper@redhat.com> wrote:
>  [...]
>
> >   /*
>  >  + * sys_pipe() is the normal C calling standard for creating
>  >  + * a pipe. It's not the way Unix traditionally does this, though.
>  >  + */
>  >  +asmlinkage long sys_pipe(int __user *fildes)
>  >  +{
>  >  +       int fd[2];
>  >  +       int error;
>  >  +
>  >  +       error = do_pipe(fd);
>  >  +       if (!error) {
>  >  +               if (copy_to_user(fildes, fd, sizeof(fd)))
>  >  +                       error = -EFAULT;
>  >  +       }
>  >  +       return error;
>  >  +}
>  >  +
>
> [...]
>
>  I realize this code is old, but wouldn't file descriptors leak if
>  copy_to_user fails?

Yes, it does -- I just tested this.

-- 
Michael Kerrisk
Linux man-pages maintainer; http://www.kernel.org/doc/man-pages/
Found a bug? http://www.kernel.org/doc/man-pages/reporting_bugs.html
