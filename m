Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6L9RP116732
	for linux-mips-outgoing; Sat, 21 Jul 2001 02:27:25 -0700
Received: from fe040.worldonline.dk (fe040.worldonline.dk [212.54.64.205])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6L9RMV16729
	for <linux-mips@oss.sgi.com>; Sat, 21 Jul 2001 02:27:22 -0700
Received: (qmail 11697 invoked by uid 0); 21 Jul 2001 09:27:16 -0000
Received: from 213.237.49.98.skovlyporten.dk (HELO tuxedo.skovlyporten.dk) (213.237.49.98)
  by fe040.worldonline.dk with SMTP; 21 Jul 2001 09:27:16 -0000
Received: by tuxedo.skovlyporten.dk (Postfix, from userid 501)
	id 54DEE2608A; Sat, 21 Jul 2001 11:27:15 +0200 (CEST)
Date: Sat, 21 Jul 2001 11:27:15 +0200
From: Lars Munch Christensen <c948114@student.dtu.dk>
To: linux-mips@oss.sgi.com
Subject: mips64 linker bug?
Message-ID: <20010721112715.C2335@tuxedo.skovlyporten.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi All

I think I have found a linker bug!

I use the following cross compilers from sgi's ftp:

binutils-mips64-linux-2.9.5-3.i386.rpm
egcs-mips64-linux-1.1.2-4.i386.rpm
binutils-mips64el-linux-2.9.5-3.i386.rpm
egcs-mips64el-linux-1.1.2-4.i386.rpm

Anyway the bug is that static functions get linked wrongly.
Test program:
---------------------
/* This function has to be here to get the error */
int test1(void) {
	return 1;
}

static int test2(void) { /* <---- notice this static */
	return 2;
}

int main() {

	test2();
	return 1;
}

---------------------

Compile and link with:

mips64-linux-gcc -mcpu=r4600 -mabi=64 -mips3 -g -c -O2  -o main.o main.c
mips64-linux-ld -m elf64btsmip  -nostdlib -e main main.o -o main.elf

Now I see the bug where main calls test2:

Doing a 'mips64-linux-objdump -S test.elf' gives me:

main.elf:     file format elf64-bigmips

Disassembly of section .text:

00000000100000f0 <test1>:
        return 1;
    100000f0:   03e00008        jr      $ra
    100000f4:   24020001        li      $v0,1

00000000100000f8 <test2>:
}

static int test2(void) {
        return 2;
    100000f8:   03e00008        jr      $ra
    100000fc:   24020002        li      $v0,2

0000000010000100 <main>:
}

int main() {
    10000100:   67bdfff0        0x67bdfff0
    10000104:   ffbf0000        0xffbf0000

0000000010000108 <$LM6>:

        test2();
    10000108:   0c000044        jal     10000110 <$LM7> <-- 110 ????????????
    1000010c:   00000000        nop

0000000010000110 <$LM7>:
        return 1;
    10000110:   dfbf0000        0xdfbf0000
    10000114:   24020001        li      $v0,1
    10000118:   03e00008        jr      $ra
    1000011c:   67bd0010        0x67bd0010


When removing the static I get the correct address 100000f8 ?!?

Am I missing something. Please help me, I have spend 3 days
chasing this bug, until I figures out it was related to 
static functions.

btw why isn't everything disassembled?

Thanks
Lars Munch
