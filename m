Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6VLh9p12833
	for linux-mips-outgoing; Tue, 31 Jul 2001 14:43:09 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6VLh8V12830
	for <linux-mips@oss.sgi.com>; Tue, 31 Jul 2001 14:43:08 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f6VLh1Tv002150;
	Tue, 31 Jul 2001 14:43:01 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f6VLh1db002146;
	Tue, 31 Jul 2001 14:43:01 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Tue, 31 Jul 2001 14:43:01 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: Jun Sun <jsun@mvista.com>
cc: linux-mips@oss.sgi.com, linux-mips-kernel@lists.sourceforge.net
Subject: Re: sys_mips problems
In-Reply-To: <3B671DFC.3999437D@mvista.com>
Message-ID: <Pine.LNX.4.10.10107311435110.28897-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> > Since I was having problems with everything sefaulting due to the sys_mips
> > bug I tried the patch floating around. It fixed the segfault problem but
> > instead I get this error. Anyone knows why?
> > 
> > : error while loading shared libraries: libc.so.6: cannot stat shared
> > object: Error 14
> 
> Which patch did you use?  

The fast_sysmips one. 

> Does your CPU have ll/sc instructions?

I have a cobalt cube which has a MIPS Nevada chip which is a R52xx chip. I
don't know if it does. By default I have ll/sc and lld/scd instructions
enabled.
