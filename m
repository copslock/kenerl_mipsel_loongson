Received:  by oss.sgi.com id <S554105AbRAZU3g>;
	Fri, 26 Jan 2001 12:29:36 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:49908 "EHLO
        orion.mvista.com") by oss.sgi.com with ESMTP id <S554099AbRAZU33>;
	Fri, 26 Jan 2001 12:29:29 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id MAA09422;
	Fri, 26 Jan 2001 12:28:38 -0800
Date:   Fri, 26 Jan 2001 12:28:38 -0800
From:   Jun Sun <jsun@mvista.com>
To:     Mike McDonald <mikemac@mikemac.com>
Cc:     linux-mips@oss.sgi.com
Subject: Re: Cross compiling RPMs
Message-ID: <20010126122838.F9325@mvista.com>
References: <200101261815.KAA08917@saturn.mikemac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200101261815.KAA08917@saturn.mikemac.com>; from mikemac@mikemac.com on Fri, Jan 26, 2001 at 10:15:21AM -0800
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jan 26, 2001 at 10:15:21AM -0800, Mike McDonald wrote:
> 
>   Can anyone point me to some references of techniques for cross
> compiling RPMs? I want to build some packages for my little endian
> MIPS but I haven't found any info on cross compiling RPMs in the RPM
> docs nor "Maximum RPM". Any pointers would be appreciated. (I'm
> particularly interested in how to specify the tool chain.)
>

Mike,

Most GNU packages allow you to specify environment variables such
as CC, AR, RANLIB, etc when invoking the "configure" command.  So
you will need to set those variables in your spec file
where "configure" is invoked.

If a package itself is not cross-compiling friendly, you need to 
make it cross-compilable first. :-)

If you only cross-compile one package, I suggest you read through
spec file and do the job manually (untar, applying patch, configure,
make, make install, etc).

Jun
