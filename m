Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 20:15:23 +0000 (GMT)
Received: from dhcp-1263-9.blizz.at ([IPv6:::ffff:213.143.126.4]:1767 "EHLO
	cervus.intra") by linux-mips.org with ESMTP id <S8225227AbUKNUPQ>;
	Sun, 14 Nov 2004 20:15:16 +0000
Received: from xterm.intra ([10.49.1.10])
	by cervus.intra with esmtp (Exim 4.34)
	id 1CTQmF-0006zs-0P; Sun, 14 Nov 2004 21:15:11 +0100
Subject: [PATCH] fix for big-endian bug in arch/mips/pci/ops-au1000.c
From: Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
To: Pete Popov <ppopov@embeddedalley.com>
Cc: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: Research Group for Industrial Software @ Vienna University of
	Technology
Date: Sun, 14 Nov 2004 21:03:13 +0100
Message-Id: <1100462594.3329.5.camel@xterm.intra>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Return-Path: <hvr@inso.tuwien.ac.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hvr@inso.tuwien.ac.at
Precedence: bulk
X-list: linux-mips


well, w/ the following modification, the code becomes
endian-independent... :-)

diff -u -r1.11 ops-au1000.c
--- arch/mips/pci/ops-au1000.c  6 Jun 2004 02:12:38 -0000       1.11
+++ arch/mips/pci/ops-au1000.c  14 Nov 2004 19:59:23 -0000
@@ -288,10 +288,18 @@
                       int where, int size, u32 * val)
 {
        switch (size) {
-       case 1:
-               return read_config_byte(bus, devfn, where, (u8 *) val);
-       case 2:
-               return read_config_word(bus, devfn, where, (u16 *) val);
+       case 1: {
+                       u8 _val;
+                       int rc = read_config_byte(bus, devfn, where, &_val);
+                       *val = _val;
+                       return rc;
+               }
+       case 2: {
+                       u16 _val;
+                       int rc = read_config_word(bus, devfn, where, &_val);
+                       *val = _val; 
+                       return rc;
+               }
        default:
                return read_config_dword(bus, devfn, where, val);
        }




-- 
Herbert Valerio Riedel <hvr@inso.tuwien.ac.at>
Research Group for Industrial Software @ Vienna University of Technology
