Received:  by oss.sgi.com id <S554052AbRBBUJJ>;
	Fri, 2 Feb 2001 12:09:09 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:14841 "EHLO
        orion.mvista.com") by oss.sgi.com with ESMTP id <S554045AbRBBUIs>;
	Fri, 2 Feb 2001 12:08:48 -0800
Received: (from jsun@localhost)
	by orion.mvista.com (8.9.3/8.9.3) id MAA21895;
	Fri, 2 Feb 2001 12:07:27 -0800
Date:   Fri, 2 Feb 2001 12:07:27 -0800
From:   Jun Sun <jsun@mvista.com>
To:     Carsten Langgaard <carstenl@mips.com>
Cc:     "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com
Subject: Re: Cross build applications
Message-ID: <20010202120727.B21833@mvista.com>
References: <Pine.GSO.3.96.1010202162911.28509M-100000@delta.ds2.pg.gda.pl> <3A7AD776.46B10823@mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A7AD776.46B10823@mips.com>; from carstenl@mips.com on Fri, Feb 02, 2001 at 04:51:18PM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Feb 02, 2001 at 04:51:18PM +0100, Carsten Langgaard wrote:
> Please, can anyone provide me with the right set of RPMs, so I can cross
> compile a "hello-world" program on a linux PC ?
> 
> /Carsten
> 

Go to ftp://ftp.mvista.com/pub/Area51/mips_fp_le/, and look for the following
packages for i386 host:

. binutils
. kernel-headers
. gcc 
. glibc

Install them and you are ready to go!

There are also big endian packages available.

Jun
