Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g139Y1N07084
	for linux-mips-outgoing; Sun, 3 Feb 2002 01:34:01 -0800
Received: from dea.linux-mips.net (a1as10-p200.stg.tli.de [195.252.189.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g139XuA07078
	for <linux-mips@oss.sgi.com>; Sun, 3 Feb 2002 01:33:57 -0800
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.1) id g138Wra20903;
	Sun, 3 Feb 2002 09:32:53 +0100
Date: Sun, 3 Feb 2002 09:32:53 +0100
From: Ralf Baechle <ralf@oss.sgi.com>
To: Girish Gulawani <girishvg@yahoo.com>
Cc: "MIPS/Linux List (SGI)" <linux-mips@oss.sgi.com>
Subject: Re: MIPS/Linux NonSGI
Message-ID: <20020203093253.J20021@dea.linux-mips.net>
References: <3C505900.9685DDE3@cotw.com> <003901c1a532$d01576e0$de920dd3@gol.com> <20020124174521.B8860@dea.linux-mips.net> <007001c1a97a$6e52a9e0$c1900dd3@gol.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <007001c1a97a$6e52a9e0$c1900dd3@gol.com>; from girishvg@yahoo.com on Wed, Jan 30, 2002 at 07:39:41PM +0900
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jan 30, 2002 at 07:39:41PM +0900, Girish Gulawani wrote:

> could solve the disk corruption problem, thanks to you. it was due to my
> over-confident source code for bus mastering device. while re-targeting the
> driver from vxworks to linux i had introduced a bug. its all working great
> now. thanks again. while this problem is solved  i have one more query.
> 
> as i mentioned earlier, our core supports page size of 16K. hence the mmu
> code is changed accordingly, for kernel 2.4.9. but any command load fails
> giving page alignment error. seems some problem from binfmt_elf.c file. i
> have build the command, ash, using egcc-2.91.66. to change the page
> alignment the option given was "--n16384". this option is surely wrong,
> hence could you tell me what is correct option? HOW TO CHANGE PAGE ALIGNMENT
> TO 16K WHILE LINKING USER COMMANDS??

I hate to say it but at this time we don't support any other pagesize
than 4kb on MIPS.  I haven't looked into details but I'd expect to hit
a number of subtle bugs when we go to a larger pagesize.  So I expect
your way to be stony.

  Ralf
