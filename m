Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2Q3Ocm00726
	for linux-mips-outgoing; Sun, 25 Mar 2001 19:24:38 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2Q3ObM00723
	for <linux-mips@oss.sgi.com>; Sun, 25 Mar 2001 19:24:37 -0800
Received: from sydney.sydney.sgi.com ([134.14.48.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id TAA02488
	for <linux-mips@oss.sgi.com>; Sun, 25 Mar 2001 19:24:36 -0800 (PST)
	mail_from (kaos@ocs.com.au)
Received: from kao2.melbourne.sgi.com by sydney.sydney.sgi.com via ESMTP (950413.SGI.8.6.12/930416.SGI)
	 id NAA17034; Mon, 26 Mar 2001 13:23:15 +1000
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Joe deBlaquiere <jadb@redhat.com>
cc: "Kevin D. Kissell" <kevink@mips.com>, linux-mips@oss.sgi.com
Subject: Re: Embedded MIPS/Linux Needs 
In-reply-to: Your message of "Sun, 25 Mar 2001 21:01:52 CST."
             <3ABEB120.8020609@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 26 Mar 2001 13:23:15 +1000
Message-ID: <19957.985576995@kao2.melbourne.sgi.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

You like long lines, don't you ;)  Reflowed for readability.

On Sun, 25 Mar 2001 21:01:52 -0600, 
Joe deBlaquiere <jadb@redhat.com> wrote:
>1. Would it be possible to lump some of the different MIPS variants
>together more closely? In my dream world I could build one kernel that
>would boot on every mips architecture. This way the work can be more
>general. As it stands now, if you want Tx39 or Vr41 variants you're
>working out of a different tree.

FWIW I am working on a Makefile rewrite for 2.5 which will help with
this problem.  Instead of one 120Mb kernel source tree for each
architecture, 2.5 will support logical kernel source trees and separate
source and object directories.  The logical source is built up from
base kernel code (Linus's tarball) plus zero or more layers that
contain additional or different code.  So you compile

2.4.x -> ix86 object directory
2.4.x + common mips -> common mips object directory
2.4.x + common mips + Tx39 -> Tx39 object directory
2.4.x + common mips + Vr41 -> Vr41 object directory

All use the same untouched 2.4.x tarball as the base.  You can compile
multiple targets from the same source at the same time, using different
object directories.  A change to base 2.4.x or to common mips is
automatically seen by all the object directories.
