Received:  by oss.sgi.com id <S305163AbQD2WIa>;
	Sat, 29 Apr 2000 15:08:30 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:19014 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305252AbQD2WIU>;
	Sat, 29 Apr 2000 15:08:20 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA12159; Sat, 29 Apr 2000 15:03:33 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id PAA51277; Sat, 29 Apr 2000 15:06:34 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA55758
	for linux-list;
	Sat, 29 Apr 2000 14:57:44 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA49353
	for <linux@engr.sgi.com>;
	Sat, 29 Apr 2000 14:57:42 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA08115
	for <linux@engr.sgi.com>; Sat, 29 Apr 2000 14:57:40 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-23.uni-koblenz.de (cacc-23.uni-koblenz.de [141.26.131.23])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id XAA10024;
	Sat, 29 Apr 2000 23:57:34 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1406465AbQD2FSI>;
	Sat, 29 Apr 2000 07:18:08 +0200
Date:   Sat, 29 Apr 2000 07:18:07 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Florian Lohoff <flo@rfc822.org>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: VC exceptions
Message-ID: <20000429071807.A491@uni-koblenz.de>
References: <20000427165803.H272@paradigm.rfc822.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0F1p//8PRICkK4MW"
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000427165803.H272@paradigm.rfc822.org>; from flo@rfc822.org on Thu, Apr 27, 2000 at 04:58:03PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii

On Thu, Apr 27, 2000 at 04:58:03PM +0200, Florian Lohoff wrote:

> i had a conversation with Harald concerning a "strong" time drift
> on my R4000 Decstation. He than was astonished on the large
> number of VCE.

> On a medium loaded machine i see 40-50 VCEDs per second.

VCE isn't related to timekeeping and only may delay interrupts minimally;
they're very lightweight.  In fact keeping the VCE statistics makes a
significant part of the overhead.  So while the number of VCEs may look
high the total price is not too bad.

> As a resume - The exception is taken when the index of the 1st and
> the 2nd level cache are not identical - Right ?
> So - why is there a mismatch ? Might it be due to some invalidation
> of the 1st (and not the 2nd) level cache ?
> 
> As the exception is taken quiet often and the "Mips Risc Architecture" states
> "Software can avoid the cost of this trap by using constistent virtual
> primary cache indexes to access the same physical data".

Attached a small test program that generates a large number of vced exceptions.
It's causing aliases with the page cache and these are not covered by my
patch.

> Currently i dont think whats the exact cause of this exception and
> a probably optimization which brings this down.

The easiest part of the solution is choosing apropriate addresses for all
memory mappings without forced addresses, that is mmap(2) and mmap2(2)
without MAP_FIXED.  A patch which fixes this part of the problem is attached.

This patch does not fix other types of aliases like mmap(2) and mmap2(2)
with MAP_FIXED or aliases between multiple mappings out of the page cache.

Users of R2000 / R3000 / R7000 / R10000 CPUs can ignore this whole thread,
those CPUs don't have such incredibly f*cked caches.

  Ralf

--0F1p//8PRICkK4MW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="vce-gen.c"

#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <string.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>

#define TESTFILE "hurz"

int main(int argc, char *argv[])
{
	char template[] = "/tmp/mmap-XXXXXX";
	int fd, res, i;
	char *addr1, *addr2;

	fd = mkstemp(template);
	if (fd < 0) {
		perror("Opening testfile failed");
		exit(EXIT_FAILURE);
	}

	unlink(template);

	res = write(fd, "x", 1);
	if (res < 0) {
		perror("Write failed");
		exit(EXIT_FAILURE);
	}

	addr1 = mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
	if (addr1 == MAP_FAILED) {
		perror("Mapping file failed");
	}

	addr2 = mmap(addr1 + 4096, 4096, PROT_READ|PROT_WRITE,
	             MAP_SHARED | MAP_FIXED, fd, 0);
	if (addr2 == MAP_FAILED) {
		perror("Mapping file at alias address failed");
	}

	for (i = 100000000; i; i--) {
		* (volatile char *) addr1 = 1;
		* (volatile char *) addr2 = 2;
	}

	exit(EXIT_SUCCESS);
}

--0F1p//8PRICkK4MW--
