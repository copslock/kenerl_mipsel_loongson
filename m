Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f33GXrg08065
	for linux-mips-outgoing; Tue, 3 Apr 2001 09:33:53 -0700
Received: from cvsftp.cotw.com (cvsftp.cotw.com [208.242.241.39])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f33GXqM08059
	for <linux-mips@oss.sgi.com>; Tue, 3 Apr 2001 09:33:52 -0700
Received: from cotw.com (dhcp-050.inter.net [192.168.10.50])
	by cvsftp.cotw.com (8.9.3/8.9.3) with ESMTP id LAA16615;
	Tue, 3 Apr 2001 11:33:43 -0500
Message-ID: <3AC9F069.ED631062@cotw.com>
Date: Tue, 03 Apr 2001 10:46:49 -0500
From: "Steven J. Hill" <sjhill@cotw.com>
Reply-To: sjhill@cotw.com
X-Mailer: Mozilla 4.73 [en] (X11; I; Linux 2.4.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
CC: linux-mips@oss.sgi.com
Subject: Re: Binutils fixed to deal with 'insmod' issue and discussion...
References: <00a901c0bb6f$d3e77820$0deca8c0@Ulysses> <3AC90E16.AEF59359@cotw.com> <20010403041740.G5099@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thiemo Seufer wrote:
> 
> >Without the binutils patch, all binaries compiled for MIPS/Linux
> >will be IRIX flavored which was the whole problem.
> 
> Please may You elaborate about this? AFAICS, the IRIX flavour
> can't be a problem by itself.
> 
Yes, it is. Take a look at the IRIX_COMPAT macro in 'bfd/elf32-mips.c'
which checks to see what type (flavor) of binary you are using. Before
the patch all elf32-mips targets used the IRIX way of determining a if
a symbol was global or not (see function that determines this at around
line 2301 in 'bfd/elf32-mips.c'). By using IRIX flavored symbols, LOCAL
and GLOBAL symbols are not sorted correctly and we get the problems with
symbols being out of order in Linux kernel modules. With the patch and
using 'elfXX-tradXXmips' as the new output targets, we sort local and
global symbols correctly.

> Changing the MIPS/Linux ABI to circumvent a toolchain bug seems
> to be a bit extremistic. Am I missing some important details?
> 
Yes, you are missing a few things, but I attribute that to my poor
communications in my first email. My point is that the IRIX_COMPAT
and SGI_COMPAT macros are used to check what type of target we are
using in order to sort local and global symbols properly and many
other places in the BFD library to creat binaries for Linux or for
IRIX. The way (that I think) this should be done is to use the
target 'elfXX-tradXXmips' and make that the default target utilized
for MIPS-Linux targets. This is the decision that I wanted everyone's
input on. I hope I explained this better. If not, ask more questions
and I will try again. Cheers.

-Steve

-- 
 Steven J. Hill - Embedded SW Engineer
 Public Key: 'http://www.cotw.com/pubkey.txt'
 FPR1: E124 6E1C AF8E 7802 A815
 FPR2: 7D72 829C 3386 4C4A E17D
