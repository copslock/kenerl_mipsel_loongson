Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f4507P928916
	for linux-mips-outgoing; Fri, 4 May 2001 17:07:25 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f4507OF28913
	for <linux-mips@oss.sgi.com>; Fri, 4 May 2001 17:07:24 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id DA315F1A9; Fri,  4 May 2001 17:06:27 -0700 (PDT)
Date: Fri, 4 May 2001 17:06:27 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: "John D. Davis" <johnd@Stanford.EDU>
Cc: Bas Benschop <b.benschop@tn.utwente.nl>,
   debian-mips <debian-mips@lists.debian.org>,
   linux-mips <linux-mips@oss.sgi.com>
Subject: Re: Indy Linux Install problem
Message-ID: <20010504170627.A19856@foobazco.org>
References: <Pine.LNX.4.21.0105040851230.14770-100000@chimay.tn.utwente.nl> <Pine.GSO.4.31.0105041651270.15717-100000@myth1.Stanford.EDU>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.31.0105041651270.15717-100000@myth1.Stanford.EDU>; from johnd@Stanford.EDU on Fri, May 04, 2001 at 04:57:24PM -0700
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, May 04, 2001 at 04:57:24PM -0700, John D. Davis wrote:

> I am using the recommended packages and the vmlinux kernel is on the IRIX
> server.  I am currently getting the following error:

Recommended by whom?

> VFS: Mounted root (nfs filesystem) readonly.
> Warning: unable to open an initial console.
> Kernel panic: Attempted to kill init!
> 
> I don't know why the fs is readonly. I explicitly put rw in the
> /etc/exports.  Is this why the initial console cannot be opened? I read

No.  That usually indicates that your root filesystem is defective.
See if /dev/console exists and is c 5 1.  If not, that's the source of
your console problem.

The init death problem seems more insidious.  Try passing init=/bin/sh
or so - this will be even more effective if you have a statically
linked shell like ash or sash to use.  Where did you get this
filesystem?  For that matter, where did you get this kernel?  There
are *lots* of both floating around, even on oss, that may be broken or
out of date.

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
	"Nothing motivates a man more than to see his boss put
	 in an honest day's work." -- The fortune file
