Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Oct 2017 09:27:29 +0200 (CEST)
Received: from bastet.se.axis.com ([195.60.68.11]:46399 "EHLO
        bastet.se.axis.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991258AbdJFH1WLN-sm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Oct 2017 09:27:22 +0200
Received: from localhost (localhost [127.0.0.1])
        by bastet.se.axis.com (Postfix) with ESMTP id 9649B18A22;
        Fri,  6 Oct 2017 09:27:16 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bastet.se.axis.com
Received: from bastet.se.axis.com ([IPv6:::ffff:127.0.0.1])
        by localhost (bastet.se.axis.com [::ffff:127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id gvRNUMmaBSQb; Fri,  6 Oct 2017 09:27:15 +0200 (CEST)
Received: from boulder02.se.axis.com (boulder02.se.axis.com [10.0.8.16])
        by bastet.se.axis.com (Postfix) with ESMTPS id 04E2818C6D;
        Fri,  6 Oct 2017 09:27:13 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B2D911A067;
        Fri,  6 Oct 2017 09:27:13 +0200 (CEST)
Received: from boulder02.se.axis.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id A47F71A066;
        Fri,  6 Oct 2017 09:27:13 +0200 (CEST)
Received: from seth.se.axis.com (unknown [10.0.2.172])
        by boulder02.se.axis.com (Postfix) with ESMTP;
        Fri,  6 Oct 2017 09:27:13 +0200 (CEST)
Received: from lnxjespern3.se.axis.com (lnxjespern3.se.axis.com [10.88.4.8])
        by seth.se.axis.com (Postfix) with ESMTP id 9325D2822;
        Fri,  6 Oct 2017 09:27:13 +0200 (CEST)
Received: by lnxjespern3.se.axis.com (Postfix, from userid 363)
        id 8E2DF800EF; Fri,  6 Oct 2017 09:27:13 +0200 (CEST)
Date:   Fri, 6 Oct 2017 09:27:13 +0200
From:   Jesper Nilsson <jesper.nilsson@axis.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jesper Nilsson <jespern@axis.com>, linux-am33-list@redhat.com,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Helge Deller <deller@gmx.de>, x86@kernel.org,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Ingo Molnar <mingo@redhat.com>,
        Matt Turner <mattst88@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        linux-xtensa@linux-xtensa.org, Mikael Starvik <starvik@axis.com>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Thomas Gleixner <tglx@linutronix.de>,
        Richard Henderson <rth@twiddle.net>,
        Chris Zankel <chris@zankel.net>,
        Tony Luck <tony.luck@intel.com>, linux-cris-kernel@axis.com,
        linux-parisc@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-alpha@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 2/4] PCI: Remove redundant pci_dev, pci_bus, resource
 declarations
Message-ID: <20171006072713.GP17578@axis.com>
References: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171005203849.18300.20999.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171005203849.18300.20999.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-TM-AS-GCONF: 00
Return-Path: <jesper.nilsson@axis.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jesper.nilsson@axis.com
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

On Thu, Oct 05, 2017 at 03:38:49PM -0500, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> <linux/pci.h> defines struct pci_bus and struct pci_dev and includes the
> struct resource definition before including <asm/pci.h>.  Nobody includes
> <asm/pci.h> directly, so they don't need their own declarations.
> 
> Remove the redundant struct pci_dev, pci_bus, resource declarations.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/alpha/include/asm/pci.h    |    3 ---
>  arch/cris/include/asm/pci.h     |    2 --

For what it's worth, for the cris changes:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

>  arch/frv/include/asm/pci.h      |    2 --
>  arch/ia64/include/asm/pci.h     |    2 --
>  arch/mips/include/asm/pci.h     |    2 --
>  arch/mn10300/include/asm/pci.h  |    2 --
>  arch/parisc/include/asm/pci.h   |    7 -------
>  arch/powerpc/include/asm/pci.h  |    2 --
>  arch/sh/include/asm/pci.h       |    2 --
>  arch/sparc/include/asm/pci_32.h |    2 --
>  arch/xtensa/include/asm/pci.h   |    2 --
>  11 files changed, 28 deletions(-)

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
