Received:  by oss.sgi.com id <S305160AbQAZElw>;
	Tue, 25 Jan 2000 20:41:52 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:35935 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305158AbQAZElh>;
	Tue, 25 Jan 2000 20:41:37 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA02581; Tue, 25 Jan 2000 20:44:03 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA37682
	for linux-list;
	Tue, 25 Jan 2000 20:29:45 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id UAA00671
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 25 Jan 2000 20:29:42 -0800 (PST)
	mail_from (machida@sm.sony.co.jp)
Received: from ns4.sony.co.jp (ns4.Sony.CO.JP [202.238.80.4]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id UAA06116
	for <linux@cthulhu.engr.sgi.com>; Tue, 25 Jan 2000 20:29:37 -0800 (PST)
	mail_from (machida@sm.sony.co.jp)
Received: from mail1.sony.co.jp (gatekeeper7.Sony.CO.JP [202.238.80.21])
	by ns4.sony.co.jp (12/09/99) with ESMTP id NAA82582;
	Wed, 26 Jan 2000 13:28:24 +0900 (JST)
Received: from smail1.sm.sony.co.jp (smail1.sm.sony.co.jp [43.11.253.1])
	by mail1.sony.co.jp (3.7W990708a) with ESMTP id NAA26977;
	Wed, 26 Jan 2000 13:28:24 +0900 (JST)
Received: from imail.sm.sony.co.jp (imail.sm.sony.co.jp [43.27.209.5]) by smail1.sm.sony.co.jp (8.8.8/3.6W) with ESMTP id NAA11657; Wed, 26 Jan 2000 13:29:08 +0900 (JST)
Received: from mach0.sm.sony.co.jp (mach0.sm.sony.co.jp [43.27.210.135]) by imail.sm.sony.co.jp (8.8.8/3.7W) with ESMTP id NAA09216; Wed, 26 Jan 2000 13:27:52 +0900 (JST)
Received: from localhost by mach0.sm.sony.co.jp (8.8.8/FreeBSD) with ESMTP id NAA26392; Wed, 26 Jan 2000 13:27:53 +0900 (JST)
To:     gcc-bugs@gcc.gnu.org
Cc:     linux@cthulhu.engr.sgi.com, linux-gcc@vger.rutgers.edu
Subject: bugfix: incorrect va_arg() definition for 32bit MIPS
X-Mailer: Mew version 1.94.1 on Emacs 19.34 / Mule 2.3 (SUETSUMUHANA)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20000126132753S.machida@sm.sony.co.jp>
Date:   Wed, 26 Jan 2000 13:27:53 +0900
From:   Hiroyuki Machida <machida@sm.sony.co.jp>
X-Dispatcher: imput version 990905(IM130)
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing


Hi.
I have been building gcc 2.95.2 on 32bit MIPS/Linux box.
During this work, I found a inverted 'ifdef' on defining 
va_arg() macro in gcc/ginclude/va-mips.h.
That is, definition of va_arg for 32bit little endian and 32bit big
endian is inverted.

You can repeat this problem running a attached test program.
I guess gcc on IRIX 5.? or O32 ABI box has same problem.
Have you ever experienced same problem on 32bit MIPS box?

Sample fix is attached at the bottom.

VERSION:
	gcc 2.95.2 on MIPS/Linux
	gcc 2.7.2  on MIPS/Linux 
	egcs-1.0.2 on MIPS/Linux


REPEAT BY:

Compile and run this program. 
The program will print "OK", if va_arg() accept args correclty.

/*
 * 
 * stdarg.c  -- Simple stdarg test.
 *	Pass #of pairs and (type, value) pairs using stdarg.h.
 *	And check if passed values are correctly accepted.
 *
 */

#include<stdarg.h>

int foo(int nargs, ...)
{
	va_list ap;
	int i;
	int ng = 0;
	long long expected;
	long long passed;

	/* get # of args */
	va_start(ap, nargs);
	printf("  # of args:%d\n",nargs);

	for (i=1; i<= nargs ; i++) {
		char type;
		int d; long long ll; char c; char *s;

		/* calc. expceted value */
		expected=i; 
		if ( expected & 1 ) expected = -expected;

		/* get type of the arg */
		type = (char ) va_arg(ap, char);
		switch (type) {
		   case 'i': /* int */
			d = va_arg(ap, int);
			passed=d; 
			printf("%10s: expected:%3lld,\t passed:%3lld\n",
				"int", expected, passed);
			if ( passed != expected) ng ++;
			break;
		  case 'L':  /* long long */
			ll = va_arg(ap, long long);
			passed=ll;
			printf("%10s: expected:%3lld,\t passed:%3lld\n",
				"long long", expected, passed);
			if ( passed != expected) ng ++;
			break;
		  case 'c':  /* char */
			c = (char) va_arg(ap, char);
			passed=(long long) (c - '0');
			printf("%10s: expected:%3lld,\t passed:%3lld\n",
				"char", expected, passed);
			if ( passed != expected) ng ++;
			break;
		  case 's':  /* char * */
			s = va_arg(ap, char *);
			passed=(long long)atol(s);
			printf("%10s: expected:%3lld,\t passed:%3lld\n",
				"string", expected, passed);
			if ( passed != expected) ng ++;
			break;
		  default:  /* Unknown */
			printf("  unkown type:%4d: argptr:0x%8.8x\n",
				type,(void *)ap);
			ng ++;
			break;
		}
	}
	va_end(ap);
	return ng;
}

int main()
{
	int ng;

	printf("*\n");
	printf("* Simple stdarg test.\n");
	printf("*\n");

	/* Pass # of pairs and  (type, order<*>) pairs  */
	/* order<*> number must be minus value if order is odd */
	ng = foo(6,
		'i', -1,
		'c', '2',
		'L', (long long)-3,
		's', "4",
		'i', -5 ,
		'c', '6');

	if (ng) {
		printf("NG\n");
	}
	else {
		printf("OK\n");
	}
	return ng;
}






SAMPLE FIX:

gcc/ginclude/va-mips.h

retrieving revision 1.1.1.1
retrieving revision 1.2
diff -u -p -r1.1.1.1 -r1.2
--- va-mips.h	1999/05/19 13:14:31	1.1.1.1
+++ va-mips.h	1999/11/08 09:48:26	1.2
@@ -254,19 +254,19 @@ void va_end (__gnuc_va_list);		/* Define
 
 #ifdef __MIPSEB__
 /* For big-endian machines.  */
+#define va_arg(__AP, __type)						    \
+  ((__type *) (void *) (__AP = (char *) ((__alignof__(__type) > 4	    \
+				? ((__PTRDIFF_TYPE__)__AP + 8 - 1) & -8	    \
+				: ((__PTRDIFF_TYPE__)__AP + 4 - 1) & -4)    \
+					 + __va_rounded_size(__type))))[-1]
+#else
+/* For little-endian machines.  */
 #define va_arg(__AP, __type)					\
   ((__AP = (char *) ((__alignof__ (__type) > 4			\
 		      ? ((__PTRDIFF_TYPE__)__AP + 8 - 1) & -8	\
 		      : ((__PTRDIFF_TYPE__)__AP + 4 - 1) & -4)	\
 		     + __va_rounded_size (__type))),		\
    *(__type *) (void *) (__AP - __va_rounded_size (__type)))
-#else
-/* For little-endian machines.  */
-#define va_arg(__AP, __type)						    \
-  ((__type *) (void *) (__AP = (char *) ((__alignof__(__type) > 4	    \
-				? ((__PTRDIFF_TYPE__)__AP + 8 - 1) & -8	    \
-				: ((__PTRDIFF_TYPE__)__AP + 4 - 1) & -4)    \
-					 + __va_rounded_size(__type))))[-1]
 #endif
 #endif
 #endif /* ! defined (__mips_eabi)  */


---
Hiroyuki Machida		machida@sm.sony.co.jp
Creative Station		SCEI / Sony Corp.
