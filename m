Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9OKSxa03076
	for linux-mips-outgoing; Wed, 24 Oct 2001 13:28:59 -0700
Received: from www.transvirtual.com (root@www.transvirtual.com [206.14.214.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9OKSuD03064
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 13:28:56 -0700
Received: from www.transvirtual.com (jsimmons@localhost [127.0.0.1])
        by localhost (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9OKSpE0022119;
	Wed, 24 Oct 2001 13:28:51 -0700
Received: from localhost (jsimmons@localhost)
        by www.transvirtual.com (8.12.0.Beta7/8.12.0.Beta7/Debian 8.12.0.Beta7-1) with ESMTP id f9OKSpZD022113;
	Wed, 24 Oct 2001 13:28:51 -0700
X-Authentication-Warning: www.transvirtual.com: jsimmons owned process doing -bs
Date: Wed, 24 Oct 2001 13:28:50 -0700 (PDT)
From: James Simmons <jsimmons@transvirtual.com>
To: "H . J . Lu" <hjl@lucon.org>
cc: linux-mips@oss.sgi.com
Subject: Re: I am looking for a mips machine
In-Reply-To: <20011024132435.A7669@lucon.org>
Message-ID: <Pine.LNX.4.10.10110241326450.10287-100000@transvirtual.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


> I have access to a Raq 2. But it won't take my old EDO SIMMs :-). 

That sucks. Have you have any luck with any memory chips?

> Besides, it only supports an 2.2 kernel.

jsimmons@borgcube:~$ cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : Nevada V10.0
system type             : Cobalt Microserver 27
BogoMIPS                : 249.85
byteorder               : little endian
unaligned accesses      : 0
wait instruction        : yes
microsecond timers      : yes
extra interrupt vector  : yes
hardware watchpoint     : no
VCED exceptions         : not available
VCEI exceptions         : not available
jsimmons@borgcube:~$ uname -nr
borgcube 2.4.10-mips
jsimmons@borgcube:~$


Actually I need to migrate the code to the new time and pci code. I will
be sending a diff to Ralph in the next few days.
