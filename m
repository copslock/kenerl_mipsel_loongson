Received:  by oss.sgi.com id <S42246AbQGQBZV>;
	Sun, 16 Jul 2000 18:25:21 -0700
Received: from rno-dsl0b-218.gbis.net ([216.82.145.218]:63499 "EHLO
        ozymandias.foobazco.org") by oss.sgi.com with ESMTP
	id <S42208AbQGQBYw>; Sun, 16 Jul 2000 18:24:52 -0700
Received: (from wesolows@localhost)
	by ozymandias.foobazco.org (8.9.3/8.9.3) id SAA00988
	for linux-mips@oss.sgi.com; Sun, 16 Jul 2000 18:24:28 -0700
Date:   Sun, 16 Jul 2000 18:24:28 -0700
From:   Keith M Wesolowski <wesolows@foobazco.org>
To:     linux-mips@oss.sgi.com
Subject: Analysis of Samba configure oops
Message-ID: <20000716182428.A972@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Hi all,

I've been analysing the infamous Samba configure oops and I think I've
taken it as far as I can. Hopefully someone here will know what's
wrong.

The configuration: sgi indy 4400sc/200 (R4000SC V6.0), current CVS.

The trigger (from samba configuration, tests/shared_mmap.c):

#include <unistd.h>
#include <sys/mman.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <stdlib.h>

#define DATA "conftest.mmap"

#ifndef MAP_FILE
#define MAP_FILE 0
#endif

int main()
{
	int *buf;
	int i; 
	int fd = open(DATA,O_RDWR|O_CREAT|O_TRUNC,0666);
	int count=7;

	if (fd == -1) exit(1);

	for (i=0;i<10000;i++) {
		write(fd,&i,sizeof(i));
	}

	close(fd);

	if (fork() == 0) {
		fd = open(DATA,O_RDWR);
		if (fd == -1) exit(1);

		buf = (int *)mmap(NULL, 10000*sizeof(int), 
				   (PROT_READ | PROT_WRITE), 
				   MAP_FILE | MAP_SHARED, 
				   fd, 0);

		while (count-- && buf[9124] != 55732) sleep(1);

		if (count <= 0) exit(1);

		buf[1763] = 7268;
		exit(0);
	}

	fd = open(DATA,O_RDWR);
	if (fd == -1) exit(1);

	buf = (int *)mmap(NULL, 10000*sizeof(int), 
			   (PROT_READ | PROT_WRITE), 
			   MAP_FILE | MAP_SHARED, 
			   fd, 0);

	if (buf == (int *)-1) exit(1);

	buf[9124] = 55732;

	while (count-- && buf[1763] != 7268) sleep(1);

	unlink(DATA);
		
	if (count > 0) exit(0);
	exit(1);
}

The oops:

Unable to handle kernel paging request at virtual address 0000003c, epc == 8801eb20, ra == 8803a108
$0 : 00000000 1000fc00 000003f8 00000000
$4 : 000000fb 00005eda 2acfe000 8816c8a0
$8 : 8d6d8360 ffff00ff 1000fc01 00000001
$12: 00000001 7ffffa10 00000003 00400c0c
$16: 00346e80 0d1ba79f 00000001 2acfe000
$20: 000fe000 8da1c3f8 000fd000 8d6d8360
$24: 00000014 2ac26590
$28: 8d776000 8d777e18 8d9372ac 8803a108
epc   : 8801eb20
Status: 1000fc02
Cause : 00000008
Process conftest (pid: 5154, stackpage=8d776000)
Stack: 88502c80 8d9372ac 00000001 2acf9000 000fd000 003fffff 8d9372ac 2ad07000
       00000000 2acfd000 2ac00000 00107000 00000000 00107000 00000000 003fffff
       2ac00000 00000000 8d6d8360 00000001 2acfd000 8816c8a0 0000a000 8d6d86a0
       00000000 1002e510 00000000 8803a39c 00004000 2acfd000 00000000 00000001
       88036828 880368b0 8816c8a0 8fcc9b60 000478e5 00000065 00000001 8816c8a0
       8d776000 ...
Call Trace: [<8803a39c>] [<88036828>] [<880368b0>] [<880296b0>] [<88025208>] [<8
802c914>] [<88013ef8>] [<8802cb8c>] [<88010c28>] [<88010c28>]
Code: 8f83002c  8d040014  8ce5003c <8c62003c> 10a2007d  30840004  3c028819  8c42

>>RA;  8803a108 <filemap_sync+204/488>
>>PC;  8801eb20 <r4k_flush_cache_page_s128d16i16+78/324>   <=====
Trace; 8803a39c <filemap_unmap+10/1c>
Trace; 88036828 <exit_mmap+78/198>
Trace; 880368b0 <exit_mmap+100/198>
Trace; 880296b0 <mmput+40/7c>
Trace; 88025208 <sys_rt_sigaction+88/e8>
Code;  8801eb14 <r4k_flush_cache_page_s128d16i16+6c/324>
0000000000000000 <_PC>:
Code;  8801eb14 <r4k_flush_cache_page_s128d16i16+6c/324>
   0:   8f83002c  lw      $v1,44($gp)
Code;  8801eb18 <r4k_flush_cache_page_s128d16i16+70/324>
   4:   8d040014  lw      $a0,20($t0)
Code;  8801eb1c <r4k_flush_cache_page_s128d16i16+74/324>
   8:   8ce5003c  lw      $a1,60($a3)
Code;  8801eb20 <r4k_flush_cache_page_s128d16i16+78/324>   <=====
   c:   8c62003c  lw      $v0,60($v1)   <=====
Code;  8801eb24 <r4k_flush_cache_page_s128d16i16+7c/324>
  10:   10a2007d  beq     $a1,$v0,208 <_PC+0x208> 8801ed1c <r4k_flush_cache_page_s128d16i16+274/324>
Code;  8801eb28 <r4k_flush_cache_page_s128d16i16+80/324>
  14:   30840004  andi    $a0,$a0,0x4
Code;  8801eb2c <r4k_flush_cache_page_s128d16i16+84/324>
  18:   3c028819  lui     $v0,0x8819
Code;  8801eb30 <r4k_flush_cache_page_s128d16i16+88/324>
  1c:   8c420000  lw      $v0,0($v0)

The matching code (arch/mips/mm/r4xx0.c:1600):

        if(mm->context != current->mm->context) {

The analysis:

The fault address is 0x3c. The offset of mm in current is 0x2c. Thus
the immediate cause appears to be that current->mm is 0x10, obviously
nonsense.

Further investigation yields this call sequence: exit_mmap =>
filemap_unmap => filemap_sync => filemap_sync_pmd_range =>
filemap_sync_pte_range => filemap_sync_pte => flush_cache_page

Anybody?

-- 
Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows/
(( Project Foobazco Coordinator and Network Administrator )) aiieeeeeeee!
"The list of people so amazingly stupid they can't even tie their shoes?"
"Yeah, you know, /etc/passwd."
