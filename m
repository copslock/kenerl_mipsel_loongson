Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f94JfpU21444
	for linux-mips-outgoing; Thu, 4 Oct 2001 12:41:51 -0700
Received: from ocean.lucon.org (c1473286-a.stcla1.sfba.home.com [24.176.137.160])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f94JfnD21440
	for <linux-mips@oss.sgi.com>; Thu, 4 Oct 2001 12:41:49 -0700
Received: by ocean.lucon.org (Postfix, from userid 1000)
	id 5D83F125C8; Thu,  4 Oct 2001 12:41:48 -0700 (PDT)
Date: Thu, 4 Oct 2001 12:41:47 -0700
From: "H . J . Lu" <hjl@lucon.org>
To: Gerald Champagne <gerald.champagne@esstech.com>
Cc: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Debugging symbols from gcc
Message-ID: <20011004124147.A16407@lucon.org>
References: <3BBCBB6B.6080809@esstech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3BBCBB6B.6080809@esstech.com>; from gerald.champagne@esstech.com on Thu, Oct 04, 2001 at 02:41:31PM -0500
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Oct 04, 2001 at 02:41:31PM -0500, Gerald Champagne wrote:
> I'm trying to use a Wind River VisionProbe debugger with the
> Linux kernel, but I can't get the compiler to generate the symbols
> in the proper format.  The debugger works with an old compiler
> that places the symbols in sections called ".stab" and ".stabstr".
> It doesn't work with the newer compiler that places the symbols
> in a section called ".mdebug" (which I think is specific to sgi).
> 
> The version that creates .stab/.stabstr sections is:
> $ /usr/local/sde4/bin/gcc --version egcs-2.90.23 980102 (egcs-1.0.1 release)
> 
> The version that creates .mdebug sections is:
> $ /usr/bin/mips-linux-gcc --version egcs-2.91.66
> 
> Is there a way to specify the output format of the debug symbols?  I've
> seen documentation that references a -gstabs option, but that doesn't
> seem to work.  Should I be using a different version of the compiler?
> I'm just using the rpm's that were on the sgi site.
> 

I have fixed it in the current binutils and gcc. Those in RedHat 7.1
for mips should be ok. At least, I can use gdb 5.1 on the Linux
kernel.


H.J.
