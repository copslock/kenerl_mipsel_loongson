Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Oct 2002 13:30:46 +0100 (CET)
Received: from webmail24.rediffmail.com ([203.199.83.146]:22763 "HELO
	webmail24.rediffmail.com") by linux-mips.org with SMTP
	id <S1122133AbSJaMap>; Thu, 31 Oct 2002 13:30:45 +0100
Received: (qmail 6537 invoked by uid 510); 31 Oct 2002 12:32:14 -0000
Date: 31 Oct 2002 12:32:14 -0000
Message-ID: <20021031123214.6536.qmail@webmail24.rediffmail.com>
Received: from unknown (203.200.7.157) by rediffmail.com via HTTP; 31 Oct 2002 12:32:14 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: uclibc is faulty for big endian cpu's..?
Content-type: text/plain;
	charset=iso-8859-1;
	format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 542
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

I was trying a ramdisk with busybox compiled with uclibc(big 
emndian) for big endian mips IDT  board.
but while exec'ing it fails in identifying the ELF HEADER of 
binaries , though it reads correctly ELFMAG field.
in fs/binfmt_elf.c
if (memcmp(elf_ex.e_ident, ELFMAG, SELFMAG) != 0)
                 goto out;
/****above passes but these following tests fails*****/

         if (elf_ex.e_type != ET_EXEC && elf_ex.e_type != 
ET_DYN)
           goto out;

         if (!elf_check_arch(&elf_ex))
             goto out;

ET_EXEC is 0x2 and EM_MIPS is 0x8 respectively.
on target it reads e_type as 0x200 and e_machine as 0x800
now on my host after mount -o loop the ramdisk and taking hexdump 
of binary give me

# hexdump ./sh | more

0000000 457f 464c 0201 0001 0000 0000 0000 0000
0000010 0200 0800 0000 0100 4000 b000 0000 3400

here in second line the et_type and e_machine field of
elf header is stored in little endian order.

for more clarity # hexdump -c ./sh gives
0000000 177   E   L   F 001 002 001  \0  \0  \0  \0  \0  \0  \0  
\0  \0
0000010  \0 002  \0  \b  \0  \0  \0 001  \0   @  \0   °  \0  \0  
\0   4

am i thinking in right direction that my uclibc is not generating 
correct binaries for big endian mips?
should i give a try with another lib package?

Best Rergards,
Atul....
__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
