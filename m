Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 13:19:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7668 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009517AbcAVMTOeRVG4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 22 Jan 2016 13:19:14 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 12D2A41F8E95;
        Fri, 22 Jan 2016 12:19:09 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 22 Jan 2016 12:19:09 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 22 Jan 2016 12:19:09 +0000
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id E9800CB0DEA65;
        Fri, 22 Jan 2016 12:19:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 22 Jan 2016 12:19:08 +0000
Received: from localhost (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 22 Jan
 2016 12:19:08 +0000
Date:   Fri, 22 Jan 2016 12:19:08 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Manuel Lauss <manuel.lauss@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: c-r4k: Sync icache when it fills from dcache
Message-ID: <20160122121908.GG31243@jhogan-linux.le.imgtec.org>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
 <1453460306-8505-2-git-send-email-james.hogan@imgtec.com>
 <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="OgApRN/oydYDdnYz"
Content-Disposition: inline
In-Reply-To: <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 56f439c
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--OgApRN/oydYDdnYz
Content-Type: multipart/mixed; boundary="MiFvc8Vo6wRSORdP"
Content-Disposition: inline


--MiFvc8Vo6wRSORdP
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 22, 2016 at 01:06:14PM +0100, Manuel Lauss wrote:
> Hi James,
>=20
> On Fri, Jan 22, 2016 at 11:58 AM, James Hogan <james.hogan@imgtec.com> wr=
ote:
> > It is still necessary to handle icache coherency in flush_cache_range()
> > and copy_to_user_page() when the icache fills from the dcache, even
> > though the dcache does not need to be written back. However when this
> > handling was added in commit 2eaa7ec286db ("[MIPS] Handle I-cache
> > coherency in flush_cache_range()"), it did not do any icache flushing
> > when it fills from dcache.
> >
> > Therefore fix r4k_flush_cache_range() to run
> > local_r4k_flush_cache_range() without taking into account whether icache
> > fills from dcache, so that the icache coherency gets handled. Checks are
> > also added in local_r4k_flush_cache_range() so that the dcache blast
> > doesn't take place when icache fills from dcache.
> >
> > A test to mmap a page PROT_READ|PROT_WRITE, modify code in it, and
> > mprotect it to VM_READ|VM_EXEC (similar to case described in above
> > commit) can hit this case quite easily to verify the fix.
> >
> > A similar check was added in commit f8829caee311 ("[MIPS] Fix aliasing
> > bug in copy_to_user_page / copy_from_user_page"), so also fix
> > copy_to_user_page() similarly, to call flush_cache_page() without taking
> > into account whether icache fills from dcache, since flush_cache_page()
> > already takes that into account to avoid performing a dcache flush.
> >
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: Leonid Yegoshin <leonid.yegoshin@imgtec.com>
> > Cc: Manuel Lauss <manuel.lauss@gmail.com>
> > Cc: linux-mips@linux-mips.org
> > ---
> >  arch/mips/mm/c-r4k.c | 11 +++++++++--
> >  arch/mips/mm/init.c  |  2 +-
> >  2 files changed, 10 insertions(+), 3 deletions(-)
>=20
>=20
> I did some light testing on Alchemy and see no problems so far.
> If it matters:  Tested-by: Manuel Lauss <manuel.lauss@gmail.com>

Thanks Manuel.

FWIW, attached is the test program I mentioned, which hits the first
part of this patch (flush_cache_range) via mprotect(2) and checks if
icache seems to have been flushed (tested on mips64r6, but should be
portable).

Cheers
James

--MiFvc8Vo6wRSORdP
Content-Type: text/x-c; charset=utf-8
Content-Disposition: attachment; filename="mprotect.c"

/*
 * Copyright (C) 2016 Imagination Technologies Ltd.
 * Author: James Hogan <james.hogan@imgtec.com>
 *
 * Test that mprotect keeps icache in sync.
 * I.e.
 * 1) mprotect of non-PROT_EXEC mmap() should sync icache.
 * 2) later mprotect RW->RX should sync icache.
 * 3) later mprotect RWX->RWX should sync icache.
 *
 * Linux man pages do not state what mprotect(2) does with caches.
 *
 * IRIX man pages suggest that its mprotect(2) causes cache flushing to take
 * place to allow for execution.
 *
 * The MIPS behaviour was fixed in Linux kernel commit 2eaa7ec286db ("[MIPS]
 * Handle I-cache coherency in flush_cache_range()"), to accomodate the MIPS16
 * dynamic linker which would perform data relocations in a page also containing
 * code, allocated with mmap VM_READ|VM_WRITE, and then use mprotect(2) to make
 * it executable. Without the fix, stale icache lines could be used.
 */
#ifndef __mips__
#error This test only supports MIPS
#endif

#include <inttypes.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/cachectl.h>
#include <sys/mman.h>
#include <unistd.h>

#define REG_ZERO	 0
#define REG_V0		 2
#define REG_RA		31

#define OPC_S		26
#define RS_S		21
#define RT_S		16
#define IMM_S		 0
#define FUNC_S		 0

#define SPECIAL		(000u << OPC_S)
#define ADDIU		(011u << OPC_S)
#define JALR		(SPECIAL | (011U << FUNC_S))

#define MOV_V0(SIMM)	(ADDIU | (REG_V0 << RT_S) | ((uint16_t)(SIMM) << IMM_S))

void usage(char *arg0, FILE *f)
{
	fprintf(f, "Usage: %s <options>:\n"
		   " -h            : show this help text\n"
		   " --[no-]loop1  : run/skip RW/RX mprotect loop (=run)\n"
		   " --[no-]loop2  : run/skip RWX mprotect loop (=skip)\n"
		   " --loops <num> : set number of loop iterations (=%u)\n",
		   arg0, 0x10000);
}

int main(int argc, char **argv)
{
	const int pagesize = getpagesize();
	uint32_t *buf;
	int (*func)(void);
	unsigned int i;
	int ret;
	bool loop1 = true;
	bool loop2 = false;
	unsigned int max = 0xffff;

	for (i = 1; i < argc; ++i) {
		if (!strcmp(argv[i], "--loop1")) {
			loop1 = true;
		} else if (!strcmp(argv[i], "--no-loop1")) {
			loop1 = false;
		} else if (!strcmp(argv[i], "--loop2")) {
			loop2 = true;
		} else if (!strcmp(argv[i], "--no-loop2")) {
			loop2 = false;
		} else if (!strcmp(argv[i], "--loops")) {
			++i;
			if (i >= argc) {
				fprintf(stderr,
					"--loops expects an argument\n\n");
				goto bad_usage;
			}
			max = atoi(argv[i]) - 1;
			if (max > 0xffff) {
				fprintf(stderr,
					"--loops must be >= 1 and <= %u\n\n",
					0x10000);
				goto bad_usage;
			}
		} else if (!strcmp(argv[i], "-h")) {
			usage(argv[0], stdout);
			return EXIT_SUCCESS;
		} else {
bad_usage:
			usage(argv[0], stderr);
			return EXIT_FAILURE;
		}
	}

	/* Map a page where we can generate some code. */
	buf = mmap(NULL, pagesize, PROT_READ|PROT_WRITE,
		   MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
	if (buf == MAP_FAILED) {
		perror("mmap");
		return EXIT_FAILURE;
	}
	func = (void *)buf;


	/*
	 * Write a simple function returning a value:
	 * jr     ra
	 *  addiu v0, zero, -1
	 */
	buf[0] = JALR | (REG_RA << RS_S);
	buf[1] = MOV_V0(0xffff);
	/*
	 * Flush cache immediately, so we can fail more gracefully if mprotect
	 * doesn't work.
	 */
	ret = cacheflush(buf, sizeof(buf[0]) * 2, BCACHE);
	if (ret < 0) {
		perror("cacheflush");
		return EXIT_FAILURE;
	}

	/* Check mprotect flushes icache. */

	/* Make function return 0. */
	buf[1] = MOV_V0(0);
	/* Make the page executable. */
	ret = mprotect(buf, pagesize, PROT_READ|PROT_EXEC);
	if (ret < 0) {
		perror("initial mprotect\n");
		return EXIT_FAILURE;
	}
	/* Check the return value. */
	ret = func();
	if (ret != 0) {
		fprintf(stderr,
			"%s:%u: First mprotect(2) PROT_READ|PROT_EXEC didn't sync icache, ret=%x\n",
			__FILE__, __LINE__, ret);
		return EXIT_FAILURE;
	}

	printf("Initial mprotect SUCCESS\n");

	if (loop1) {
		/* Lets test mprotect(RW), modify, mprotect(RX) a bit more. */
		for (i = 0; i <= max; ++i) {
			/* Make the page writable, non-executable. */
			ret = mprotect(buf, pagesize, PROT_READ|PROT_WRITE);
			if (ret < 0) {
				perror("mprotect PROT_READ|PROT_WRITE\n");
				return EXIT_FAILURE;
			}
			/* Make the function return (int16_t)i. */
			buf[1] = MOV_V0(i);
			/* Make the page executable. */
			ret = mprotect(buf, pagesize, PROT_READ|PROT_EXEC);
			if (ret < 0) {
				perror("mprotect PROT_READ|PROT_EXEC\n");
				return EXIT_FAILURE;
			}

			/* Check the return value. */
			ret = func();
			if (ret != (int16_t)i) {
				fprintf(stderr,
					"%s:%u: Looped mprotect(2) PROT_READ|PROT_EXEC didn't sync icache, ret=%x, expected %x\n",
					__FILE__, __LINE__, ret, (int16_t)i);
				return EXIT_FAILURE;
			}
		}

		printf("Looped { mprotect RW, modify, mprotect RX, test } SUCCESS\n");
	}

	/*
	 * This loop is disabled by default, because Linux detects that the
	 * flags haven't changed and does nothing.
	 */
	if (loop2) {
		/* Make the page writable AND executable. */
		ret = mprotect(buf, pagesize, PROT_READ|PROT_WRITE|PROT_EXEC);
		if (ret < 0) {
			perror("initial mprotect PROT_READ|PROT_WRITE|PROT_EXEC\n");
			return EXIT_FAILURE;
		}

		/* Lets test modify while PROT_EXEC. */
		for (i = 0; i <= max; ++i) {
			/* Make the function return (int16_t)i. */
			buf[1] = MOV_V0(i);
			/* Remind kernel of executability. */
			ret = mprotect(buf, pagesize,
				       PROT_READ|PROT_WRITE|PROT_EXEC);
			if (ret < 0) {
				perror("mprotect PROT_READ|PROT_WRITE|PROT_EXEC\n");
				return EXIT_FAILURE;
			}

			/* Check the return value. */
			ret = func();
			if (ret != (int16_t)i) {
				/* This is expected under Linux, see above. */
				fprintf(stderr,
					"%s:%u: Looped mprotect(2) PROT_READ|PROT_WRITE|PROT_EXEC didn't sync icache, ret=%x, expected %x\n",
					__FILE__, __LINE__, ret, (int16_t)i);
				return EXIT_FAILURE;
			}
		}

		printf("Looped { modify, mprotect RWX, test } SUCCESS\n");
	}

	/* Clean up */
	ret = munmap(buf, pagesize);
	if (ret < 0) {
		perror("munmap\n");
		return EXIT_FAILURE;
	}

	return EXIT_SUCCESS;
}

--MiFvc8Vo6wRSORdP--

--OgApRN/oydYDdnYz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJWoh48AAoJEGwLaZPeOHZ6gfsQALUxTXN87BQhejynI+W38+gw
T7FrrCOPzulmRwjhrjP07LaC09iP/S0+R1yTZ81ELnw2EmHqjPZ9sxOlmu7y+ktu
fdGqHzSZVtdsih81M0hdj5mFCJ0teLcwRYCsvgU5gyk4zQAIjnmOEZsRaqME2KXu
MZ6xq3hINo5xreyPu5EprsGeE+Si19Ug5k3PNgs6Da975R1Zwsq+xLNF6NVsG/7H
fNh5AppIEjZbovejC1RIPrTCJj6SNOesdM82slyAIWN4GvQZpVNaTdwCvdpbKlSL
9Lbdz0VLQxkuPLs9Q7qyUHgluVR5TnJjuD32wJJHGf5ycrUDcgB/tByQ6usNgfk+
XM88Dm2BOF5IVRtJZE2v5EX+fQ7qFSHRnSyvovWGC+UqiE8rW7bxbpldmRrj/8YD
fJCh3st21Y2hVesEsA/EP5p7lXYBrq8jvgz2PW9iBK2bIL/ebBbK8YytS2gnXNj2
8ErzRKLXYjNMjIgrq/0U636YopxADXqInSHcwVMdusojCVFOMzH6x1QQV2iGPL2V
9fDtUD5QnFeSkyK8d6AWRkNVN7r4I6ATppSX6qqGLaz2yozR4znych3Kz/V/S3Kg
QRCDyfTrt0SRSxUbGhbPlqu8EpGG1SOfGKq69fI39DOsYPLM1PkXfNtw0qPEh5TD
+Xp3t2BPz4/NCUPepAtL
=Dep9
-----END PGP SIGNATURE-----

--OgApRN/oydYDdnYz--
