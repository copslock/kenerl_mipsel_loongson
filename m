Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Aug 2003 05:54:26 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:23546 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8225297AbTH1EyY>;
	Thu, 28 Aug 2003 05:54:24 +0100
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id VAA16109
	for <linux-mips@linux-mips.org>; Wed, 27 Aug 2003 21:54:12 -0700
Message-ID: <3F4D8AF3.D9BF7D51@mvista.com>
Date: Wed, 27 Aug 2003 22:54:11 -0600
From: Michael Pruznick <michael_pruznick@mvista.com>
Reply-To: michael_pruznick@mvista.com
Organization: MontaVista
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: PATCH:2.4:2.6:compile fails with outw_p() in :?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <michael_pruznick@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael_pruznick@mvista.com
Precedence: bulk
X-list: linux-mips

Because mips uses #define with do..while(0) for outw_p (and
not inline like other arches) herems.h fails to compile.  ?:
requires and expr and do..while(0) is a statement.  Here are
the compile errors followed by my proposed patches for both
2.4 and 2.6.

build errors with CONFIG_HERMES=y
hermes.h: In function `hermes_set_irqmask':
hermes.h:337: parse error before "do"
hermes.h:337: parse error before ';' token
hermes.h: In function `hermes_write_words':

2.4
Index: drivers/net/wireless/hermes.h
===================================================================
RCS file: /home/cvs/linux/drivers/net/wireless/hermes.h,v
retrieving revision 1.6.2.4
diff -u -r1.6.2.4 hermes.h
--- drivers/net/wireless/hermes.h       13 Aug 2003 17:19:20 -0000      1.6.2.4
+++ drivers/net/wireless/hermes.h       27 Aug 2003 21:37:24 -0000
@@ -302,12 +302,14 @@
 #define hermes_read_reg(hw, off) ((hw)->io_space ? \
        inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
        readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
-#define hermes_write_reg(hw, off, val) ((hw)->io_space ? \
-       outw_p((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
-       writew((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )))
-
-#define hermes_read_regn(hw, name) (hermes_read_reg((hw), HERMES_##name))
-#define hermes_write_regn(hw, name, val) (hermes_write_reg((hw), HERMES_##name, (val)))
+#define hermes_write_reg(hw, off, val) do { \
+       if ( (hw)->io_space ) \
+               outw_p((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )); \
+       else \
+               writew((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )); \
+       } while (0)
+#define hermes_read_regn(hw, name) hermes_read_reg((hw), HERMES_##name)
+#define hermes_write_regn(hw, name, val) hermes_write_reg((hw), HERMES_##name, (val))
 
 /* Function prototypes */
 void hermes_struct_init(hermes_t *hw, ulong address, int io_space, int reg_spacing);


2.6
Index: drivers/net/wireless/hermes.h
===================================================================
RCS file: /home/cvs/linux/drivers/net/wireless/hermes.h,v
retrieving revision 1.10
diff -u -r1.10 hermes.h
--- drivers/net/wireless/hermes.h       22 Jun 2003 23:09:54 -0000      1.10
+++ drivers/net/wireless/hermes.h       27 Aug 2003 21:46:20 -0000
@@ -302,12 +302,14 @@
 #define hermes_read_reg(hw, off) ((hw)->io_space ? \
        inw((hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
        readw((hw)->iobase + ( (off) << (hw)->reg_spacing )))
-#define hermes_write_reg(hw, off, val) ((hw)->io_space ? \
-       outw_p((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )) : \
-       writew((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )))
-
-#define hermes_read_regn(hw, name) (hermes_read_reg((hw), HERMES_##name))
-#define hermes_write_regn(hw, name, val) (hermes_write_reg((hw), HERMES_##name, (val)))
+#define hermes_write_reg(hw, off, val) do { \
+       if ( (hw)->io_space ) \
+               outw_p((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )); \
+       else \
+               writew((val), (hw)->iobase + ( (off) << (hw)->reg_spacing )); \
+       } while (0)
+#define hermes_read_regn(hw, name) hermes_read_reg((hw), HERMES_##name)
+#define hermes_write_regn(hw, name, val) hermes_write_reg((hw), HERMES_##name, (val))
 
 /* Function prototypes */
 void hermes_struct_init(hermes_t *hw, ulong address, int io_space, int reg_spacing);
