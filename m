Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2014 23:35:11 +0200 (CEST)
Received: from helium.waldemar-brodkorb.de ([89.238.66.15]:45065 "EHLO
        helium.waldemar-brodkorb.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6843041AbaEJVfJMCGMz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 May 2014 23:35:09 +0200
Received: by helium.waldemar-brodkorb.de (Postfix, from userid 1000)
        id 80FCD10846; Sat, 10 May 2014 23:35:08 +0200 (CEST)
Date:   Sat, 10 May 2014 23:35:08 +0200
From:   Waldemar Brodkorb <wbx@openadk.org>
To:     linux-mips@linux-mips.org
Cc:     Gabor Juhos <juhosg@openwrt.org>, florian@openwrt.org,
        nbd@openwrt.org, phil@nwl.cc
Subject: pci problem with rb532
Message-ID: <20140510213508.GC618@waldemar-brodkorb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Operating-System: Linux 3.2.0-4-amd64 x86_64
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <wbx@openadk.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wbx@openadk.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi MIPS-Hackers,

I recently had a need for a small DHCP/NFS server and resurvived my
old Mikrotik RB532 board. Sadly the PCI registration is broken and
the VIA Rhine network ports didn't work.
See this thread for some details:
https://www.mail-archive.com/openwrt-devel@lists.openwrt.org/msg23073.html

I did know that it was working fine in the past, so I started to git
bisect between 2.6.39 and 3.15-rc5.
Following commit is the problem:
commit 222831787704c9ad9215f6b56f975b233968607c
Author: Gabor Juhos <juhosg@openwrt.org>
Date:   Sat Feb 2 13:18:54 2013 +0000

    MIPS: avoid possible resource conflict in register_pci_controller
    
    The IO and memory resources of a PCI controller
    might already have a parent resource set when
    they are passed to 'register_pci_controller'.
    
    If the parent resource is set, the request_resource
    call will fail due to resource conflict and the
    current code will not be able to register the
    PCI controller.
    
    Use the parent resource if it is available in the
    request_resource call to avoid the isssue.
    
    Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
    Patchwork: http://patchwork.linux-mips.org/patch/4910/
    Signed-off-by: John Crispin <blogic@openwrt.org>

After reverting the change, the VIA Rhine driver works fine again.

So how we can unbreak the rb532 support?

Thanks in advance
 Waldemar Brodkorb

P.s.: I am putting Florian and Felix in Cc, because we had a short
discussion about the problem via IRC.
