Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 15:07:08 +0100 (BST)
Received: from smtp.vmb-service.ru ([IPv6:::ffff:80.73.198.33]:53205 "EHLO
	smtp.vmb-service.ru") by linux-mips.org with ESMTP
	id <S8224907AbUJKOHD>; Mon, 11 Oct 2004 15:07:03 +0100
Received: from PIX-NAT.vmb-service.ru ([80.73.192.74]:7899 "EHLO alec")
	by Altair with ESMTP id <S1161463AbUJKOGo>;
	Mon, 11 Oct 2004 18:06:44 +0400
Reply-To: <a.voropay@vmb-service.ru>
From: "Alec Voropay" <a.voropay@vmb-service.ru>
To: <ralf@linux-mips.org>, <tsbogend@alpha.franken.de>
Cc: <linux-mips@linux-mips.org>
Subject: PATCH: linux_2_4 jazzonic.c
Date: Mon, 11 Oct 2004 18:09:02 +0400
Organization: VMB-Service
Message-ID: <02f401c4af9b$df306920$1701a8c0@vmbservice.ru>
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_02F5_01C4AFBD.66420920"
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.4024
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4942.400
Importance: Normal
Return-Path: <a.voropay@vmb-service.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: a.voropay@vmb-service.ru
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.

------=_NextPart_000_02F5_01C4AFBD.66420920
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit

Hi!

drivers/net/jazzsonic.c

1) #include <linux/module.h>

2) Device address is "unsigned long"
as definded in the
include/linux/netdevice.h


P.S. It seems, 2.6 requires this too.


-- 
-=AV=- 

------=_NextPart_000_02F5_01C4AFBD.66420920
Content-Type: text/plain;
	name="patch_2_4-jazzonic.txt"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="patch_2_4-jazzonic.txt"

diff -Naur -p -X dontdiff linux_2_4/drivers/net/jazzsonic.c =
linux_2_4-jazz/drivers/net/jazzsonic.c
--- linux_2_4/drivers/net/jazzsonic.c   Fri Aug 20 10:47:05 2004
+++ linux_2_4-jazz/drivers/net/jazzsonic.c      Mon Oct 11 17:44:44 2004
@@ -14,6 +14,7 @@
  */

 #include <linux/kernel.h>
+#include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/types.h>
 #include <linux/fcntl.h>
@@ -84,7 +85,7 @@ static unsigned short known_revisions[]
 /* Index to functions, as function prototypes. */

 extern int sonic_probe(struct net_device *dev);
-static int sonic_probe1(struct net_device *dev, unsigned int base_addr,
+static int sonic_probe1(struct net_device *dev, unsigned long =
base_addr,
                         unsigned int irq);


@@ -94,7 +95,7 @@ static int sonic_probe1(struct net_devic
  */
 int __init sonic_probe(struct net_device *dev)
 {
-       unsigned int base_addr =3D dev ? dev->base_addr : 0;
+       unsigned long base_addr =3D dev ? dev->base_addr : 0;
        int i;

        /*
@@ -117,7 +118,7 @@ int __init sonic_probe(struct net_device
        return -ENODEV;
 }

-static int __init sonic_probe1(struct net_device *dev, unsigned int =
base_addr,
+static int __init sonic_probe1(struct net_device *dev, unsigned long =
base_addr,
                                unsigned int irq)
 {
        static unsigned version_printed;

------=_NextPart_000_02F5_01C4AFBD.66420920--
