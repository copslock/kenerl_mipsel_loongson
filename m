Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Jan 2007 13:09:31 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:7592 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20037878AbXAaNJ3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 31 Jan 2007 13:09:29 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l0VD9RsI030000;
	Wed, 31 Jan 2007 13:09:27 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l0VD9Q1b029999;
	Wed, 31 Jan 2007 13:09:26 GMT
Date:	Wed, 31 Jan 2007 13:09:26 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	linux-mips@linux-mips.org
Cc:	Sam Cannell <sam@catalyst.net.nz>
Subject: Kernel issues on R4000/R4000 SC and MC
Message-ID: <20070131130926.GA29562@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

Since the introduction of rmap into the kernel memory managment has been
broken for the SC and MC versions of R4000 and R4400 versions.

Interestingly enough this was only ever reported once in May 2006 and at
that time the report just didn't make sense, so it ended up being ignored,
see http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=1146433653.18721.10.camel%40pkunk.wgtn.cat-it.co.nz

Anyway, the issue boiled up again last week and was supposedly fixed for
linux-2.6.17-rc7 which I've just merged.   I'd like to ask somebody with
one of the affected CPUs to test this.  Below Nick Piggin's test program.

Thanks,

  Ralf

#define _GNU_SOURCE
#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>
#include <assert.h>

int main(void)
{
	char *mem, *mem2, *frag;
	size_t length = getpagesize();
	unsigned int i;

	mem = mmap(NULL, length, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
	if (mem == MAP_FAILED)
		perror("mmap"), exit(1);
	/* fault in a zero page */
	for (i = 0; i < length; i++)
		assert(mem[i] == 0);

	/* create an obstacle */
	frag = mmap(NULL, length, PROT_READ, MAP_ANONYMOUS|MAP_PRIVATE, -1, 0);
	if (frag == MAP_FAILED)
		perror("mmap"), exit(1);
	for (i = 0; i < length; i++)
		assert(frag[i] == 0);
	
	mem2 = mremap(mem, length, length*2, MREMAP_MAYMOVE);
	if (mem2 == MAP_FAILED)
		perror("mremap"), exit(1);
	
	if (mem == mem2)
		printf("Did not move old mappings!\n");
	else {
		unsigned int order = 3;
		unsigned long size = length << order;
		unsigned long mask = (size - 1) & ~(length-1);

		printf("Moved ZERO_PAGE vaddr from %p to %p\n", mem, mem2);
		if (((unsigned long)mem&mask) == ((unsigned long)mem2&mask))
			printf("This will not change physical ZERO_PAGEs\n");
		else
			printf("This will change physical ZERO_PAGEs\n");
	}

	if (munmap(frag, length) == -1)
		perror("munmap"), exit(1);

	if (munmap(mem2, length*2) == -1)
		perror("munmap"), exit(1);

	exit(0);
}
