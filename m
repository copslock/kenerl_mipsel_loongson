Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6CNFee21645
	for linux-mips-outgoing; Thu, 12 Jul 2001 16:15:40 -0700
Received: from mail.foobazco.org (snowman.foobazco.org [198.144.194.230])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6CNFdV21634
	for <linux-mips@oss.sgi.com>; Thu, 12 Jul 2001 16:15:39 -0700
Received: by mail.foobazco.org (Postfix, from userid 1014)
	id 522823E90; Thu, 12 Jul 2001 16:07:54 -0700 (PDT)
Date: Thu, 12 Jul 2001 16:07:54 -0700
From: Keith M Wesolowski <wesolows@foobazco.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: SGI MIPS list <linux-mips@oss.sgi.com>,
   Debian MIPS list <debian-mips@lists.debian.org>
Subject: Re: smbfs on DECstations R3k
Message-ID: <20010712160754.A8917@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010712224300.C18294@lug-owl.de>
User-Agent: Mutt/1.3.18i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, Jul 12, 2001 at 10:43:00PM +0200, Jan-Benedict Glaw wrote:

> I tried to compile smbfs support for DECstations R3k. The compiler
> (that one shipping with the make-cross script) fails in
> proc.c:smb_proc_setattr_trans2 with normal CFLAGS. Setting -O0
> (instead of -O2) lets me compile the source.
> 
> Is anybody interested in fixing the compiler? I do definitely not
> have the knowhow to do that...

Can you reproduce this bug with gcc 3.0?

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
------(( Project Foobazco Coordinator and Network Administrator ))------
 	"There is no such song as 'Acid Acid Acid' by 'The Acid Heads'
	 but there might as well be." --jwz
