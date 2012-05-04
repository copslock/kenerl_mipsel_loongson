Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2012 15:39:06 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:37167 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903664Ab2EDNjC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2012 15:39:02 +0200
Message-ID: <4FA3DBA3.5030903@phrozen.org>
Date:   Fri, 04 May 2012 15:37:39 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: pci and pcie coexistence
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hi,

I have some boards, where pcie and pci need to coexist.

This implies, that both drivers share the same pcibios_plat_dev_init and
pcibios_map_irq.

I am trying to figure out, how to best differentiate between the 2
drivers. Would the following be sane ?

if (pci_find_capability(pdev, PCI_CAP_ID_EXP))
     do_pcie_stuf();
else
     do_pci_stuff();


Thanks,
John
