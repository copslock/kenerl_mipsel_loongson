Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA2823025 for <linux-archive@neteng.engr.sgi.com>; Fri, 3 Apr 1998 04:07:50 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF) id EAA7360765
	for linux-list;
	Fri, 3 Apr 1998 04:07:04 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980205.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA7322454;
	Fri, 3 Apr 1998 04:07:02 -0800 (PST)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam) via ESMTP id EAA05861; Fri, 3 Apr 1998 04:06:48 -0800 (PST)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-30.uni-koblenz.de [141.26.249.30])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id OAA06781;
	Fri, 3 Apr 1998 14:06:38 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id NAA03955;
	Fri, 3 Apr 1998 13:52:47 +0200
Message-ID: <19980403135245.23593@uni-koblenz.de>
Date: Fri, 3 Apr 1998 13:52:45 +0200
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: VCE exceptions
References: <19980402225314.63238@uni-koblenz.de> <199804022141.NAA01565@fir.engr.sgi.com> <19980403003623.50122@uni-koblenz.de> <199804022315.PAA01986@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=PXFtsOsTdHNUZQcU
X-Mailer: Mutt 0.85e
In-Reply-To: <199804022315.PAA01986@fir.engr.sgi.com>; from William J. Earl on Thu, Apr 02, 1998 at 03:15:03PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


--PXFtsOsTdHNUZQcU
Content-Type: text/plain; charset=us-ascii

On Thu, Apr 02, 1998 at 03:15:03PM -0800, William J. Earl wrote:

> At MIPS, with the Magnum 4000PC under RISC/os, and at SGI, with the
> Indy R4000PC (and later R4600 and R5000), I modified RISC/os and IRIX to
> control virtual aliasing, but only for those platforms without hardware
> VCE detection (in order to minimize time to market).  

VCE's don't look too difficult to tackle under Linux.

>     Note that taking a K0SEG address for a physical page which is also mapped
> to user space can easily cause a VCE, since there is a good chance that
> the K0SEG virtual index differs from the user space virtual index, unless
> you match physical page color to virtual page color when allocating pages.
> Note that you have to do that for any pages which must be accessible in
> the general exception handler, since you cannot handle a VCE in the
> exception handler.

The VCE bug is actually worse than I thought before.  I was in the assumption
that we'd handle all cases were VC might hit us because the MIPS ABI takes
care of by it's restrictions of the virtual addresses for mmaping.  Well,
I was wrong.  Writing via write(2) to a file that is also mmap(2)ed may
result in virtual coherency problems.

Another problem is that under Linux one cannot simply allocate a page of
a desired colour - which would of course be the prefered solution.  Luckily
a vce exceptionhandler will not run into the problem under Linux.

A small test program for the mmap/write problem attached.  If may be
necessary to start it several times in order to make it print the ``Big
trouble, man ...'' message.

  Ralf

--PXFtsOsTdHNUZQcU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mmap.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define TESTFILE "hurz"

static char zero[4096];
static char one[4096];

int main(int argc, char *argv[])
{
	int fd, res, i;
	char *addr;
	volatile char *p;

	memset(zero, 0, 4096);
	memset(one, 1, 4096);

	fd = open(TESTFILE, O_RDWR | O_CREAT, 664);
	unlink(TESTFILE);
	if(fd < 0) {
		perror("Opening testfile failed");
		exit(EXIT_FAILURE);
	}

	res =write(fd, one, 4096);
	if (res < 0) {
		perror("Write failed");
		exit(EXIT_FAILURE);
	}

	addr = mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (addr == MAP_FAILED) {
		perror("Mapping /dev/zero failed");
	}

	p = addr;
	for (i=0;i<4096;i++) {
		*(p++);
	}

	res = lseek(fd, SEEK_SET, 0);
	if (res < 0) {
		perror("Seek failed");
		exit(EXIT_FAILURE);
	}

	res =write(fd, zero, 4096);
	if (res < 0) {
		perror("Write failed");
		exit(EXIT_FAILURE);
	}

	p = addr;
	res = 0;
	for (i=0;i<4096;i++) {
		res |= *(p++);
	}

	if (res) {
		fprintf(stderr, "Big trouble, man ...\n");
	}

	exit(EXIT_SUCCESS);
}

--PXFtsOsTdHNUZQcU--
