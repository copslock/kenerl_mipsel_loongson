Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Dec 2004 19:48:20 +0000 (GMT)
Received: from RT-soft-2.Moscow.itn.ru ([IPv6:::ffff:80.240.96.70]:154 "HELO
	mail.dev.rtsoft.ru") by linux-mips.org with SMTP
	id <S8225247AbULGTsQ>; Tue, 7 Dec 2004 19:48:16 +0000
Received: (qmail 24609 invoked from network); 7 Dec 2004 19:21:42 -0000
Received: from unknown (HELO dev.rtsoft.ru) (192.168.1.199)
  by mail.dev.rtsoft.ru with SMTP; 7 Dec 2004 19:21:42 -0000
Message-ID: <41B608FD.7070209@dev.rtsoft.ru>
Date: Tue, 07 Dec 2004 22:48:13 +0300
From: Pavel Kiryukhin <savl@dev.rtsoft.ru>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
CC: Pavel Kiryukhin <savl@dev.rtsoft.ru>
Subject: i/o and memory space enable bits in PCI-PCI bridge 
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <savl@dev.rtsoft.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: savl@dev.rtsoft.ru
Precedence: bulk
X-list: linux-mips

Hi!
Can somebody give me a hint:  - what part of 2.6 (mips) code is 
responsible for setting i/o and memory space enable bits in PCI-PCI 
bridge config. space command register?
On my board those bits are not set after bridge is configured.
Currently I'm using the following change in "pcibios_enable_resources" 
to work with devices behind the bridge.
--- arch/mips/pci/pci.c_org    2004-12-06 18:20:50.000000000 +0300
+++ arch/mips/pci/pci.c    2004-12-06 18:21:22.000000000 +0300
@@ -164,7 +164,7 @@

    pci_read_config_word(dev, PCI_COMMAND, &cmd);
    old_cmd = cmd;
-    for(idx=0; idx<6; idx++) {
+    for(idx=0; idx<=PCI_BRIDGE_RESOURCES; idx++) {
        /* Only set up the requested stuff */
        if (!(mask & (1<<idx)))
            continue;

but I think there should be some legal way I missed.
--
Thank you,
Pavel Kiryukhin.
