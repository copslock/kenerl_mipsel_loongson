Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id FAA16512
	for <pstadt@stud.fh-heilbronn.de>; Tue, 13 Jul 1999 05:16:01 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA15530; Mon, 12 Jul 1999 20:13:30 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA20170
	for linux-list;
	Mon, 12 Jul 1999 20:10:28 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA56234
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 12 Jul 1999 20:10:26 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from mail.cobaltnet.com (firewall.cobaltmicro.com [209.133.34.37] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA02538
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jul 1999 20:10:25 -0700 (PDT)
	mail_from (thockin@cobaltnet.com)
Received: from cobaltnet.com (freakshow.cobaltnet.com [10.9.24.15])
	by mail.cobaltnet.com (8.9.3/8.9.3) with ESMTP id UAA10581
	for <linux@cthulhu.engr.sgi.com>; Mon, 12 Jul 1999 20:08:02 -0700
Message-ID: <378AADF5.96152E0B@cobaltnet.com>
Date: Mon, 12 Jul 1999 20:09:41 -0700
From: Tim Hockin <thockin@cobaltnet.com>
Organization: Cobalt Networks
X-Mailer: Mozilla 4.6 [en] (X11; I; Linux 2.2.9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux@cthulhu.engr.sgi.com
Subject: Float / Double issues
Content-Type: multipart/mixed;
 boundary="------------8A90B65AE71755DDB64EF4A6"
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

This is a multi-part message in MIME format.
--------------8A90B65AE71755DDB64EF4A6
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hey gang - I have what seems to be two seperate issues on Mips/Linux
(cobalt boxes).

1) Programs using doubles with pthreads get corrupted data in the
doubles.
2) Floats and va_arg crash with an FPE

below are two snippets that show these, at least on our boxes.  If
someone could confirm or deny their existence on any other platform?


Tim




--------------8A90B65AE71755DDB64EF4A6
Content-Type: text/plain; charset=us-ascii;
 name="double.c"
Content-Disposition: inline;
 filename="double.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <pthread.h>
#include <stdarg.h>

void doit(int, double, unsigned int);
void vait(unsigned int, ...);
void *ptfn(void *);
void doit2(int, int);
void vait2(int, ...);
void *ptfn2(void *);

int main() 
{
	pthread_t pt1;
	double d1 = 1.234; 

	printf("Without threads: \n");
	ptfn((void *)&d1);
	printf("\n");
	fflush(stdout);

	printf("With threads: \n");
	pthread_create(&pt1, NULL, ptfn, &d1);
	printf("\n");
	fflush(stdout);

	pthread_exit(0);
	return 0;
}

void *ptfn(void *x)
{
	char ar[16];
	unsigned int decimals = 5;
	double d = *(double *)x;

	doit(1, d, decimals);
	vait(decimals, d);
}

void doit(int x, double d, unsigned int ui)
{
	char buff[331];

	sprintf(buff,"double: %.*f",ui,d);
	printf("%s\n", buff);
}

void vait(unsigned int ui, ...)
{
	double d=-10.0;
	va_list va;

	va_start(va, ui);

	printf("double before va_arg: %f\n", d);
	d = va_arg(va, double);
	printf("double after va_arg: %f\n", d);

	va_end(va);

	doit(1, d, ui);
}

--------------8A90B65AE71755DDB64EF4A6
Content-Type: text/plain; charset=us-ascii;
 name="float.c"
Content-Disposition: inline;
 filename="float.c"
Content-Transfer-Encoding: 7bit

#include <stdio.h>
#include <stdarg.h>

void doit(int, float, unsigned int);
void vait(unsigned int, ...);
void *ptfn(void *);

int main() 
{
	float d1 = 1.234; 

	printf("Without threads: \n");
	ptfn((void *)&d1);
	printf("\n");
	fflush(stdout);

	return 0;
}

void *ptfn(void *x)
{
	char ar[16];
	unsigned int decimals = 5;
	float d = *(float *)x;

	doit(1, d, decimals);
	vait(decimals, d);
}

void doit(int x, float d, unsigned int ui)
{
	char buff[331];

	sprintf(buff,"float: %.*f",ui,d);
	printf("%s\n", buff);
}

void vait(unsigned int ui, ...)
{
	float d=-10.0;
	va_list va;

	va_start(va, ui);

	printf("float before va_arg: %f\n", d);
	d = va_arg(va, float);
	printf("float after va_arg: %f\n", d);

	va_end(va);

	doit(1, d, ui);
}

--------------8A90B65AE71755DDB64EF4A6--
