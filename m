Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3RLjqwJ028787
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 27 Apr 2002 14:45:52 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3RLjq5R028786
	for linux-mips-outgoing; Sat, 27 Apr 2002 14:45:52 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3RLjUwJ028770;
	Sat, 27 Apr 2002 14:45:31 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0E23283B; Sat, 27 Apr 2002 23:46:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 5FCB537116; Sat, 27 Apr 2002 23:45:05 +0200 (CEST)
Date: Sat, 27 Apr 2002 23:45:05 +0200
From: Florian Lohoff <flo@rfc822.org>
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com, agx@sigxcpu.org
Subject: XSHM/shared-pixmap fix  Was: Linux Shared Memory Issue
Message-ID: <20020427214505.GA23046@paradigm.rfc822.org>
References: <NDBBKEAAOJECIDBJKLIHOEDDCDAA.turcotte@broadcom.com> <3CC72BA3.90600@mvista.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZoaI/ZTpAVc4A5k6"
Content-Disposition: inline
In-Reply-To: <3CC72BA3.90600@mvista.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--ZoaI/ZTpAVc4A5k6
Content-Type: multipart/mixed; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ralf, *,

On Wed, Apr 24, 2002 at 03:03:15PM -0700, Jun Sun wrote:
> Looks like the infamous cache aliasing problem.  Steve Longerbeam had a=
=20
> patch which may help.  Please try it and let me know the results.

> Maurice Turcotte wrote:
> >I am having a problem with Linux Kernel 2.4.5 on a mips.
> >
> >I have two processes using share memory for IPC. This same
> >code works fine with Kernel 2.4.7 on a x86. The problem is=20
> >that the second process reads old data out of the shared
> >memory.
> >
> >The executive summary->
> >
> >Process #1 writes "A" to shared memory at 0x2aac7210
> >Process #2 reads 0 from shared memory at address 0x2aaca210
> >Process #1 writes "B" to shared memory at 0x2aac7210
> >Process #2 read "A" from shared memory at address 0x2aaca210
> >Process #1 writes "C" to shared memory at 0x2aac7210
> >Process #2 read "B" from shared memory at address 0x2aaca210
> >

I today tried the patch in conjunction with XFree86 and XSHM on
an Indy R5000/150. Usually all gtk shared-pixmaps get destroyed
and written lines in it. With this patch all these garbage disappears.
As long as there a no serious issues against this patch i would
vote for inclused. It applies against todays cvs with only little
offsets and gave me no problems. It definitly solves some serious
issues with shm.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="cache-alias.patch"
Content-Transfer-Encoding: quoted-printable

diff -Nuar -X /home/stevel/dontdiff linux-2.4.17.orig/arch/mips/kernel/sysc=
all.c linux-2.4.17/arch/mips/kernel/syscall.c
--- linux-2.4.17.orig/arch/mips/kernel/syscall.c	Sun Sep 16 16:29:10 2001
+++ linux-2.4.17/arch/mips/kernel/syscall.c	Thu Jan 24 15:02:18 2002
@@ -24,6 +24,7 @@
 #include <linux/slab.h>
 #include <linux/utsname.h>
 #include <linux/unistd.h>
+#include <linux/shm.h>
 #include <asm/branch.h>
 #include <asm/offset.h>
 #include <asm/ptrace.h>
@@ -53,6 +54,50 @@
 out:
 	return res;
 }
+
+/*
+ * To avoid cache aliases, we map the shard page with same color.
+ */
+#define COLOUR_ALIGN(addr)    (((addr)+SHMLBA-1)&~(SHMLBA-1))
+
+unsigned long arch_get_unmapped_area(struct file *filp, unsigned long addr,
+				     unsigned long len, unsigned long pgoff,
+				     unsigned long flags)
+{
+	struct vm_area_struct *vma;
+
+	if (flags & MAP_FIXED) {
+		/*
+		 * We do not accept a shared mapping if it would violate
+		 * cache aliasing constraints.
+		 */
+		if ((flags & MAP_SHARED) && (addr & (SHMLBA - 1)))
+			return -EINVAL;
+		return addr;
+	}
+
+	if (len > TASK_SIZE)
+		return -ENOMEM;
+	if (!addr)
+		addr =3D TASK_UNMAPPED_BASE;
+
+	if (flags & MAP_SHARED)
+		addr =3D COLOUR_ALIGN(addr);
+	else
+		addr =3D PAGE_ALIGN(addr);
+
+	for (vma =3D find_vma(current->mm, addr); ; vma =3D vma->vm_next) {
+		/* At this point:  (!vma || addr < vma->vm_end). */
+		if (TASK_SIZE - len < addr)
+			return -ENOMEM;
+		if (!vma || addr + len <=3D vma->vm_start)
+			return addr;
+		addr =3D vma->vm_end;
+		if (flags & MAP_SHARED)
+			addr =3D COLOUR_ALIGN(addr);
+	}
+}
+
=20
 /* common code for old and new mmaps */
 static inline long
diff -Nuar -X /home/stevel/dontdiff linux-2.4.17.orig/include/asm-mips/pgta=
ble.h linux-2.4.17/include/asm-mips/pgtable.h
--- linux-2.4.17.orig/include/asm-mips/pgtable.h	Thu Jan 24 14:35:06 2002
+++ linux-2.4.17/include/asm-mips/pgtable.h	Thu Jan 24 14:56:52 2002
@@ -64,6 +64,9 @@
 #define flush_icache_all()		do { } while(0)
 #endif
=20
+/* We provide our own get_unmapped_area to avoid cache aliasing */
+#define HAVE_ARCH_UNMAPPED_AREA
+
 /*
  * - add_wired_entry() add a fixed TLB entry, and move wired register
  */

--jI8keyz6grp/JLjh--

--ZoaI/ZTpAVc4A5k6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8yxvhUaz2rXW+gJcRAq/hAJsHLbUHoUcxT/lOB2M7YHsyFqSXQgCgyj4K
omj5qc6Ax6IwdmgtD9ibH/4=
=5COE
-----END PGP SIGNATURE-----

--ZoaI/ZTpAVc4A5k6--
