Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8CJnPW17719
	for linux-mips-outgoing; Wed, 12 Sep 2001 12:49:25 -0700
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8CJnLe17714
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 12:49:21 -0700
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id MAA01387;
	Wed, 12 Sep 2001 12:49:09 -0700 (PDT)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id MAA02009;
	Wed, 12 Sep 2001 12:49:10 -0700 (PDT)
Received: from mips.com (coppccl [172.17.27.2])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id f8CJn9a25936;
	Wed, 12 Sep 2001 21:49:10 +0200 (MEST)
Message-ID: <3B9FBCB3.FDACFE3E@mips.com>
Date: Wed, 12 Sep 2001 21:51:15 +0200
From: Carsten Langgaard <carstenl@mips.com>
Organization: MIPS Technologies
X-Mailer: Mozilla 4.76 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: Pete Popov <ppopov@pacbell.net>
CC: linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
References: <20010907230009.A1705@lucon.org> <3B9F21C9.985A1F0F@mips.com> <3B9F319B.E87DC64B@mips.com> <20010912094822.A4491@lucon.org> <3B9F9489.90608@pacbell.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Pete Popov wrote:

> H . J . Lu wrote:
> > On Wed, Sep 12, 2001 at 11:57:47AM +0200, Carsten Langgaard wrote:
> >
> >>Carsten Langgaard wrote:
> >>
> >>
> >>>I have installed your new set of RedHat7.1 RPMs, and tried to build Perl
> >>>natively.
> >>>But it fails with the following message:
> >>>
> >>>`sh  cflags libperl.a toke.o`  toke.c
> >>>          CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
> >>>-I/usr/local/include
> >>>-O2
> >>>
> >>>Cannot allocate 2676168 bytes after allocating 3899765696 bytes
> >>>make: *** [toke.o] Error 1
> >>>error: Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
> >>>
> >>>RPM build errors:
> >>>    Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
> >>>
> >>>
> >>I tried to build perl again an now I get this message:
> >>
> >>`sh  cflags libperl.a toke.o`  toke.c
> >>          CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
> >>-I/usr/local/include -O2
> >>gcc: Internal error: Terminated (program cc1)
> >>Please submit a full bug report.
> >>See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
> >>make: *** [toke.o] Error 1
> >>error: Bad exit status from /var/tmp/rpm-tmp.53242 (%build)
> >>
> >>RPM build errors:
> >>    Bad exit status from /var/tmp/rpm-tmp.53242 (%build)
> >>
> >>
> >
> > It may be a kernel/hardware bug. I have no problem building perl
> > natively.
>
> Carsten, what board/cpu are you using?

On a Atlas board with a QED RM5261 CPU (little-endian).
The kernel is based on 2.4.3.

>
> Pete
