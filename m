Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f92C9XK13500
	for linux-mips-outgoing; Tue, 2 Oct 2001 05:09:33 -0700
Received: from groucho.maths.monash.edu.au (groucho.maths.monash.edu.au [130.194.160.211])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f92C9SD13496
	for <linux-mips@oss.sgi.com>; Tue, 2 Oct 2001 05:09:28 -0700
Received: (from rjh@localhost)
	by groucho.maths.monash.edu.au (8.8.8/8.8.8) id MAA23706;
	Tue, 2 Oct 2001 12:09:25 GMT
From: Robin Humble <rjh@groucho.maths.monash.edu.au>
Message-Id: <200110021209.MAA23706@groucho.maths.monash.edu.au>
Subject: Re: Bug in pthread glibc 7.0 & 7.1
To: linux-mips@oss.sgi.com
Date: Tue, 2 Oct 2001 22:09:25 +1000 (EST)
Cc: roger_twede@hp.com
In-Reply-To: <20011001171003.A18883@lucon.org> from "H . J . Lu" at Oct 01, 2001 05:10:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


H.J. wrote:
>On Mon, Oct 01, 2001 at 07:52:15PM -0400, TWEDE,ROGER (HP-Boise,ex1) wrote:
>> The following code reveals a bug in the MIPS Gnu C Libraries available via
>> ftp on oss.sgi.com (ftp.linux.sgi.com).
>> ...
>On RedHat 7.1/mips:
>
># gcc pthread.c -o mips -lpthread -Wall
>pthread.c: In function `StartFunction':
>pthread.c:64: warning: unsigned int format, pointer arg (arg 3)
>pthread.c:69: warning: unsigned int format, pointer arg (arg 3)
># ./mips
>pid=21905 Init mutex
>pid=21905 About to create thread: mythread
>pid=21905 about to cond_wait for mythread init 1.
>pid=21907 thread mutex locked at x7fff79c8
>pid=21907 thread cond signal sent, unlocking at 0x7fff79c8
>pid=21907 thread unlocked
>pid=21905 back from cond_wait for mythread init 1.  result=0
>pid=21907 yielded and back again
># rpm -q glibc
>glibc-2.2.4-11.2

On my R4600SC Indy running 7.1 (mips) I get:

% gcc blah.c -o blah -lpthread -Wall
blah.c: In function `StartFunction':
blah.c:37: warning: unsigned int format, pointer arg (arg 3)
blah.c:42: warning: unsigned int format, pointer arg (arg 3)
% ./blah
[blah:5286] Illegal instruction 0100017c at 2ad1a910 ra=2ab78ed0
Illegal instruction (core dumped)
% uname -a
Linux elan 2.4.3 #1 Sun Apr 22 23:46:19 PDT 2001 mips unknown
% rpm -q glibc gcc
glibc-2.2.4-11.2
gcc-2.96-97.2
%

This happens whether it's a native build of glibc or the one from
oss.sgi.com. The kernel is from the simple dir on oss.

With a 3rd Sept CVS 2.4.8 kernel under no load the pthreads program
runs ok, but under load (a big rm -rf over NFS for instance), it
fails like above, or fails like:

% ./blah
pid=681 Init mutex
pid=681 About to create thread: mythread
pid=681 about to cond_wait for mythread init 1.
Segmentation fault (core dumped)
%

Also I found I could only build X natively on the Indy by disabling the
pthreads parts; and maybe it's a similar 'Illegal Instruction' error in
the 'conftest' program that seems to be stopping mozilla from building??
(at least under kernel 2.4.3 which otherwise seems more stable than 2.4.8)

cheers,
robin
