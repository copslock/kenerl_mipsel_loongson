Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 May 2003 16:41:33 +0100 (BST)
Received: from rwcrmhc51.attbi.com ([IPv6:::ffff:204.127.198.38]:30372 "EHLO
	rwcrmhc51.attbi.com") by linux-mips.org with ESMTP
	id <S8225211AbTEFPlb>; Tue, 6 May 2003 16:41:31 +0100
Received: from lucon.org (12-234-88-5.client.attbi.com[12.234.88.5])
          by attbi.com (rwcrmhc51) with ESMTP
          id <2003050615412105100jgcgfe>; Tue, 6 May 2003 15:41:21 +0000
Received: by lucon.org (Postfix, from userid 1000)
	id A5A6F2C681; Tue,  6 May 2003 08:41:19 -0700 (PDT)
Date: Tue, 6 May 2003 08:41:19 -0700
From: "H. J. Lu" <hjl@lucon.org>
To: Andreas Jaeger <aj@suse.de>
Cc: binutils@sources.redhat.com, gcc@gcc.gnu.org,
	GNU C Library <libc-alpha@sources.redhat.com>,
	Kenneth Albanowski <kjahds@kjahds.com>,
	Mat Hostetter <mat@lcs.mit.edu>, Warner Losh <imp@village.org>,
	linux-mips@linux-mips.org, Ron Guilmette <rfg@monkeys.com>,
	Ralf Baechle <ralf@linux-mips.org>,
	Linas Vepstas <linas@linas.org>,
	Leonard Zubkoff <lnz@dandelion.com>,
	"Steven J. Hill" <sjhill@cotw.com>, linux-gcc@vger.kernel.org
Subject: PATCH: Don't use empy files in ld-elfvers
Message-ID: <20030506084119.A4370@lucon.org>
References: <20030505223301.A28436@lucon.org> <hod6iwy26e.fsf@byrd.suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="WhfpMioaduB5tiZL"
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <hod6iwy26e.fsf@byrd.suse.de>; from aj@suse.de on Tue, May 06, 2003 at 09:17:13AM +0200
Return-Path: <hjl@lucon.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2281
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl@lucon.org
Precedence: bulk
X-list: linux-mips


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 06, 2003 at 09:17:13AM +0200, Andreas Jaeger wrote:
> "H. J. Lu" <hjl@lucon.org> writes:
>=20
> > This is the beta release of binutils 2.14.90.0.1 for Linux, which is
> > based on binutils 2003 0505 in CVS on sourecs.redhat.com plus various
> > changes. It is purely for Linux.
> >
> > The Linux/mips support is added. You have to use
> >
> > # rpm --target=3D[mips|mipsel] -ta binutils-xx.xx.xx.xx.xx.tar.gz
> >
> > to build it. Or you can read mips/README in the source tree to apply
> > the mips patches and build it by hand.
> >
> > Please report any bugs related to binutils 2.14.90.0.1 to hjl@lucon.org.
>=20
> HJ,
>=20
> the package is broken, the testsuite fails since the following
> (empty!) files from the ld/testsuite are not part of the tarball:
>=20
>=20
> ./testsuite/ld-elfvers/vers25b.c
> ./testsuite/ld-elfvers/vers25b.dsym
> ./testsuite/ld-elfvers/vers25b.ver
> ./testsuite/ld-elfvers/vers26b.dsym
> ./testsuite/ld-elfvers/vers26b.ver
> ./testsuite/ld-elfvers/vers27b.dsym
> ./testsuite/ld-elfvers/vers27b.ver
> ./testsuite/ld-elfvers/vers27c.c
> ./testsuite/ld-elfvers/vers27c.dsym
> ./testsuite/ld-elfvers/vers27c.ver
>=20

It is not such a good idea to use empty files in CVS. I will check in
this patch. Please apply binutils-2.14.90.0.1-empty-test.patch to the
Linux binutils 2.14.90.0.1.


H.J.

--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="binutils-2.14.90.0.1-empty-test.patch"
Content-Transfer-Encoding: quoted-printable

2003-05-06  H.J. Lu <hjl@gnu.org>

	* ld-elfvers/vers.exp (objdump_versionstuff): Support comment
	in expected version file.

	* ld-elfvers/vers25b.c: Add a line of comment.
	* ld-elfvers/vers25b.dsym: Likwise.
	* ld-elfvers/vers25b.ver: Likwise.
	* ld-elfvers/vers26b.dsym: Likwise.
	* ld-elfvers/vers26b.ver: Likwise.
	* ld-elfvers/vers27b.dsym: Likwise.
	* ld-elfvers/vers27b.ver: Likwise.
	* ld-elfvers/vers27c.c: Likwise.
	* ld-elfvers/vers27c.dsym: Likwise.
	* ld-elfvers/vers27c.ver: Likwise.

--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers.exp.empty	2003-05-05 =
14:46:50.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers.exp	2003-05-06 08:32:=
18.000000000 -0700
@@ -457,7 +457,11 @@ proc objdump_versionstuff { objdump obje
=20
 	set f1 [open $tmpdir/objdump.out r]
 	set f2 [open $expectfile r]
-	gets $f2 l2
+	while { [gets $f2 l2] !=3D -1 } {
+	    if { ![regexp "^#.*$" $l2] } then {
+		break
+	    }
+	}=20
 	while { [gets $f1 l1] !=3D -1 } {
 	    if { [string match $l2 $l1] } then {
 		if { [gets $f2 l2] =3D=3D -1 } then {
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers25b.c.empty	2003-05-06=
 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers25b.c	2003-05-06 08:32=
:18.000000000 -0700
@@ -0,0 +1 @@
+/* Empty file  */
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers25b.dsym.empty	2003-05=
-06 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers25b.dsym	2003-05-06 08=
:32:18.000000000 -0700
@@ -0,0 +1 @@
+# Empty file.
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers25b.ver.empty	2003-05-=
06 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers25b.ver	2003-05-06 08:=
32:18.000000000 -0700
@@ -0,0 +1 @@
+# Empty file
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers26b.dsym.empty	2003-05=
-06 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers26b.dsym	2003-05-06 08=
:32:18.000000000 -0700
@@ -0,0 +1 @@
+# Empty file
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers26b.ver.empty	2003-05-=
06 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers26b.ver	2003-05-06 08:=
32:18.000000000 -0700
@@ -0,0 +1 @@
+# Empty file
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27b.dsym.empty	2003-05=
-06 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27b.dsym	2003-05-06 08=
:32:18.000000000 -0700
@@ -0,0 +1 @@
+# Empty file
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27b.ver.empty	2003-05-=
06 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27b.ver	2003-05-06 08:=
32:18.000000000 -0700
@@ -0,0 +1 @@
+# Empty file
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27c.c.empty	2003-05-06=
 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27c.c	2003-05-06 08:32=
:18.000000000 -0700
@@ -0,0 +1 @@
+/* Empty file  */
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27c.dsym.empty	2003-05=
-06 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27c.dsym	2003-05-06 08=
:32:18.000000000 -0700
@@ -0,0 +1 @@
+# Empty file
--- binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27c.ver.empty	2003-05-=
06 08:32:18.000000000 -0700
+++ binutils-2.14.90.0.1/ld/testsuite/ld-elfvers/vers27c.ver	2003-05-06 08:=
32:18.000000000 -0700
@@ -0,0 +1 @@
+# Empty file

--WhfpMioaduB5tiZL--
