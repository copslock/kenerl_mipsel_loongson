Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Apr 2009 20:53:01 +0100 (BST)
Received: from n3a.bullet.mail.ac4.yahoo.com ([76.13.13.66]:30659 "HELO
	n3a.bullet.mail.ac4.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with SMTP id S20026712AbZD3Twz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 30 Apr 2009 20:52:55 +0100
Received: from [76.13.13.26] by n3.bullet.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 19:52:48 -0000
Received: from [76.13.10.172] by t3.bullet.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 19:52:48 -0000
Received: from [127.0.0.1] by omp113.mail.ac4.yahoo.com with NNFMP; 30 Apr 2009 19:52:48 -0000
X-Yahoo-Newman-Property: ymail-3
X-Yahoo-Newman-Id: 816480.72355.bm@omp113.mail.ac4.yahoo.com
Received: (qmail 94255 invoked by uid 60001); 30 Apr 2009 19:52:48 -0000
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s1024; t=1241121168; bh=HXNRfMw4tORKZG1IHSP3solyjJCz3/ZG6S+m+4hFvm8=; h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type; b=LmUDc0ZtKsvIfDzfJWKl9ZSkQdYJTSaZkxVPwbLVYz8/5lUPaieHOiBhNwhUwhoKeVBLXfUoaZrzrqxAMij2Bz9q/ERDRP343vBPyTjIc6PaMRqorqMB4uTAOE4XlQHpdvSIn4pHUmqrSW2AF2xcDrV7qTY0XBWXlU2P+z7v+sA=
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:X-YMail-OSG:Received:X-Mailer:Date:From:Reply-To:Subject:To:MIME-Version:Content-Type;
  b=FiE0A2GC70TXsGQIsfPoS7txgI0o3yjBvtUobNkMXahcyBMLPQGytQ+yck7MSFYu7W3Dqn6j3eQ1at/LfYQiiS7bz+KvbVYBAECYgwRUlBgrO31Grj1IIBdaBtcZRe+VxE3/d0sX5152Y0oBE8EughqGE1P8Ljjzh/eWJzuYypM=;
Message-ID: <634924.93716.qm@web59804.mail.ac4.yahoo.com>
X-YMail-OSG: LUHr4VkVM1kafq51qMTiw2YHmQvGXxRUe7f0l.VsE6_GNxdMnOlTbhdgw2E0NftxN2H0rOgANjtzJu4fQ9UEJLRtWvSpJwRhbEGYuSrQe2R1mMTbuLT1yWpsu8U9KmrIxuaKMuP.ePhZdfeKfwTjZlWFyiASOuaowBbtABozbIU1dd_kACkvKURprm7wlQhSQnfR5cr7Y9gzQeDDQPt.jxunMA7UT2tGhZJEXvJnvnGFDPTOF3az.E.v4k_bUJRWzeNB7EV4k2sLodRLZ3NvUkovy4kEKJDOjh0XpQdNE6dYEX0Vm81TmKYtMdPPtgO6h81SU_IFFWjQ_0Xz7TgYIRiYCvo00Uu1DnoJ48vpllKxdRJf9Q--
Received: from [91.196.252.17] by web59804.mail.ac4.yahoo.com via HTTP; Thu, 30 Apr 2009 12:52:48 PDT
X-Mailer: YahooMailWebService/0.7.289.1
Date:	Thu, 30 Apr 2009 12:52:48 -0700 (PDT)
From:	Andrew Randrianasulu <randrik_a@yahoo.com>
Reply-To: randrik_a@yahoo.com
Subject: [PATCH]  0001-sgi-o2-crmfbreg-file
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <randrik_a@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: randrik_a@yahoo.com
Precedence: bulk
X-list: linux-mips


another small patch, adding crmfbreg.h header into tree.

----------

diff --git a/include/video/crmfbreg.h b/include/video/crmfbreg.h
new file mode 100644
index 0000000..5714a3e
--- /dev/null
+++ b/include/video/crmfbreg.h
@@ -0,0 +1,275 @@
+/* $NetBSD: crmfbreg.h,v 1.9 2008/11/06 22:16:03 macallan Exp $ */
+
+/*-
+ * Copyright (c) 2007 Jared D. McNeill <jmcneill@invisible.ca>
+ *               2008 Michael Lorenz <macallan@netbsd.org>
+ * All rights reserved.
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions
+ * are met:
+ * 1. Redistributions of source code must retain the above copyright
+ *    notice, this list of conditions and the following disclaimer.
+ * 2. Redistributions in binary form must reproduce the above copyright
+ *    notice, this list of conditions and the following disclaimer in the
+ *    documentation and/or other materials provided with the distribution.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE NETBSD FOUNDATION, INC. AND CONTRIBUTORS
+ * ``AS IS'' AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED
+ * TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR
+ * PURPOSE ARE DISCLAIMED.  IN NO EVENT SHALL THE FOUNDATION OR CONTRIBUTORS
+ * BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
+
+/*
+ * SGI-CRM (O2) Framebuffer driver, register definitions
+ */
+
+#ifndef CRMFBREG_H
+#define CRMFBREG_H
+
+#define CRMFB_DOTCLOCK		0x00000004
+#define		CRMFB_DOTCLOCK_CLKRUN_SHIFT	20
+#define CRMFB_VT_XY		0x00010000
+#define		CRMFB_VT_XY_FREEZE_SHIFT	31
+#define	CRMFB_VT_FLAGS		0x00010018
+#define		CRMFB_VT_FLAGS_SYNC_LOW_MSB	5
+#define		CRMFB_VT_FLAGS_SYNC_LOW_LSB	5
+#define CRMFB_VT_INTR01		0x00010020
+#define		CRMFB_VT_INTR01_EN		0xffffffff
+#define CRMFB_VT_INTR23		0x00010024
+#define		CRMFB_VT_INTR23_EN		0xffffffff
+#define CRMFB_VT_VPIX_EN	0x00010038
+#define		CRMFB_VT_VPIX_EN_OFF_SHIFT	0
+#define CRMFB_VT_HCMAP		0x0001003c
+#define		CRMFB_VT_HCMAP_ON_SHIFT		12
+#define CRMFB_VT_VCMAP		0x00010040
+#define		CRMFB_VT_VCMAP_ON_SHIFT		12
+#define CRMFB_OVR_WIDTH_TILE	0x00020000
+#define CRMFB_OVR_CONTROL	0x00020008
+#define		CRMFB_OVR_CONTROL_DMAEN_SHIFT	0
+#define CRMFB_FRM_TILESIZE	0x00030000
+#define		CRMFB_FRM_TILESIZE_RHS_SHIFT	0
+#define		CRMFB_FRM_TILESIZE_WIDTH_SHIFT	5
+#define		CRMFB_FRM_TILESIZE_DEPTH_SHIFT	13
+#define			CRMFB_FRM_TILESIZE_DEPTH_8	0
+#define			CRMFB_FRM_TILESIZE_DEPTH_16	1
+#define			CRMFB_FRM_TILESIZE_DEPTH_32	2
+#define		CRMFB_FRM_TILESIZE_FIFOR_SHIFT	15
+#define CRMFB_FRM_PIXSIZE	0x00030004
+#define		CRMFB_FRM_PIXSIZE_HEIGHT_SHIFT	16
+#define CRMFB_FRM_CONTROL	0x0003000c
+#define		CRMFB_FRM_CONTROL_DMAEN_SHIFT	0
+#define		CRMFB_FRM_CONTROL_LINEAR_SHIFT	1
+#define		CRMFB_FRM_CONTROL_TILEPTR_SHIFT	9
+#define CRMFB_DID_CONTROL	0x00040004
+#define		CRMFB_DID_CONTROL_DMAEN_SHIFT	0
+#define CRMFB_MODE		0x00048000
+#define		CRMFB_MODE_TYP_SHIFT		2
+#define			CRMFB_MODE_TYP_I8	0
+#define			CRMFB_MODE_TYP_ARGB5	4
+#define			CRMFB_MODE_TYP_RGB8	5
+#define		CRMFB_MODE_BUF_SHIFT		0
+#define			CRMFB_MODE_BUF_BOTH	3
+#define CRMFB_CMAP		0x00050000
+#define CRMFB_CMAP_FIFO		0x00058000
+#define CRMFB_GMAP		0x00060000
+#define CRMFB_CURSOR_POS	0x00070000
+/*
+ * upper 16 bit are Y, lower 16 bit are X - both signed so there's no need for
+ * a hotspot register
+ */
+#define CRMFB_CURSOR_CONTROL	0x00070004
+	#define CRMFB_CURSOR_ON		0x00000001
+#define CRMFB_CURSOR_CMAP0	0x00070008
+#define CRMFB_CURSOR_CMAP1	0x0007000c
+#define CRMFB_CURSOR_CMAP2	0x00070010
+#define CRMFB_CURSOR_BITMAP	0x00078000
+/* two bit deep cursor image, zero is transparent */
+
+/* rendering engine registers */
+/* these TLBs define 16x16 tiles, 64kB each, upper 16 bit only */
+#define CRIME_RE_TLB_A		0x1000
+#define CRIME_RE_TLB_B		0x1200
+#define CRIME_RE_TLB_C		0x1400
+#define CRIME_RE_TEX		0x1600
+#define CRIME_RE_CLIP_IDS	0x16e0
+/* 32bit entries, 4kB page address >> 12 | 0x80000000 */
+#define CRIME_RE_LINEAR_A	0x1700
+#define CRIME_RE_LINEAR_B	0x1780
+
+/* memory transfer engine from 0x3000*/
+#define CRIME_MTE_MODE		0x3000
+#define CRIME_MTE_BYTEMASK	0x3008
+#define CRIME_MTE_STIPPLEMASK	0x3010
+#define CRIME_MTE_BG		0x3018
+#define CRIME_MTE_SRC0		0x3020	/* start */
+#define CRIME_MTE_SRC1		0x3028	/* end */
+#define CRIME_MTE_DST0		0x3030	/* start */
+#define CRIME_MTE_DST1		0x3038	/* end */
+#define CRIME_MTE_SRC_Y_STEP	0x3040
+#define CRIME_MTE_DST_Y_STEP	0x3048
+#define CRIME_MTE_NULL		0x3070
+#define CRIME_MTE_FLUSH		0x3078
+
+/* CRIME_MTE_MODE */
+#define MTE_MODE_DST_ECC	0x00000001	/* enable ECC in DST */
+#define MTE_MODE_SRC_ECC	0x00000002	/* enable ECC in SRC */
+#define MTE_MODE_DST_BUF_MASK	0x0000001c
+	#define MTE_TLB_A	0
+	#define MTE_TLB_B	1
+	#define MTE_TLB_C	2
+	#define MTE_TLB_TEX	3
+	#define MTE_TLB_LIN_A	4
+	#define MTE_TLB_LIN_B	5
+	#define MTE_TLB_CLIP	6
+	#define MTE_DST_TLB_SHIFT 2
+#define MTE_MODE_SRC_BUF_MASK	0x000000e0
+	#define MTE_SRC_TLB_SHIFT 5
+#define MTE_MODE_DEPTH_MASK	0x00000300
+	#define MTE_DEPTH_8	0
+	#define MTE_DEPTH_16	1
+	#define MTE_DEPTH_32	2
+	#define MTE_DEPTH_SHIFT 8
+#define MTE_MODE_STIPPLE	0x00000400
+#define MTE_MODE_COPY		0x00000800	/* 1 - copy, 0 - clear dst */
+
+/* drawing engine from 0x2000 */
+#define CRIME_DE_MODE_SRC	0x2000
+#define CRIME_DE_MODE_DST	0x2008
+#define CRIME_DE_CLIPMODE	0x2010
+#define CRIME_DE_DRAWMODE	0x2018
+#define CRIME_DE_SCRMASK0	0x2020
+#define CRIME_DE_SCRMASK1	0x2028
+#define CRIME_DE_SCRMASK2	0x2030
+#define CRIME_DE_SCRMASK3	0x2038
+#define CRIME_DE_SCRMASK4	0x2040
+#define CRIME_DE_SCISSOR	0x2048
+#define CRIME_DE_WINOFFSET_SRC	0x2050	/* x in upper, y in lower 16 bit */
+#define CRIME_DE_WINOFFSET_DST	0x2058
+#define CRIME_DE_PRIMITIVE	0x2060
+#define CRIME_DE_X_VERTEX_0	0x2070
+#define CRIME_DE_X_VERTEX_1	0x2074
+#define CRIME_DE_X_VERTEX_2	0x2078
+#define CRIME_DE_GL_VERTEX_0_X	0x2080
+#define CRIME_DE_GL_VERTEX_0_Y	0x2084
+#define CRIME_DE_GL_VERTEX_1_X	0x2088
+#define CRIME_DE_GL_VERTEX_1_Y	0x208c
+#define CRIME_DE_GL_VERTEX_2_X	0x2090
+#define CRIME_DE_GL_VERTEX_2_Y	0x2094
+#define CRIME_DE_XFER_ADDR_SRC	0x20a0
+#define CRIME_DE_XFER_STRD_SRC	0x20a4
+#define CRIME_DE_XFER_STEP_X	0x20a8
+#define CRIME_DE_XFER_STEP_Y	0x20ac
+#define CRIME_DE_XFER_ADDR_DST	0x20b0
+#define CRIME_DE_XFER_STRD_DST	0x20b4
+#define CRIME_DE_STIPPLE_MODE	0x20c0
+#define CRIME_DE_STIPPLE_PAT	0x20c4
+#define CRIME_DE_FG		0x20d0
+#define CRIME_DE_BG		0x20d8
+#define CRIME_DE_ALPHA_COLOR	0x21a0	/* constant colour for alpha */
+#define CRIME_DE_ALPHA_FUNC	0x21a8	/* blend function */
+#define CRIME_DE_ROP		0x21b0
+#define CRIME_DE_PLANEMASK	0x21b8
+
+#define CRIME_DE_NULL		0x21f0
+#define CRIME_DE_FLUSH		0x21f8
+
+#define CRIME_DE_START		0x0800	/* OR this to a register address in
+					 * order to start a command */
+
+/* CRIME_DE_MODE_* */
+#define DE_MODE_TLB_A		0x00000000
+#define DE_MODE_TLB_B		0x00000400
+#define DE_MODE_TLB_C		0x00000800
+#define DE_MODE_LIN_A		0x00001000
+#define DE_MODE_LIN_B		0x00001400
+#define DE_MODE_BUFDEPTH_8	0x00000000
+#define DE_MODE_BUFDEPTH_16	0x00000100
+#define DE_MODE_BUFDEPTH_32	0x00000200
+#define DE_MODE_TYPE_CI		0x00000000
+#define DE_MODE_TYPE_RGB	0x00000010
+#define DE_MODE_TYPE_RGBA	0x00000020
+#define DE_MODE_TYPE_ABGR	0x00000030
+#define DE_MODE_TYPE_YCRCB	0x000000f0
+#define DE_MODE_PIXDEPTH_8	0x00000000
+#define DE_MODE_PIXDEPTH_16	0x00000004
+#define DE_MODE_PIXDEPTH_32	0x00000008
+#define DE_MODE_DOUBLE_PIX	0x00000002
+#define DE_MODE_DOUBLE_SELECT	0x00000001
+
+/* clip mode */
+#define DE_CLIPMODE_ENABLE	0x00000800
+
+/* draw mode */
+#define DE_DRAWMODE_NO_CONF	0x00800000	/* disable coherency testing */
+#define DE_DRAWMODE_X11		0x00000000
+#define DE_DRAWMODE_GL		0x00400000
+#define DE_DRAWMODE_XFER_EN	0x00200000
+#define DE_DRAWMODE_SCISSOR_EN	0x00100000
+#define DE_DRAWMODE_LINE_STIP	0x00080000
+#define DE_DRAWMODE_POLY_STIP	0x00040000
+#define DE_DRAWMODE_OPAQUE_STIP	0x00020000
+#define DE_DRAWMODE_SHADE	0x00010000	/* smooth shading enable */
+#define DE_DRAWMODE_TEXTURE	0x00008000
+#define DE_DRAWMODE_FOG		0x00004000
+#define DE_DRAWMODE_COVERAGE	0x00002000
+#define DE_DRAWMODE_LINE_AA	0x00001000
+#define DE_DRAWMODE_ALPHA_TEST	0x00000800
+#define DE_DRAWMODE_ALPHA_BLEND	0x00000400
+#define DE_DRAWMODE_ROP		0x00000200
+#define DE_DRAWMODE_DITHER	0x00000100
+#define DE_DRAWMODE_PLANEMASK	0x00000080
+#define DE_DRAWMODE_BYTEMASK	0x00000078
+#define DE_DRAWMODE_DEPTH_TEST	0x00000004
+#define DE_DRAWMODE_DEPTH_MASK	0x00000002
+#define DE_DRAWMODE_STENCIL	0x00000001
+
+/* primitive */
+#define DE_PRIM_POINT		0x00000000
+#define DE_PRIM_LINE		0x01000000
+#define DE_PRIM_TRIANGLE	0x02000000
+#define DE_PRIM_RECTANGLE	0x03000000
+#define DE_PRIM_LINE_SKIP_END	0x00040000
+#define DE_PRIM_LR		0x00000000	/* left to right */
+#define DE_PRIM_RL		0x00010000	/* right to left */
+#define DE_PRIM_BT		0x00000000	/* bottom to top */
+#define DE_PRIM_TB		0x00020000	/* top to bottom */
+#define DE_PRIM_LINE_WIDTH_MASK	0x0000ffff	/* in half pixels */
+
+/* alpha function register */
+#define DE_ALPHA_ADD		0x00000000
+#define DE_ALPHA_MIN		0x00000100
+#define DE_ALPHA_MAX		0x00000200
+#define DE_ALPHA_SUB		0x00000300
+#define DE_ALPHA_REV_SUB	0x00000400
+
+#define DE_ALPHA_OP_ZERO		0
+#define DE_ALPHA_OP_ONE			1
+#define DE_ALPHA_OP_DST_COLOR		2
+#define DE_ALPHA_OP_1_MINUS_DST_COLOR	3
+#define DE_ALPHA_OP_SRC_ALPHA		4
+#define DE_ALPHA_OP_1_MINUS_SRC_ALPHA	5
+#define DE_ALPHA_OP_DST_ALPHA		6
+#define DE_ALPHA_OP_1_MINUS_DST_APLHA	7
+#define DE_ALPHA_OP_CONSTANT_COLOR	8
+#define DE_ALPHA_OP_1_MINUS_CONST_COLOR	9
+#define DE_ALPHA_OP_CONSTANT_ALPHA	10
+#define DE_ALPHA_OP_1_MINUS_CONST_ALPHA	11
+#define DE_ALPHA_OP_SRC_ALPHA_SATURATE	12
+
+#define DE_ALPHA_OP_SRC_SHIFT 4
+#define DE_ALPHA_OP_DST_SHIFT 0
+
+/* status register */
+#define CRIME_DE_STATUS		0x4000
+#define CRIME_DE_IDLE		0x10000000
+#define CRIME_DE_READY		0x02000000
+
+#endif /* CRMFBREG_H */


----

Michael said what adding file as-is should be acceptable (at least for experimentation, i hope). It will be used in my next small patch.


      
