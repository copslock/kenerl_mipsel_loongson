Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Mar 2005 00:05:35 +0000 (GMT)
Received: from NAT.office.mind.be ([IPv6:::ffff:62.166.230.82]:21632 "EHLO
	nat.office.mind.be") by linux-mips.org with ESMTP
	id <S8225302AbVCDAFT>; Fri, 4 Mar 2005 00:05:19 +0000
Received: from p2 by codecarver with local (Exim 3.36 #1 (Debian))
	id 1D70Jh-00010l-00; Fri, 04 Mar 2005 01:05:17 +0100
Date:	Fri, 4 Mar 2005 01:05:16 +0100
To:	linux-mips@linux-mips.org, ths@debian.org
Subject: G450 in 2.6 on swarm
Message-ID: <20050304000516.GA3539@mind.be>
Mail-Followup-To: peter.de.schrijver@mind.be, linux-mips@linux-mips.org,
	ths@debian.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mxv5cy4qt+RJ9ypb"
Content-Disposition: inline
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag:	Get yourself a real email client. http://www.mutt.org/
X-mate:	Mate, man gewoehnt sich an alles
User-Agent: Mutt/1.5.6+20040907i
From:	Peter 'p2' De Schrijver <p2@mind.be>
Return-Path: <p2@mind.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7364
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@mind.be
Precedence: bulk
X-list: linux-mips


--mxv5cy4qt+RJ9ypb
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

The attached patch makes the matrox G450 work on the swarm board in 32bit 2=
=2E6
kernels. The patch has only been verified on big endian swarm systems.=20

Enjoy,

Peter (p2).

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch1
Content-Transfer-Encoding: quoted-printable

diff -ur -x Entries linux/drivers/video/matrox/matroxfb_base.h linux.my/dri=
vers/video/matrox/matroxfb_base.h
--- linux/drivers/video/matrox/matroxfb_base.h	2005-02-07 03:54:54.00000000=
0 +0100
+++ linux.my/drivers/video/matrox/matroxfb_base.h	2005-03-01 01:35:18.00000=
0000 +0100
@@ -136,23 +136,23 @@
 } vaddr_t;
=20
 static inline unsigned int mga_readb(vaddr_t va, unsigned int offs) {
-	return readb(va.vaddr + offs);
+	return fb_readb(va.vaddr + offs);
 }
=20
 static inline void mga_writeb(vaddr_t va, unsigned int offs, u_int8_t valu=
e) {
-	writeb(value, va.vaddr + offs);
+	fb_writeb(value, va.vaddr + offs);
 }
=20
 static inline void mga_writew(vaddr_t va, unsigned int offs, u_int16_t val=
ue) {
-	writew(value, va.vaddr + offs);
+	fb_writew(value, va.vaddr + offs);
 }
=20
 static inline u_int32_t mga_readl(vaddr_t va, unsigned int offs) {
-	return readl(va.vaddr + offs);
+	return fb_readl(va.vaddr + offs);
 }
=20
 static inline void mga_writel(vaddr_t va, unsigned int offs, u_int32_t val=
ue) {
-	writel(value, va.vaddr + offs);
+	fb_writel(value, va.vaddr + offs);
 }
=20
 static inline void mga_memcpy_toio(vaddr_t va, const void* src, int len) {
@@ -170,14 +170,14 @@
=20
 	if ((unsigned long)src & 3) {
 		while (len >=3D 4) {
-			writel(get_unaligned((u32 *)src), addr);
+			fb_writel(get_unaligned((u32 *)src), addr);
 			addr++;
 			len -=3D 4;
 			src +=3D 4;
 		}
 	} else {
 		while (len >=3D 4) {
-			writel(*(u32 *)src, addr);
+			fb_writel(*(u32 *)src, addr);
 			addr++;
 			len -=3D 4;
 			src +=3D 4;
@@ -715,9 +715,10 @@
=20
 #define M_C2CTL		0x3C10
=20
-#define MX_OPTION_BSWAP         0x00000000
=20
 #ifdef __LITTLE_ENDIAN
+#define MX_OPTION_BSWAP         0x00000000
+
 #define M_OPMODE_4BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_BL=
IT)
 #define M_OPMODE_8BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_BL=
IT)
 #define M_OPMODE_16BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_B=
LIT)
@@ -725,11 +726,13 @@
 #define M_OPMODE_32BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE | M_OPMODE_DMA_B=
LIT)
 #else
 #ifdef __BIG_ENDIAN
+#define MX_OPTION_BSWAP         0x80000000
+
 #define M_OPMODE_4BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_LE       | M_OPMODE_=
DMA_BLIT)	/* TODO */
-#define M_OPMODE_8BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_BE_8BPP  | M_OPMODE_=
DMA_BLIT)
-#define M_OPMODE_16BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_BE_16BPP | M_OPMODE=
_DMA_BLIT)
-#define M_OPMODE_24BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_BE_8BPP  | M_OPMODE=
_DMA_BLIT)	/* TODO, ?32 */
-#define M_OPMODE_32BPP	(M_OPMODE_DMA_LE | M_OPMODE_DIR_BE_32BPP | M_OPMODE=
_DMA_BLIT)
+#define M_OPMODE_8BPP	(M_OPMODE_DMA_BE_8BPP | M_OPMODE_DIR_BE_8BPP  | M_OP=
MODE_DMA_BLIT)
+#define M_OPMODE_16BPP	(M_OPMODE_DMA_BE_16BPP | M_OPMODE_DIR_BE_16BPP | M_=
OPMODE_DMA_BLIT)
+#define M_OPMODE_24BPP	(M_OPMODE_DMA_BE_8BPP | M_OPMODE_DIR_BE_8BPP  | M_O=
PMODE_DMA_BLIT)	/* TODO, ?32 */
+#define M_OPMODE_32BPP	(M_OPMODE_DMA_BE_32BPP | M_OPMODE_DIR_BE_32BPP | M_=
OPMODE_DMA_BLIT)
 #else
 #error "Byte ordering have to be defined. Cannot continue."
 #endif
@@ -741,7 +744,12 @@
 #define mga_outw(addr,val)	mga_writew(ACCESS_FBINFO(mmio.vbase), (addr), (=
val))
 #define mga_outl(addr,val)	mga_writel(ACCESS_FBINFO(mmio.vbase), (addr), (=
val))
 #define mga_readr(port,idx)	(mga_outb((port),(idx)), mga_inb((port)+1))
+#ifdef __LITTLE_ENDIAN
 #define mga_setr(addr,port,val)	mga_outw(addr, ((val)<<8) | (port))
+#else
+#define mga_setr(addr,port,val) do { mga_outb(addr, port); mga_outb((addr)=
+1, val); } while (0)
+#endif
+
=20
 #define mga_fifo(n)	do {} while ((mga_inl(M_FIFOSTATUS) & 0xFF) < (n))
=20

--wRRV7LY7NUeQGEoC--

--mxv5cy4qt+RJ9ypb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCJ6Y8KLKVw/RurbsRAgXkAJ0R65VJhQqqFFcSTC/8awvsDW7JbQCbBXri
WJXhEq7Z0OE1kdj3MOd4WoY=
=bY3Q
-----END PGP SIGNATURE-----

--mxv5cy4qt+RJ9ypb--
