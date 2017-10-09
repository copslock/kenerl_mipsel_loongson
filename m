Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Oct 2017 15:10:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53954 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992636AbdJINK0sjUYY (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Oct 2017 15:10:26 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v99DA7WP012322;
        Mon, 9 Oct 2017 15:10:07 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v99DA2Dp012318;
        Mon, 9 Oct 2017 15:10:02 +0200
Date:   Mon, 9 Oct 2017 15:10:02 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Bjorn Helgaas <helgaas@kernel.org>
Cc:     linux-pci@vger.kernel.org, linux-mips@linux-mips.org,
        Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
        linux-sh@vger.kernel.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Howells <dhowells@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        linux-am33-list@redhat.com,
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
        linux-parisc@vger.kernel.org, linux-alpha@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH 1/4] PCI: Remove redundant pcibios_set_master()
 declarations
Message-ID: <20171009131002.GF20977@linux-mips.org>
References: <20171005201939.18300.25690.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20171005203842.18300.67328.stgit@bhelgaas-glaptop.roam.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171005203842.18300.67328.stgit@bhelgaas-glaptop.roam.corp.google.com>
User-Agent: Mutt/1.9.0 (2017-09-02)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60342
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Oct 05, 2017 at 03:38:42PM -0500, Bjorn Helgaas wrote:

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> All users of pcibios_set_master() include <linux/pci.h>, which already has
> a declaration.  Remove the unnecessary declarations from the <asm/pci.h>
> files.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  arch/alpha/include/asm/pci.h   |    2 --
>  arch/cris/include/asm/pci.h    |    1 -
>  arch/frv/include/asm/pci.h     |    2 --
>  arch/mips/include/asm/pci.h    |    2 --
>  arch/mn10300/include/asm/pci.h |    2 --
>  arch/parisc/include/asm/pci.h  |    1 -
>  arch/sh/include/asm/pci.h      |    2 --
>  arch/x86/include/asm/pci.h     |    1 -
>  8 files changed, 13 deletions(-)

For MIPS:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
