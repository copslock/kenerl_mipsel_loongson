Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f3NCR8K22075
	for linux-mips-outgoing; Mon, 23 Apr 2001 05:27:08 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f3NCR6M22071
	for <linux-mips@oss.sgi.com>; Mon, 23 Apr 2001 05:27:07 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id GAA12280;
	Mon, 23 Apr 2001 06:26:51 -0500
Message-ID: <3AE422B3.C61A70F7@cotw.com>
Date: Mon, 23 Apr 2001 07:40:19 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Guido Guenther <guido.guenther@gmx.net>
CC: linux-mips@oss.sgi.com
Subject: Re: loadable kernel modules
References: <20010422010720.A1386@bilbo.physik.uni-konstanz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Guido Guenther wrote:
> 
> could someone enlighten me about the current status of loadable modules?
> When using current cvs kernel & cvs binutils and Keith's
> gcc-3.0-20010303 as crosstoolchain I'm no longer seeing the "symbol xy
> with index 10 exceeds local_symtab_size..." but therefore I'm getting
> lot's of unresolved symbols(e.g. printk) when trying to insmod a module.
> Any help appreciated,
>
Sure, I fixed the bug in binutils that broke kernel modules. It's been
in CVS for almost two weeks now.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
