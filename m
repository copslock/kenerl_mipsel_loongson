Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 26 Aug 2007 02:05:20 +0100 (BST)
Received: from smtp108.plus.mail.mud.yahoo.com ([68.142.206.241]:15747 "HELO
	smtp108.plus.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20025899AbXHZBFL (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 26 Aug 2007 02:05:11 +0100
Received: (qmail 93778 invoked from network); 26 Aug 2007 01:04:04 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Received:X-YMail-OSG:Date:From:X-X-Sender:To:cc:Subject:In-Reply-To:Message-ID:References:MIME-Version:Content-Type;
  b=RfOyfF/RnqfRy17/xVgIGtNPfTUaAtRjo5/4kytwtm12M7lQyWXWvJCuNSFHrbLW2jXTkS4ua0/RnKo6TgsBNmP8CSGc4+yo9t1FDo3lXMdivNIT6CsM1JvUauvpU6T7bsqcXoo+sEfYt9pIZbNT+qXTeWZc+l//+Du72vF6ztA=  ;
Received: from unknown (HELO zeus.tetracon-eng.net) (jscottkasten@72.185.69.24 with login)
  by smtp108.plus.mail.mud.yahoo.com with SMTP; 26 Aug 2007 01:04:04 -0000
X-YMail-OSG: WYVBoDYVM1m4fCuYXeJz3sR0Uy1WTXNnSiYCtfhp_J7BuC28jd2g4fGl4NK2iPxB6gxafhIPoRSEw9zE5CkM4YmtKjdsDn0_3bwqiUok1NodZO2jvNQKU7YjvYMAig--
Date:	Sat, 25 Aug 2007 20:46:46 -0400
From:	"J. Scott Kasten" <jscottkasten@yahoo.com>
X-X-Sender: jsk@zeus.tetracon-eng.net
To:	Stuart Longland <redhatter@gentoo.org>
cc:	linux-mips@linux-mips.org
Subject: Re: IP32 RM5200 CPU modules... PROM requirements?
In-Reply-To: <46CFF67B.9050101@gentoo.org>
Message-ID: <Pine.SGI.4.60.0708252042140.4891@zeus.tetracon-eng.net>
References: <46CFF67B.9050101@gentoo.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-Path: <jscottkasten@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16285
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jscottkasten@yahoo.com
Precedence: bulk
X-list: linux-mips


Do you still have a bootable IRIX image for your O2?  If so, kick into 
swmgr and look to see if it lists the O2 prom update package as installed. 
I don't think it is part of the default install, but is on the overlays. 
Once you have that on the box, use swmgr to list the files in the package 
and locate any docs, man pages, etc...

RM5200 is a specific kernel target for the linux builds.

-S-

On Sat, 25 Aug 2007, Stuart Longland wrote:

> Hi All...
> 	This isn't so much a Linux/MIPS related question, but rather an SGI
> one, anyway.
>
> 	I've recently purchased an RM5200 CPU module for my O2 (which presently
> runs a 180MHz R5000).  I powered down the box, pulled the system board
> out, and swapped the CPU modules over.
>
> 	Upon doing this, I get a "Unsupported CPU type" message on serial
> console, and the box refuses to start.  I figure this is because my PROM
> is too old to support the RM5200.  Does anyone have any pointers
> regarding how one upgrades the PROM?  (I still have both CPU modules.)
> Or am I up for a newer system board in order to benefit from the new CPU?
>
> 	Also, once I have the CPU going ... do I need to do anything special
> kernel-wise, or will my existing R5000 kernel work?
>
> Regards,
> --
> Stuart Longland (aka Redhatter)              .'''.
> Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
> . . . . . . . . . . . . . . . . . . . . . .   .'.'
> http://dev.gentoo.org/~redhatter             :.'
>
> I haven't lost my mind...
>  ...it's backed up on a tape somewhere.
>
>
