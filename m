Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6LIBbu27321
	for linux-mips-outgoing; Sat, 21 Jul 2001 11:11:37 -0700
Received: from earth.ayrnetworks.com (earth.ayrnetworks.com [64.166.72.139])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6LIBXV27312;
	Sat, 21 Jul 2001 11:11:33 -0700
Received: from [10.21.56.226] (earth.ayrnetworks.com [10.1.1.24])
	by earth.ayrnetworks.com (8.11.0/8.8.7) with ESMTP id f6LIAUr24590;
	Sat, 21 Jul 2001 11:10:30 -0700
User-Agent: Microsoft-Entourage/9.0.2509
Date: Sat, 21 Jul 2001 12:12:29 -0600
Subject: Re: SHN_MIPS_SCOMMON
From: Greg Satz <satz@ayrnetworks.com>
To: "H . J . Lu" <hjl@lucon.org>, Ralf Baechle <ralf@oss.sgi.com>
CC: <linux-mips@oss.sgi.com>
Message-ID: <B77F222C.888C%satz@ayrnetworks.com>
In-Reply-To: <20010721104144.A17894@lucon.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Content-transfer-encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

The problem I ran into was making NFS as a kernel module. The resulting
sunrpc.o module crashed when insmod was run over it. Ralf's fix that all
compiles and links use -G 0 worked for me.

Thanks,
Greg

on 7/21/01 11:41 AM, H . J . Lu at hjl@lucon.org wrote:

> On Sat, Jul 21, 2001 at 02:11:20PM +0200, Ralf Baechle wrote:
>> Only if you don't compile / assemble / link with -G 0.
>> 
>> .scommon shouldn't ever be in a kernel object.  It seems that ld started
>> to move .common objects to .scommon from a certain version on, so 2.4.5
> 
> Send me a testcase. I will fix the linker.
> 
> 
> H.J.
> 
