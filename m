Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8CGmQk13278
	for linux-mips-outgoing; Wed, 12 Sep 2001 09:48:26 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8CGmNe13275
	for <linux-mips@oss.sgi.com>; Wed, 12 Sep 2001 09:48:23 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 8C79F125C3; Wed, 12 Sep 2001 09:48:22 -0700 (PDT)
Date: Wed, 12 Sep 2001 09:48:22 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Carsten Langgaard <carstenl@mips.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Update for RedHat 7.1
Message-ID: <20010912094822.A4491@lucon.org>
References: <20010907230009.A1705@lucon.org> <3B9F21C9.985A1F0F@mips.com> <3B9F319B.E87DC64B@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B9F319B.E87DC64B@mips.com>; from carstenl@mips.com on Wed, Sep 12, 2001 at 11:57:47AM +0200
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Sep 12, 2001 at 11:57:47AM +0200, Carsten Langgaard wrote:
> Carsten Langgaard wrote:
> 
> > I have installed your new set of RedHat7.1 RPMs, and tried to build Perl
> > natively.
> > But it fails with the following message:
> >
> > `sh  cflags libperl.a toke.o`  toke.c
> >           CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
> > -I/usr/local/include
> > -O2
> >
> > Cannot allocate 2676168 bytes after allocating 3899765696 bytes
> > make: *** [toke.o] Error 1
> > error: Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
> >
> > RPM build errors:
> >     Bad exit status from /var/tmp/rpm-tmp.43439 (%build)
> >
> 
> I tried to build perl again an now I get this message:
> 
> `sh  cflags libperl.a toke.o`  toke.c
>           CCCMD =  gcc -DPERL_CORE -c -fno-strict-aliasing
> -I/usr/local/include -O2
> gcc: Internal error: Terminated (program cc1)
> Please submit a full bug report.
> See <URL:http://bugzilla.redhat.com/bugzilla/> for instructions.
> make: *** [toke.o] Error 1
> error: Bad exit status from /var/tmp/rpm-tmp.53242 (%build)
> 
> RPM build errors:
>     Bad exit status from /var/tmp/rpm-tmp.53242 (%build)
> 

It may be a kernel/hardware bug. I have no problem building perl
natively.


H.J.
