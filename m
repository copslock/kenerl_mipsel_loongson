Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 01:07:20 +0000 (GMT)
Received: from mail.lantronix.com ([IPv6:::ffff:164.109.145.13]:21513 "EHLO
	sjwc380049.int.lantronix.com") by linux-mips.org with ESMTP
	id <S8225331AbUCRBHT> convert rfc822-to-8bit; Thu, 18 Mar 2004 01:07:19 +0000
Received: from sjwc380101.int.lantronix.com (unverified) by 
    sjwc380049.int.lantronix.com (Content Technologies SMTPRS 4.3.6) with 
    ESMTP id <T6866333a2c0a6b64a674c@sjwc380049.int.lantronix.com> for 
    <linux-mips@linux-mips.org>; Wed, 17 Mar 2004 17:07:12 -0800
Received: from sj580004wcom.int.lantronix.com ([10.107.100.143]) by 
    sjwc380101.int.lantronix.com with Microsoft SMTPSVC (5.0.2195.5329); Wed, 
    17 Mar 2004 17:03:13 -0800
X-MimeOLE: Produced By Microsoft Exchange V6.0.6249.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: Debugging resource trees
Date: Wed, 17 Mar 2004 17:03:13 -0800
Message-ID: <603BA0CFF3788E46A0DB0918D9AA95100A09CA40@sj580004wcom.int.lantronix.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Debugging resource trees
Thread-Index: AcQLfrAsZHcX0Fh4SJW2CVPt4CpEvgBA9M7A
From: "Jerry Walden" <jerry.walden@lantronix.com>
To: <linux-mips@linux-mips.org>
X-OriginalArrivalTime: 18 Mar 2004 01:03:13.0644 (UTC) 
    FILETIME=[C9F0E2C0:01C40C84]
Return-Path: <jerry.walden@lantronix.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerry.walden@lantronix.com
Precedence: bulk
X-list: linux-mips

Because of the limited debugging resources I have right now (i.e. no
emulator etc..) I am debugging part of my kernel with printk's.  

Has anyone seen behavior such as this, or does anyone have any
suggestions.

I placed a some printk's in resource.c in request_resource function.  I
placed a routine that dumps the iomem and ioport resource trees prior
to, and after a new resource gets added.  Ioport resources get dumped
out (and also reflect cat /proc/ioport), however - even though it
appears that a new iomem resource is getting added, when I dump the
iomem tree/list it appears to be empty (which also reflects car
/proc/iomem).

Below is a sample of the debug prints.  

I placed some debug code in the routine to printk the pointer variables
when items are added to the list in order to check the linked list code,
however - even though the debug code is simple - it causes a segfault
(which I have not bothered to figure out yet).

When I insmod pcmcia_core, and then insmod yenta_socket a new resource
is allocated:
PCI CardBus #02 start = 0x41000000 end = 0x413fffff

request resource at root pci memory space start = 0x40000000 end =
0x4fffffff

BEFORE added new to list:

IOPORT RESOURCES:
IO: 02a41000-02a41007 : ide0 (PSC: 802e2990, 85829560, 00000000)
IO: 02a41206-02a41206 : ide0 (PSC: 802e2990, 8032c420, 00000000)
IO: ad000000-ad003fff : ltxser (PSC: 802e2990, 86905a20, 00000000)
IO: b0400000-b0400fff : frontpanel (PSC: 802e2990, 8032c3e0, 00000000)
IO: b1100000-b1100007 : serial(auto) (PSC: 802e2990, 8032c3c0, 00000000)
IO: b1400000-b1400007 : serial(auto) (PSC: 802e2990, 85829480, 00000000)
IO: b1500000-b150ffff : Au1x00 ENET (PSC: 802e2990, 85829500, 00000000)
IO: b1510000-b151ffff : Au1x00 ENET (PSC: 802e2990, 00000000, 00000000)

IOMEM RESOURCES:
iomem_resource name = PCI mem
iomem_resource child = 0x00000000

AFTER added new to list

IOPORT RESOURCES:
IO: 02a41000-02a41007 : ide0 (PSC: 802e2990, 85829560, 00000000)
IO: 02a41206-02a41206 : ide0 (PSC: 802e2990, 8032c420, 00000000)
IO: ad000000-ad003fff : ltxser (PSC: 802e2990, 86905a20, 00000000)
IO: b0400000-b0400fff : frontpanel (PSC: 802e2990, 8032c3e0, 00000000)
IO: b1100000-b1100007 : serial(auto) (PSC: 802e2990, 8032c3c0, 00000000)
IO: b1400000-b1400007 : serial(auto) (PSC: 802e2990, 85829480, 00000000)
IO: b1500000-b150ffff : Au1x00 ENET (PSC: 802e2990, 85829500, 00000000)
IO: b1510000-b151ffff : Au1x00 ENET (PSC: 802e2990, 00000000, 00000000)

IOMEM RESOURCES:
iomem_resource name = PCI mem
iomem_resource child = 0x00000000


After the modules are inserted:
-bash-2.05b# cat /proc/iomem

-bash-2.05b# cat /proc/ioports
02a41000-02a41007 : ide0
02a41206-02a41206 : ide0
ad000000-ad003fff : ltxser
b0400000-b0400fff : frontpanel
b1100000-b1100007 : serial(auto)
b1400000-b1400007 : serial(auto)
b1500000-b150ffff : Au1x00 ENET
b1510000-b151ffff : Au1x00 ENET
-bash-2.05b#


**********************************************************************
This e-mail is the property of Lantronix. It is intended only for the person or entity to which it is addressed and may contain information that is privileged, confidential, or otherwise protected from disclosure. Distribution or copying of this e-mail, or the information contained herein, to anyone other than the intended recipient is prohibited.
