Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB8FBWI13806
	for linux-mips-outgoing; Sat, 8 Dec 2001 07:11:32 -0800
Received: from mail.gmx.net (sproxy.gmx.de [213.165.64.20])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB8FBSo13803
	for <linux-mips@oss.sgi.com>; Sat, 8 Dec 2001 07:11:28 -0800
Received: (qmail 1760 invoked by uid 0); 8 Dec 2001 14:11:21 -0000
Received: from gierlitz.rfc822.org (HELO bogon.ms20.nix) (195.71.97.228)
  by mail.gmx.net (mp011-rz3) with SMTP; 8 Dec 2001 14:11:21 -0000
Received: by bogon.ms20.nix (Postfix, from userid 1000)
	id 4E872366B9; Sat,  8 Dec 2001 15:11:42 +0100 (CET)
Date: Sat, 8 Dec 2001 15:11:42 +0100
From: Guido Guenther <guido.guenther@gmx.net>
To: linux-mips@oss.sgi.com
Subject: understanding elf_machine_load_address
Message-ID: <20011208141141.GA11437@bogon.ms20.nix>
Mail-Followup-To: linux-mips@oss.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,
I'm trying to understand to following snippet from glibc's
sysdeps/mips/dl-machine.h:

elf_machine_load_address (void)
{
  ElfW(Addr) addr;
  asm ("	.set noreorder\n"
       "	la %0, here\n"
       "	bltzal $0, here\n"
       "	nop\n"
       "here:	subu %0, $31, %0\n"
       "	.set reorder\n"
       :	"=r" (addr)
       :	/* No inputs */
       :	"$31");
  return addr;
}

As of my understanding addr is zero since $31-%0 is always
zero(%0 stored (before the subu) the address of 'here', as does $31
after the bltzal). Please beat me with a cluebat.
 -- Guido
