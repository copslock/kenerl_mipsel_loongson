Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3I6cP8d020800
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 17 Apr 2002 23:38:26 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3I6cPAp020799
	for linux-mips-outgoing; Wed, 17 Apr 2002 23:38:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from mms3.broadcom.com (mms3.broadcom.com [63.70.210.38])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3I6cG8d020790
	for <linux-mips@oss.sgi.com>; Wed, 17 Apr 2002 23:38:16 -0700
Received: from 63.70.210.1 by mms3.broadcom.com with ESMTP (Broadcom
 MMS-3 SMTP Relay (MMS v4.7)); Wed, 17 Apr 2002 23:39:13 -0700
X-Server-Uuid: 1e1caf3a-b686-11d4-a6a3-00508bfc9ae5
Received: from localhost.localdomain (dt-sv1-033.sj.broadcom.com
 [10.19.78.25]) by mon-irva-11.broadcom.com (8.9.1/8.9.1) with ESMTP id
 XAA29024; Wed, 17 Apr 2002 23:39:16 -0700 (PDT)
Subject: Re: DBE table ordering
From: "Mark Huang" <mhuang@broadcom.com>
To: "Keith Owens" <kaos@ocs.com.au>
cc: "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>
In-Reply-To: <30922.1019102135@ocs3.intra.ocs.com.au>
References: <30922.1019102135@ocs3.intra.ocs.com.au>
X-Mailer: Evolution/1.0.2-5mdk
Date: 17 Apr 2002 23:39:16 -0700
Message-ID: <1019111956.2095.66.camel@mathom>
MIME-Version: 1.0
X-WSS-ID: 10A0B59B292501-01-01
Content-Type: multipart/mixed; 
 boundary="=-gT+ogKjHt2stTVo7XKsc"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-gT+ogKjHt2stTVo7XKsc
Content-Type: text/plain; 
 charset=us-ascii
Content-Transfer-Encoding: 7bit

>From the objdump output, it looks like the exception table is in order
at link time, but the DBE table is definitely out of order. What seems
to be throwing it off is the dummy call to get_dbe() in traps.c. After
sprinkling a few more calls to get_dbe() around the kernel and seeing
what happens during link, it looks like any call to get_dbe() inside an
__init section (or probably any explicitly located section) will throw
off the ordering of the table. 

I'd say just change the binary search to a linear one, or reorder the
table at __init time if O(log n) is that important. If there were 600
entries in the table, sure, but I don't really see the benefit of the
additional code to deal with only a handful, as in most cases.

> The kernel relies on several tables being correctly ordered by the
> linker, including the initialization vectors, so it is a fair bet that
> the linker is correctly appended these tables as the kernel is built.
> What is more likely is that one of the exception table entries was
> created out of order.  Please send the following output to me, not the
> list.
> 
> objdump -h vmlinux
> objdump -s -j __ex_table vmlinux
> nm -a vmlinux
> 


--=-gT+ogKjHt2stTVo7XKsc
Content-Disposition: attachment; 
 filename=traps.c.diff
Content-Transfer-Encoding: quoted-printable
Content-Type: text/x-diff; 
 charset=iso-8859-1

Index: arch/mips/kernel/traps.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
RCS file: /cvs/linux/arch/mips/kernel/traps.c,v
retrieving revision 1.107
diff -u -r1.107 traps.c
--- arch/mips/kernel/traps.c	2002/02/26 23:29:05	1.107
+++ arch/mips/kernel/traps.c	2002/04/18 06:36:06
@@ -360,17 +360,12 @@
 		 unsigned long value)
 {
 	const struct exception_table_entry *mid;
-	long diff;
=20
-	while (first < last) {
-		mid =3D (last - first) / 2 + first;
-		diff =3D mid->insn - value;
-		if (diff < 0)
-			first =3D mid + 1;
-		else
-			last =3D mid;
+	for (mid =3D first; mid <=3D last; mid++) {
+		if (mid->insn =3D=3D value)
+			return mid->nextinsn;
 	}
-	return (first =3D=3D last && first->insn =3D=3D value) ? first->nextinsn =
: 0;
+	return 0;
 }
=20
 extern spinlock_t modlist_lock;

--=-gT+ogKjHt2stTVo7XKsc--
