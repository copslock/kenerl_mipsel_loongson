Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0D54j428891
	for linux-mips-outgoing; Sat, 12 Jan 2002 21:04:45 -0800
Received: from groucho.maths.monash.edu.au (groucho.maths.monash.edu.au [130.194.160.211])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0D54dg28883
	for <linux-mips@oss.sgi.com>; Sat, 12 Jan 2002 21:04:39 -0800
Received: (from rjh@localhost)
	by groucho.maths.monash.edu.au (8.8.8/8.8.8) id EAA27646
	for linux-mips@oss.sgi.com; Sun, 13 Jan 2002 04:04:35 GMT
From: Robin Humble <rjh@groucho.maths.monash.edu.au>
Message-Id: <200201130404.EAA27646@groucho.maths.monash.edu.au>
Subject: Re: libtool warning on redhat 7.1 native mipsel compile
To: linux-mips@oss.sgi.com
Date: Sun, 13 Jan 2002 15:04:35 +1100 (EDT)
In-Reply-To: <20020112092217.A15384@lucon.org> from "H . J . Lu" at Jan 12, 2002 09:22:17 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


H.J. writes:
>On Sun, Jan 13, 2002 at 12:36:21AM +1100, Robin Humble wrote:
>> >Ok. Please try
>> >ftp://oss.sgi.com/pub/linux/mips/redhat/7.1/SRPMS/libtool-1.3.5-8.3.src.rpm
>> unfortunately this doesn't work. Same output as the orig 7.1 rpm or a
>> stock newer libtool :-/
>Please tell me how to reproduce it.

try --rebuild on these for example: imlib, gconf, gnome-python, mozilla.

the libtool problem means that they refuse to build shared libs and
only make the .a's. this leads to problems down the track when other
apps expect the .so's to be present.

Output from configure/libtool varies, but for example it typically
looks like this:
...
*** Warning: This library needs some functionality provided by -lm.
*** I have the capability to make that library automatically link in when
*** you link to this library.  But I can only do this if you have a
*** shared version of the library, which you do not appear to have.

*** Warning: This library needs some functionality provided by -ldb1.
*** I have the capability to make that library automatically link in when
*** you link to this library.  But I can only do this if you have a
*** shared version of the library, which you do not appear to have.
*** The inter-library dependencies that have been dropped here will be
*** automatically added whenever a program is linked with this library
*** or is declared to -dlopen it.
...

Although in this case (control-center) it still built the .so's just
gave lots of warnings like this.


I guess the s390 arch had the same problems, hence the patch that's in
recent libtool srpms. I just added mips* as well - AFAICT this avoids
libtool trying to use 'file' at all, and hence avoid any issues with 'file'
output changing.

Hope that's of some help.

cheers,
robin
