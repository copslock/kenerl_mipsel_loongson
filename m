Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g072Fvs23388
	for linux-mips-outgoing; Sun, 6 Jan 2002 18:15:57 -0800
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by oss.sgi.com (8.11.2/8.11.3) with ESMTP id g072Fmg23370
	for <linux-mips@oss.sgi.com>; Sun, 6 Jan 2002 18:15:49 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id g071FSb05938;
	Sun, 6 Jan 2002 23:15:28 -0200
Date: Sun, 6 Jan 2002 23:15:28 -0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Dan Aizenstros <daizenstros@quicklogic.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Oops in do_mounts.c file.
Message-ID: <20020106231528.A3806@dea.linux-mips.net>
References: <sc35a6be.092@quicklogic.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <sc35a6be.092@quicklogic.com>; from daizenstros@quicklogic.com on Fri, Jan 04, 2002 at 12:57:00PM -0800
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Fri, Jan 04, 2002 at 12:57:00PM -0800, Dan Aizenstros wrote:

> I am getting an oops in the mount_root function if I
> pass root=/dev/nfs to my 2.5.1 kernel.
> 
> I am also getting an oops in the mount_block_root
> function if I pass root=/dev/hda3 to my 2.5.1 kernel.
> 
> The problem appears to be related to the following two
> lines in the init/do_mounts.c file:
> 
> static char * __initdata root_mount_data;
> 
> static char * __initdata root_fs_names;
> 
> The __initdata macro appears to be incorrectly used.
> 
> In include/linux/init.h the explanation for the macro
> says the __initdata should appear after the variable
> name.  It also indicates that the variable shoud be
> initialized.

Old gcc was more restrictive about the position of __attribute__() than
current gccs.  The comment documents older gcc.  Old in this context
means older than egcs 1.1.2 which is currently the required minmum version
to compile the kernel.

> The attached patch fixes the problem.

And that's highly suspect.  No matter with or without your patch
root_mount_data and root_fs_names should endup in .data.init.  So if your
patch indeed has an effect that your compiler seems is suspect.

Can you try to look at the generated assembler source and object files and
check into which sections gcc places these variables?

  Ralf
