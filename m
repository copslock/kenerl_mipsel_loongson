Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Nov 2002 14:25:34 +0100 (CET)
Received: from webmail34.rediffmail.com ([203.199.83.247]:11651 "HELO
	mailweb34.rediffmail.com") by linux-mips.org with SMTP
	id <S1123960AbSKLNZe>; Tue, 12 Nov 2002 14:25:34 +0100
Received: (qmail 31138 invoked by uid 510); 12 Nov 2002 13:25:12 -0000
Date: 12 Nov 2002 13:25:12 -0000
Message-ID: <20021112132512.31137.qmail@mailweb34.rediffmail.com>
Received: from unknown (203.197.184.16) by rediffmail.com via HTTP; 12 Nov 2002 13:25:12 -0000
MIME-Version: 1.0
From: "atul srivastava" <atulsrivastava9@rediffmail.com>
Reply-To: "atul srivastava" <atulsrivastava9@rediffmail.com>
To: linux-mips@linux-mips.org
Subject: problem with big endian binutils..?
Content-type: text/plain;
	format=flowed
Content-Disposition: inline
Return-Path: <atulsrivastava9@rediffmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: atulsrivastava9@rediffmail.com
Precedence: bulk
X-list: linux-mips

Have anybody confirmed stability of binutils for big endian 
mips?
while little endian gives me no problem
but i am simply unable to make a working big endian ramdisk.

specific problem is in identifying the e_type and e_machine fields 
in elf header of executables.
expected value of e_type is 0x2(ET_EXEC) amd e_machine is 
0x8(EM_MIPS)
but those are read as 0x200 and 0x800 respectivly ..this is 
obviously the endianness problem.

I have tried big endian ramdisk from 
ftp://ftp.ltc.com/pub/linux/mips/ramdisk/ramdisk
and also tried compiling one using uclibc package , both
failed because of same reason.

when i run file command on those executables after mounting the 
ramdisk on my host i get o/p like

ELF 32-bit LSB executable, MIPS R3000_BE - invalid byte order, 
version 1, statically linked, stripped

though i see lot of mails regarding "invalid byteorder" but I 
didn't find specific suggestions.

if somebody has experienced similar problems , pls. give me 
guidance.

Best Regards,
Atul


__________________________________________________________
Give your Company an email address like
ravi @ ravi-exports.com.  Sign up for Rediffmail Pro today!
Know more. http://www.rediffmailpro.com/signup/
