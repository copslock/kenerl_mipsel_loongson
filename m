Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4531Gq01535
	for linux-mips-outgoing; Fri, 4 May 2001 20:01:16 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4531FF01532
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 20:01:15 -0700
Received: from galt.foobazco.org (galt.foobazco.org [198.144.194.227])
	by mail.foobazco.org (Postfix) with ESMTP
	id C8831F1A9; Fri,  4 May 2001 20:00:18 -0700 (PDT)
Received: by galt.foobazco.org (Postfix, from userid 1014)
	id E164E1F428; Fri,  4 May 2001 20:00:51 -0700 (PDT)
Date: Fri, 4 May 2001 20:00:51 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Patrick Fisher <pbfisher@seas.upenn.edu>
Cc: linux-mips@oss.sgi.com
Subject: Re: Executing Programs from initrd
Message-ID: <20010504200051.A1302@foobazco.org>
References: <019801c0d50c$32024fb0$2dd75b82@serendipity>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <019801c0d50c$32024fb0$2dd75b82@serendipity>; from pbfisher@seas.upenn.edu on Fri, May 04, 2001 at 10:36:31PM -0400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 04, 2001 at 10:36:31PM -0400, Patrick Fisher wrote:

>     However, I can't run any binaries other than this one and the shell.  I
> wrote an additional Hello World program in C, compiled it for mipsel, and
> put it in the ramdisk.  The executable is definitely there when I boot on
> the nino - I can send it all to the serial console and see that it exists.
> However, any attempt to execute it returns "No such file or directory".

Did you compile with -static?  If not, the system will attempt to load
it with /lib/ld.so.1.  Do you have that file?  Is it executable?  What
about libc?

If you have a file starting with

#! /bin/fux0r

and /bin/fux0r does not exist, the execution will fail with that exact
error.  In fact from the system's point of view it's the same thing
with /lib/ld.so.1 instead of /bin/fux0r.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
