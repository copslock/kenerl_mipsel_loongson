Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fAFDd6J00785
	for linux-mips-outgoing; Thu, 15 Nov 2001 05:39:06 -0800
Received: from mail.chimerical.com.au (CPE-144-132-219-161.nsw.bigpond.net.au [144.132.219.161])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fAFDcu000782
	for <linux-mips@oss.sgi.com>; Thu, 15 Nov 2001 05:38:57 -0800
content-class: urn:content-classes:message
Subject: Inclusion of rrm.o in export-objs
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Date: Fri, 16 Nov 2001 00:38:46 +1100
Message-ID: <4DF7FE7DA7E47442B859983ABCFBBF627971@chimsvr1.chimerical.com.au>
X-MimeOLE: Produced By Microsoft Exchange V6.0.4712.0
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Inclusion of rrm.o in export-objs
Thread-Index: AcFt2tMZ4AsjtqC4SJuT59472mrXSg==
From: "Ivan Hamilton" <ivan@chimerical.com.au>
To: <linux-mips@oss.sgi.com>
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id fAFDcw000783
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I'm a little new, so let me know if this is out of place.

After grabbing the latest source via CVS, I ran into compilation
problems.
A little (read "a lot of") searching, and I found I was not alone with
this problem.
This fix, worked for me. But I'm not sure why no one else had run into
it.

My Makefile knowledge is extremely limited to say the least. But are
there possible side-effects of this particular fix? And how does a fix
like this, find it's way back into the source tree?

Any pointers, or other information welcome.


==ORIGINAL MESSAGE START==

*	Newsgroups: linux.debian.ports.mips 
*	From: Petter Reinholdtsen <pere@hungry.com
<mailto:pere@hungry.com>> 
*	Subject: Compile problem with latest mips kernel CVS 
*	Date: Wed, 07 Nov 2001 09:40:07 +0100 
*	Organization: linux.*_mail_to_news_unidirectional_gateway 
*	Approved: robomod@news.nic.it (1.20) 

Hello

I do not have post access to linux-mips@oss.sgi.com, so I try to send
it here instead.

I tested to compile the kernel from the mips kernel CVS last night,
and it stopped with the following error.  The error line is
"EXPORT_SYMBOL(<symbol>');".  The object rrm.o must be added to
export-objs.  Patch below.

make[4]: Entering directory `/usr/src/linux-cvs/drivers/sgi/char'

gcc -I /usr/src/linux-cvs/include/asm/gcc -D__KERNEL__
-I/usr/src/linux-cvs/include -Wall -Wstrict-prototypes -Wno-trigraphs
-O2 -fomit-frame-pointer -fno-strict-aliasing -fno-common -G 0
-mno-abicalls -fno-pic -mcpu=r4600 -mips2 -Wa,--trap -pipe -DMODULE
-mlong-calls   -c -o rrm.o rrm.c
Assembler messages:
Warning: The -mcpu option is deprecated.  Please use -march and -mtune
instead.
Warning: The -march option is incompatible to -mipsN and therefore
ignored.
rrm.c:74: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
rrm.c:74: warning: type defaults to `int' in declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
rrm.c:74: warning: data definition has no type or storage class
rrm.c:75: parse error before
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
rrm.c:75: warning: type defaults to `int' in declaration of
`this_object_must_be_defined_as_export_objs_in_the_Makefile'
rrm.c:75: warning: data definition has no type or storage class
make[4]: *** [rrm.o] Error 1
make[4]: Leaving directory `/usr/src/linux-cvs/drivers/sgi/char'

 - Add rrm.o to export-objs, and sort the list of objects.

Index: Makefile
===================================================================
RCS file: /cvs/linux/drivers/sgi/char/Makefile,v
retrieving revision 1.13
diff -u -r1.13 Makefile
--- Makefile    2001/03/11 03:35:59     1.13
+++ Makefile    2001/11/07 08:27:35
@@ -9,7 +9,7 @@

 O_TARGET := sgichar.o

-export-objs    := newport.o shmiq.o sgicons.o usema.o
+export-objs    := newport.o rrm.o sgicons.o shmiq.o usema.o
 obj-y          := newport.o shmiq.o sgicons.o usema.o streamable.o

 obj-$(CONFIG_SGI_SERIAL)       += sgiserial.o


-- 
To UNSUBSCRIBE, email to debian-mips-request@lists.debian.org
with a subject of "unsubscribe". Trouble? Contact
listmaster@lists.debian.org

==ORIGINAL MESSAGE END==
