Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA32817 for <linux-archive@neteng.engr.sgi.com>; Tue, 29 Sep 1998 14:56:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA77284
	for linux-list;
	Tue, 29 Sep 1998 14:54:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA92963
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 29 Sep 1998 14:54:51 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00518
	for <linux@cthulhu.engr.sgi.com>; Tue, 29 Sep 1998 14:52:48 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0zO7hE-0027pOC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Tue, 29 Sep 1998 22:52:36 +0100 (MET)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0zO7h2-002PBzC; Tue, 29 Sep 98 23:52 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id XAA03067;
	Tue, 29 Sep 1998 23:24:56 +0200
Message-ID: <19980929232455.30571@alpha.franken.de>
Date: Tue, 29 Sep 1998 23:24:55 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: VCEI/VCED handling
References: <19980929011414.43485@alpha.franken.de> <19980929015003.E2215@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980929015003.E2215@uni-koblenz.de>; from ralf@uni-koblenz.de on Tue, Sep 29, 1998 at 01:50:03AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Sep 29, 1998 at 01:50:03AM +0200, ralf@uni-koblenz.de wrote:
> We've got code of which we're shure that it is correct.  Nevertheless
> Linux ist still fragile on SC machines.  I've been tracking this in
> private emails with Ulf but so far only with limited success.  Aside of
> the missing VCED / VCEI handlers there must be something else that is
> broken.

As I understand the problem now, I wrote the little test program below.
If I'll try it on a R4600PC Indy or a R4000PC Olivetti with Linux, I don't
get what I would expect. On IRIX, Linux/Alpha (I have to change the offset
between the two mapping to 0x2000, because of the bigger page size on Alphas)
and Linux/x86 the program works. IMHO this is a showstopper as we don't handle 
cache aliases right.  

How does IRIX solve this problem ? Does it disable caching for shared 
writeable pages ?

Thomas.

#include <sys/types.h>
#include <sys/fcntl.h>
#include <sys/mman.h>
#include <stdio.h>
#include <unistd.h>

unsigned char buf[1024];

int main (int argc, char *argv[])
{
	int fd;
	unsigned char *mem1,*mem2;

	if ((fd = open ("mmap_file",O_RDWR|O_CREAT,0644)) < 0) {
		perror ("open");
		exit (1);
	}
	write (fd, buf, sizeof(buf));

	if ((mem1 = mmap (NULL, 1024, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0)) == (unsigned char *)-1) {
		perror ("mmap mem1");
		exit (2);
	}
	if ((mem2 = mmap (mem1+0x1000, 1024, PROT_READ|PROT_WRITE,MAP_SHARED|MAP_FIXED, fd, 0)) == (unsigned char *)-1) {
		perror ("mmap mem2");
		exit (3);
	}
	printf ("mem1 %p, mem2 %p\n",mem1,mem2);

	*mem1 = 0x55;
	printf ("*mem1 = %x, *mem2 = %x\n",*mem1,*mem2);

	*mem1 = 0xaa;
	printf ("*mem1 = %x, *mem2 = %x\n",*mem1,*mem2);

	*mem2 = 0x33;
	printf ("*mem2 = %x, *mem1 = %x\n",*mem2,*mem1);

	*mem2 = 0xcc;
	printf ("*mem2 = %x, *mem1 = %x\n",*mem2,*mem1);

	return 0;
}

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
