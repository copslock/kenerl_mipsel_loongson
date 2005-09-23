Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Sep 2005 01:30:13 +0100 (BST)
Received: from NAT.office.mind.be ([62.166.230.82]:50836 "EHLO
	NAT.office.mind.be") by ftp.linux-mips.org with ESMTP
	id S8133375AbVIWA34 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 23 Sep 2005 01:29:56 +0100
Received: (qmail 3797 invoked from network); 23 Sep 2005 00:29:54 -0000
Received: from localhost (HELO codecarver) ([127.0.0.1])
          (envelope-sender <p2@debian.org>)
          by localhost (qmail-ldap-1.03) with SMTP
          for <linux-mips@linux-mips.org>; 23 Sep 2005 00:29:54 -0000
Received: from p2 by codecarver with local (Exim 3.36 #1 (Debian))
	id 1EIbMP-0006AM-00
	for <linux-mips@linux-mips.org>; Fri, 23 Sep 2005 02:24:17 +0200
Date:	Fri, 23 Sep 2005 02:24:17 +0200
To:	linux-mips@linux-mips.org
Subject: patch for 2.6.14-rc1 for sb1
Message-ID: <20050923002416.GB16161@codecarver>
Mail-Followup-To: peter.de.schrijver@mind.be, linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="tNQTSEo8WG/FKZ8E"
Content-Disposition: inline
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag:	Get yourself a real email client. http://www.mutt.org/
X-mate:	Mate, man gewoehnt sich an alles
User-Agent: Mutt/1.5.6+20040907i
From:	Peter 'p2' De Schrijver <p2@debian.org>
Return-Path: <p2@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9032
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips


--tNQTSEo8WG/FKZ8E
Content-Type: multipart/mixed; boundary="NKoe5XOeduwbEQHU"
Content-Disposition: inline


--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Attached is a patch which makes 2.6.14-rc1 work on the sb1 core. It's
nothing more then a rehash of some patches posted here earlier to make
recent 2.6 kernels work on sb1.=3D20

Thanks,

Peter (p2).

--=20
goa is a state of mind

--NKoe5XOeduwbEQHU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-sb1
Content-Transfer-Encoding: quoted-printable

diff -urN -x asm -x scripts -x config linux/arch/mips/kernel/cpu-probe.c li=
nux-my/arch/mips/kernel/cpu-probe.c
--- linux/arch/mips/kernel/cpu-probe.c	2005-08-16 19:50:43.000000000 +0200
+++ linux-my/arch/mips/kernel/cpu-probe.c	2005-09-22 13:09:29.000000000 +02=
00
@@ -612,6 +612,8 @@
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_SB1:
 		c->cputype =3D CPU_SB1;
+		c->options &=3D ~MIPS_CPU_4KTLB;
+		c->options |=3D MIPS_CPU_TLB;
 #ifdef CONFIG_SB1_PASS_1_WORKAROUNDS
 		/* FPU in pass1 is known to have issues. */
 		c->options &=3D ~(MIPS_CPU_FPU | MIPS_CPU_32FPR);
diff -urN -x asm -x scripts -x config linux/arch/mips/mm/cache.c linux-my/a=
rch/mips/mm/cache.c
--- linux/arch/mips/mm/cache.c	2005-07-06 14:08:14.000000000 +0200
+++ linux-my/arch/mips/mm/cache.c	2005-09-22 13:28:21.000000000 +0200
@@ -122,6 +122,8 @@
     defined(CONFIG_CPU_MIPS64_R1) || defined(CONFIG_CPU_TX49XX) || \
     defined(CONFIG_CPU_RM7000) || defined(CONFIG_CPU_RM9000)
 		ld_mmu_r4xx0();
+#else
+		panic("Unknown CPU with r4k TLB");
 #endif
 	} else switch (current_cpu_data.cputype) {
 #ifdef CONFIG_CPU_R3000
diff -urN -x asm -x scripts -x config linux/arch/mips/sibyte/sb1250/irq.c l=
inux-my/arch/mips/sibyte/sb1250/irq.c
--- linux/arch/mips/sibyte/sb1250/irq.c	2005-07-11 12:03:30.000000000 +0200
+++ linux-my/arch/mips/sibyte/sb1250/irq.c	2005-09-22 13:26:21.000000000 +0=
200
@@ -53,7 +53,7 @@
 static unsigned int startup_sb1250_irq(unsigned int irq);
 static void ack_sb1250_irq(unsigned int irq);
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask);
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask);
 #endif
=20
 #ifdef CONFIG_SIBYTE_HAS_LDT
@@ -117,23 +117,16 @@
 }
=20
 #ifdef CONFIG_SMP
-static void sb1250_set_affinity(unsigned int irq, unsigned long mask)
+static void sb1250_set_affinity(unsigned int irq, cpumask_t mask)
 {
 	int i =3D 0, old_cpu, cpu, int_on;
 	u64 cur_ints;
 	irq_desc_t *desc =3D irq_desc + irq;
 	unsigned long flags;
=20
-	while (mask) {
-		if (mask & 1) {
-			mask >>=3D 1;
-			break;
-		}
-		mask >>=3D 1;
-		i++;
-	}
+	i =3D first_cpu(mask);
=20
-	if (mask) {
+	if (cpus_weight(mask) > 1) {
 		printk("attempted to set irq affinity for irq %d to multiple CPUs\n", ir=
q);
 		return;
 	}

--NKoe5XOeduwbEQHU--

--tNQTSEo8WG/FKZ8E
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDM0swKLKVw/RurbsRAloPAKCJjt5lNI0pymFUrnOxMDz4FcE5VACgqNdh
UxD8F/Hx1t3omVy6TU5JScQ=
=uMum
-----END PGP SIGNATURE-----

--tNQTSEo8WG/FKZ8E--
