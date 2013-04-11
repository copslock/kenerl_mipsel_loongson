Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Apr 2013 19:31:55 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:49836 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6834990Ab3DKRbvxR12y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 11 Apr 2013 19:31:51 +0200
Received: from arrakis.dune.hu ([127.0.0.1])
        by localhost (arrakis.dune.hu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DDkD_B-qQYpZ; Thu, 11 Apr 2013 19:31:05 +0200 (CEST)
Received: from [192.168.254.50] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by arrakis.dune.hu (Postfix) with ESMTPSA id E7EE9280420;
        Thu, 11 Apr 2013 19:31:03 +0200 (CEST)
Message-ID: <5166F39C.1050907@openwrt.org>
Date:   Thu, 11 Apr 2013 19:32:12 +0200
From:   Gabor Juhos <juhosg@openwrt.org>
MIME-Version: 1.0
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: implement pcibios_get_phb_of_node
References: <1365098483-26821-1-git-send-email-juhosg@openwrt.org> <1365098483-26821-2-git-send-email-juhosg@openwrt.org> <CAErSpo4ih-Kgp4LxX1MDodac-eoPo=Mu1d6ex8oNnaEEc_GQnw@mail.gmail.com>
In-Reply-To: <CAErSpo4ih-Kgp4LxX1MDodac-eoPo=Mu1d6ex8oNnaEEc_GQnw@mail.gmail.com>
X-Enigmail-Version: 1.5.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
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

2013.04.10. 18:31 keltezéssel, Bjorn Helgaas írta:
> On Thu, Apr 4, 2013 at 12:01 PM, Gabor Juhos <juhosg@openwrt.org> wrote:
>> The of_node field of the device assigned to a
>> PCI bus is used during scanning of the PCI bus.
>> However on MIPS, the of_node field is assigned
>> only after the bus has been scanned.
>>
>> Implement the architecture specific version of
>> 'pcibios_get_phb_of_node'. Which ensures that the
>> PCI driver core will initialize the of_node field
>> before starting the scan.
>>
>> Also remove the local assignment of bus->dev.of_node,
>> it is not needed after the patch.
>>
>> Signed-off-by: Gabor Juhos <juhosg@openwrt.org>
> 
> I removed the __weak annotation from include/linux/pci.h and applied
> this patch to my pci/gabor-get-of-node.

Thank you!

> Give it a try and make sure
> it solves your problem.  If so, and Ralph approves, I can push both
> for v3.10.  It should appear at
> http://git.kernel.org/cgit/linux/kernel/git/helgaas/pci.git/log/?h=pci/gabor-get-of-node
> soon.

I have tried your patch on top of 3.9-rc6. The resulting kernel uses the
architecture specific implementation, and it runs fine.

  $ mipsel-openwrt-linux-readelf -s arch/mips/pci/built-in.o \
    drivers/pci/built-in.o vmlinux.o | grep pcibios_get_phb_of_node
      93: 0000046c    12 FUNC    GLOBAL DEFAULT    2 pcibios_get_phb_of_node
    1433: 00012a2c   104 FUNC    WEAK   DEFAULT    2 pcibios_get_phb_of_node
   31863: 001d4dbc    12 FUNC    GLOBAL DEFAULT    2 pcibios_get_phb_of_node
  $

For completeness, I have compiled it for X64 and for powerpc as well. I did not
try to run these kernels, but the output of readelf seems to be ok:

  $ readelf -s arch/x86/kernel/built-in.o drivers/pci/built-in.o vmlinux.o | \
    grep pcibios_get_phb_of_node
    2761: 000273a0    86 FUNC    GLOBAL DEFAULT    1 pcibios_get_phb_of_node
    1705: 00018770    77 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
   60364: 000278a0    86 FUNC    GLOBAL DEFAULT    1 pcibios_get_phb_of_node
  $

  $ powerpc-openwrt-linux-readelf -s arch/powerpc/kernel/built-in.o \
    drivers/pci/built-in.o  vmlinux.o | grep pcibios_get_phb_of_node
    1002: 0000ca28    12 FUNC    GLOBAL DEFAULT    1 pcibios_get_phb_of_node
    1485: 0001453c    88 FUNC    WEAK   DEFAULT    1 pcibios_get_phb_of_node
   28959: 0000d598    12 FUNC    GLOBAL DEFAULT    1 pcibios_get_phb_of_node
  $

> Or if you prefer, you can take them through the MIPS tree.

Either is fine.

-Gabor
