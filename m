Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Jul 2013 23:41:03 +0200 (CEST)
Received: from mail.free-electrons.com ([94.23.35.102]:33453 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831921Ab3GEVkm4MdQI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Jul 2013 23:40:42 +0200
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 81C89BAB; Fri,  5 Jul 2013 23:40:35 +0200 (CEST)
Received: from skate (AToulouse-651-1-103-169.w109-222.abo.wanadoo.fr [109.222.70.169])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 1B1B07B6;
        Fri,  5 Jul 2013 23:40:34 +0200 (CEST)
Date:   Fri, 5 Jul 2013 23:40:34 +0200
From:   Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        Russell King <linux@arm.linux.org.uk>,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@free-electrons.com>,
        Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
        linux-arm <linux-arm-kernel@lists.infradead.org>,
        Maen Suleiman <maen@marvell.com>,
        Lior Amsalem <alior@marvell.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>
Subject: Re: [PATCHv4 02/11] pci: use weak functions for MSI arch-specific
 functions
Message-ID: <20130705234034.6c57cd43@skate>
In-Reply-To: <CAErSpo4HoofGhN8VumRnN0sN_+gWJ9gVQJVMiePnDBUKwh74ag@mail.gmail.com>
References: <1372686136-1370-1-git-send-email-thomas.petazzoni@free-electrons.com>
        <1372686136-1370-3-git-send-email-thomas.petazzoni@free-electrons.com>
        <CAErSpo5uCpQftDmsMYEsFMtt_LP3kZPQ3Y4zz4VT7GdpcFq+1w@mail.gmail.com>
        <CAErSpo4HoofGhN8VumRnN0sN_+gWJ9gVQJVMiePnDBUKwh74ag@mail.gmail.com>
Organization: Free Electrons
X-Mailer: Claws Mail 3.9.1 (GTK+ 2.24.17; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <thomas.petazzoni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37272
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@free-electrons.com
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

Dear Bjorn Helgaas,

On Fri, 5 Jul 2013 15:34:10 -0600, Bjorn Helgaas wrote:
> On Fri, Jul 5, 2013 at 3:32 PM, Bjorn Helgaas <bhelgaas@google.com> wrote:
> 
> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> 
> But please update your subject line to use consistent capitalization, e.g.,
> 
> PCI: Use weak ...

Sure, will do.

Would it be possible to get Tested-by and/or Acked-by from the
different architecture maintainers affected by PATCH 02/11 and PATCH
03/11 ?

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
