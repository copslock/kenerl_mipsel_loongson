Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g0SL35L03953
	for linux-mips-outgoing; Mon, 28 Jan 2002 13:03:05 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g0SL2tP03938
	for <linux-mips@oss.sgi.com>; Mon, 28 Jan 2002 13:02:56 -0800
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id g0SK0xB02947;
	Mon, 28 Jan 2002 12:00:59 -0800
Subject: Re: pgd_init() Patch
From: Pete Popov <ppopov@pacbell.net>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Phil Thompson <phil@river-bank.demon.co.uk>,
   Linux/MIPS Development
	 <linux-mips@oss.sgi.com>
In-Reply-To: <Pine.GSO.4.21.0201282052240.2836-100000@vervain.sonytel.be>
References: <Pine.GSO.4.21.0201282052240.2836-100000@vervain.sonytel.be>
Content-Type: multipart/mixed; boundary="=-YecztOMllCdru85KXkmr"
X-Mailer: Evolution/1.0.1 
Date: 28 Jan 2002 12:03:19 -0800
Message-Id: <1012248199.19952.111.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-YecztOMllCdru85KXkmr
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Mon, 2002-01-28 at 11:53, Geert Uytterhoeven wrote:
> On Mon, 28 Jan 2002, Phil Thompson wrote:
> > - USER_PTRS_PER_PGD is defined as TASK_SIZE/PGDIR_SIZE. However,
> > because, TASK_SIZE is actually defined as one less that the maximum task
>            ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> > size there is a rounding error that means that USER_PTRS_PER_PGD works
>   ^^^^
> > out at 511 rather than 512. This means that entries 511 and 1023 of
> > swapper_pg_dir don't get initialised.
> > 
> > The corresponding mips64 code has only the first call to pgd_init() and
> > each implementation of pgd_init() initialises PTRS_PER_PGD entries,
> > where PTRS_PER_PGD is simple defined as 1024.
> > 
> > The attached patch applies the mips64 approach to the mips code.
> > 
> > Should USER_PTRS_PER_PGD be defined as (TASK_SIZE/PGDIR_SIZE) + 1?
> 
> You mean ((TASK_SIZE)+1)/PGDIR_SIZE?

Or how about:

#define USER_PTRS_PER_PGD      ((TASK_SIZE-1)/PGDIR_SIZE + 1)


The above patch fixes a rather serious memory leak.  When a parent
process forks a large number of children and then it exits before the
children exit, we lose one page per child. I was able to narrow down the
problem and reproduce it with the attached program.  Ralf has the fix,
but was examining related issues before applying the patch.

Pete


--=-YecztOMllCdru85KXkmr
Content-Disposition: attachment; filename=mleak.c
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-c; charset=ISO-8859-1

=20
#include <signal.h>

#define NUM_TSK 200
int main()
{
	int i, lastp;
	int pids[NUM_TSK];

	printf("mypid %d\n", getpid());
	for (i=3D0; i<NUM_TSK; i++) {
		switch (pids[i] =3D fork()) {
			case -1:
				printf("fork failed, lastp %d\n", lastp);
				goto killall;
			case 0:
				sleep(4);
				return 0;
				break;
			default:
				lastp =3D i;
		}
	}

killall:
	return 0;
}

--=-YecztOMllCdru85KXkmr--
