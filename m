Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0MB1UP30749
	for linux-mips-outgoing; Tue, 22 Jan 2002 03:01:30 -0800
Received: from oval.algor.co.uk (root@oval.algor.co.uk [62.254.210.250])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0MB1JP30729;
	Tue, 22 Jan 2002 03:01:20 -0800
Received: from gladsmuir.algor.co.uk (IDENT:root@gladsmuir.algor.co.uk [192.168.5.75])
	by oval.algor.co.uk (8.11.6/8.10.1) with ESMTP id g0M9xst08507;
	Tue, 22 Jan 2002 09:59:54 GMT
Received: (from dom@localhost)
	by gladsmuir.algor.co.uk (8.11.2/8.11.2) id g0M9xrq01215;
	Tue, 22 Jan 2002 09:59:53 GMT
From: Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Message-ID: <15437.14361.918255.115877@gladsmuir.algor.co.uk>
Date: Tue, 22 Jan 2002 09:59:53 +0000
To: "Kevin D. Kissell" <kevink@mips.com>
Cc: "Ralf Baechle" <ralf@oss.sgi.com>, "Ulrich Drepper" <drepper@redhat.com>,
   "Mike Uhler" <uhler@mips.com>, <linux-mips@oss.sgi.com>,
   "GNU libc hacker" <libc-hacker@sources.redhat.com>,
   "H . J . Lu" <hjl@lucon.org>
Subject: Re: thread-ready ABIs
In-Reply-To: <01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>
References: <m3elkoa5dw.fsf@myware.mynet>
	<20020118101908.C23887@lucon.org>
	<01b801c1a081$3f6518e0$0deca8c0@Ulysses>
	<20020119162415.B31028@dea.linux-mips.net>
	<m3d703thl6.fsf@myware.mynet>
	<01be01c1a2d7$6ec299c0$0deca8c0@Ulysses>
X-Mailer: VM 6.89 under 21.1 (patch 14) "Cuyahoga Valley" XEmacs Lucid
User-Agent: SEMI/1.13.7 (Awazu) CLIME/1.13.6 (=?ISO-2022-JP?B?GyRCQ2YbKEI=?=
 =?ISO-2022-JP?B?GyRCJU4+MRsoQg==?=) MULE XEmacs/21.1 (patch 14) (Cuyahoga
 Valley) (i386-redhat-linux)
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Kevin,

Since nobody seems to be prepared to essay a brief definition of a
thread register, I'll make one up from first principles and maybe the
experts will beat it into shape.

Multiple threads in a Linux process share the same address space: code
and data.  A thread has its own unique stack, but since (by
definition) it shares all its data with every other thread it has no
identity - there is no thread-unique static data.  That means it has
no handle to acquire and manage any thread-specific variables.

[Some threads purists would probably maintain that's a Good Thing:
 threads to them are like electrons to quantum physicists,
 indistinguishable by definition].

Linux is not noted for computer science purity; so an OS-maintained
"thread identity" variable which is cheap to read in user space sounds
a useful thing to have.

A patient Linux expert (if any such are reading this list) might like
to say what value is typically held (a pointer? an index?) and how
it's used (my money's on "wrapped in an impenetrable macro").

In a more baroque (synonym for "less backward"?) architecture there
are usually registers hanging about which no compiler or OS author has
previously figured out any use for, which can be bent to this purpose.
Unfortunately, MIPS original architects committed the grave error of
making all the registers useful.

I quite like the idea of putting the thread value at a known offset in
low virtual memory, but I expect the kernel keeps virtual page 0
invalid to catch null pointers and that instructions start at the
first boundary which doesn't create cache alias problems...

--
Dominic Sweetman
Algorithmics Ltd
The Fruit Farm, Ely Road, Chittering, CAMBS CB5 9PH, ENGLAND
phone: +44 1223 706200 / fax: +44 1223 706250 / home: +44 20 7226 0032
http://www.algor.co.uk
