Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2009 08:33:45 +0100 (BST)
Received: from ti-out-0910.google.com ([209.85.142.191]:34156 "EHLO
	ti-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S28771624AbZDSHdG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 19 Apr 2009 08:33:06 +0100
Received: by ti-out-0910.google.com with SMTP id 11so914472tim.20
        for <multiple recipients>; Sun, 19 Apr 2009 00:33:02 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :in-reply-to:references:content-type:organization:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=5+iCdn7OuGlJMbHTTdiNRZ8k2KvuRvz8tNpIyfn2Kl8=;
        b=QnKi7HgKFGQs6lx+RfpOQRonr3f7zTeyLw5swxGMmncRfhjgLtXSOcLPUJKkwNhOkS
         CCOMml1jH3Oj6Tcj6FHDghdWuvq4Q+MK82Lx32t0Lqhdsfn8MBJTfhT7BYF1ulIEFtq4
         nx4TZoNG0SlcDRTsZpTKHwBvYr1hJPyYACpWw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:in-reply-to:references:content-type
         :organization:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=cB/dCl7+2AK6nwcfYyy39EHMQ/FzFYrjPB0iXD6sA6RgZCzNvAcnmv3o/7XdaGNVFv
         Wg/L/jrXPbDdUZLERIyXD4E1HnLBzp5H09NDPwdgGGAwv0tqo1l/4RWFNO501hREesrG
         INdf8CULGFOZd6xrmEEnZ2GBxfn+44DmhqugI=
Received: by 10.110.8.5 with SMTP id 5mr4880722tih.10.1240126382438;
        Sun, 19 Apr 2009 00:33:02 -0700 (PDT)
Received: from ?172.16.18.144? ([222.92.8.142])
        by mx.google.com with ESMTPS id 2sm3308808tif.5.2009.04.19.00.32.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 19 Apr 2009 00:33:01 -0700 (PDT)
Subject: Re: mips build failure
From:	Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:	Stephen Rothwell <sfr@canb.auug.org.au>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
	Eduard - Gabriel Munteanu <eduard.munteanu@linux360.ro>,
	Pekka Enberg <penberg@cs.helsinki.fi>,
	Ingo Molnar <mingo@elte.hu>
In-Reply-To: <20090419172436.6d0e741a.sfr@canb.auug.org.au>
References: <20090419172436.6d0e741a.sfr@canb.auug.org.au>
Content-Type: text/plain
Organization: DSLab, Lanzhou University, China
Date:	Sun, 19 Apr 2009 15:32:41 +0800
Message-Id: <1240126361.3423.5.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.3 
Content-Transfer-Encoding: 7bit
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, 2009-04-19 at 17:24 +1000, Stephen Rothwell wrote:
> Hi Ralf,
> 
> You probably already now about this, but our build (mips ip32_defconfig)
> of Linus' tree (commit aefe6475720bd5eb8aacbc881488f3aa65618562 "Merge
> branch 'upstream-linus' of
> git://git.kernel.org/pub/scm/linux/kernel/git/jgarzik/libata-dev") gets
> these errors (we have actually been getting these errors since 2.6.30-rc1):
> 
> In file included from arch/mips/include/asm/compat.h:7,
>                  from include/linux/compat.h:15,
>                  from arch/mips/kernel/asm-offsets.c:12:
> include/linux/seccomp.h: In function 'prctl_get_seccomp':
> include/linux/seccomp.h:30: error: 'EINVAL' undeclared (first use in this function)
> include/linux/seccomp.h:30: error: (Each undeclared identifier is reported only once
> include/linux/seccomp.h:30: error: for each function it appears in.)
> include/linux/seccomp.h: In function 'prctl_set_seccomp':
> include/linux/seccomp.h:35: error: 'EINVAL' undeclared (first use in this function)
> 

perhaps you can fix it like this:

include/linux/seccomp.h

 22 #else /* CONFIG_SECCOMP */
 23 
 24 +#include <asm-generic/errno-base.h>
 25 
 26 typedef struct { } seccomp_t;

in reality, there is a previous email sent by Ralf for it:

http://lkml.indiana.edu/hypermail/linux/kernel/0904.2/01152.html

> Bisected down to commit ac44021fccd8f1f2b267b004f23a2e8d7ef05f7b
> "kmemtrace, rcu: don't include unnecessary headers, allow kmemtrace w/
> tracepoints".
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/330240/
