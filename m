Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Nov 2005 15:22:32 +0000 (GMT)
Received: from web35615.mail.mud.yahoo.com ([66.163.179.154]:1461 "HELO
	web35615.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133649AbVKFPWO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 6 Nov 2005 15:22:14 +0000
Received: (qmail 10452 invoked by uid 60001); 6 Nov 2005 15:23:14 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=YiojVKN+N37EOy3JSHMNIbD38zTEmWZCxYbYrgyMoW2pHRq/cTECZMweWam5Z+Y5Es96H5urlLgzbAxUpMyVoN5qn2EWTKdQkruzj39fOOlWmkRsE9SzTzBHonn9pJ/WGH9Uj3VJp2xpCDcs/vv2i85qGwIJQP56z4XB0xS+5cU=  ;
Message-ID: <20051106152314.10450.qmail@web35615.mail.mud.yahoo.com>
Received: from [66.218.47.204] by web35615.mail.mud.yahoo.com via HTTP; Sun, 06 Nov 2005 07:23:14 PST
Date:	Sun, 6 Nov 2005 07:23:14 -0800 (PST)
From:	Andre <armcc2000@yahoo.com>
Subject: 2.6.14-git9 cobalt build fails
To:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <armcc2000@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9430
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: armcc2000@yahoo.com
Precedence: bulk
X-list: linux-mips

Not sure if the cobalt support that's just gone into the mainstream
kernel is even supposed to compile yet... but it doesn't ;-) I tried
2.6.14 + git9 patch from kernel.org.

Note that default config was tweaked slightly (to enable IDE DMA and
a network driver).

  ...
  CC      arch/mips/pci/pci.o
  CC      arch/mips/pci/ops-gt64111.o
  CC      arch/mips/pci/fixup-cobalt.o
arch/mips/pci/fixup-cobalt.c:35: error:
`PCI_DEVICE_ID_MARVELL_GT64111' undeclared here (not in a function)
arch/mips/pci/fixup-cobalt.c:35: error: initializer element is not
constant
arch/mips/pci/fixup-cobalt.c:35: error: (near initialization for
`__pci_fixup_PCI_VENDOR_ID_MARVELLPCI_DEVICE_ID_MARVELL_GT64111qube_raq_galileo_early_fixup.device')
arch/mips/pci/fixup-cobalt.c:116: error: initializer element is not
constant
arch/mips/pci/fixup-cobalt.c:116: error: (near initialization for
`__pci_fixup_PCI_VENDOR_ID_MARVELLPCI_DEVICE_ID_MARVELL_GT64111qube_raq_galileo_fixup.device')
arch/mips/pci/fixup-cobalt.c:58: error:
__pci_fixup_PCI_VENDOR_ID_VIAPCI_DEVICE_ID_VIA_82C586_1qube_raq_via_bmIDE_fixup
causes a section type conflict
make[1]: *** [arch/mips/pci/fixup-cobalt.o] Error 1
make: *** [arch/mips/pci] Error 2
root@qube2:/usr/src/linux-2.6.14# 




		
__________________________________ 
Yahoo! FareChase: Search multiple travel sites in one click.
http://farechase.yahoo.com
