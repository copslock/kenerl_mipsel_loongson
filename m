Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 May 2008 09:30:29 +0100 (BST)
Received: from yw-out-1718.google.com ([74.125.46.154]:27189 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S28577966AbYEEIa0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 5 May 2008 09:30:26 +0100
Received: by yw-out-1718.google.com with SMTP id 9so1222490ywk.24
        for <linux-mips@linux-mips.org>; Mon, 05 May 2008 01:30:14 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        bh=1vNwkNd0nYp80jvMF7wkf5IzXiIWL5OfoM0OUPtffOY=;
        b=LW2i4fqiGK0gDCkGKjTOsbBU+Dwt8Fk/Puzc3G3d+TuAFzVNSNkDvOUW3ljxGS0bD4lvTN9BQOd3llDmkw6JpgldgBPoDd2diPHrUmFrl58o7YPqzl7FBr1QHh/AYeY8mPUc4HxjGwlnKYpJz/lx3JG0kCa59Da38YXkuGcxxYU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=BlZwLZDhJ5raNDFiSkTgDB/awo0JiLN32gBHWuJQe3aT3Y9IDI28CKeeb5iFJZ0+Qo0d82CJr1Jy55dYyWaBhYUlWppdyTfT/11R1T28fXMf/Pzb8hp6TTPbd+cljYrson/oULp/4V4fmo8n81+vA/Aay08Hg1bx44tYIJLGuH0=
Received: by 10.150.12.3 with SMTP id 3mr5778656ybl.17.1209976214383;
        Mon, 05 May 2008 01:30:14 -0700 (PDT)
Received: by 10.150.158.7 with HTTP; Mon, 5 May 2008 01:30:09 -0700 (PDT)
Message-ID: <5eeb9ad90805050130i39ae791dwe599c12fc08fb8ec@mail.gmail.com>
Date:	Mon, 5 May 2008 10:30:09 +0200
From:	DM <dm.n9107@gmail.com>
To:	"Ulrich Drepper" <drepper@redhat.com>
Subject: Re: [PATCH v2] unify sys_pipe implementation
Cc:	linux-kernel@vger.kernel.org, akpm@linux-foundation.org,
	linux-mips@linux-mips.org, sparclinux@vger.kernel.org,
	torvalds@linux-foundation.org
In-Reply-To: <200805031801.m43I109q032242@devserv.devel.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <200805031801.m43I109q032242@devserv.devel.redhat.com>
Return-Path: <dm.n9107@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19102
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dm.n9107@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, May 3, 2008 at 8:01 PM, Ulrich Drepper <drepper@redhat.com> wrote:
[...]
>   /*
>  + * sys_pipe() is the normal C calling standard for creating
>  + * a pipe. It's not the way Unix traditionally does this, though.
>  + */
>  +asmlinkage long sys_pipe(int __user *fildes)
>  +{
>  +       int fd[2];
>  +       int error;
>  +
>  +       error = do_pipe(fd);
>  +       if (!error) {
>  +               if (copy_to_user(fildes, fd, sizeof(fd)))
>  +                       error = -EFAULT;
>  +       }
>  +       return error;
>  +}
>  +
[...]

I realize this code is old, but wouldn't file descriptors leak if
copy_to_user fails?

BR,
dm.n9107
