Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2018 11:29:18 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:42734 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992087AbeJ2K3PaUBBQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 29 Oct 2018 11:29:15 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 906F6165C;
        Mon, 29 Oct 2018 03:29:08 -0700 (PDT)
Received: from edgewater-inn.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.72.51.249])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 603E93F6A8;
        Mon, 29 Oct 2018 03:29:08 -0700 (PDT)
Received: by edgewater-inn.cambridge.arm.com (Postfix, from userid 1000)
        id 5978E1AE0757; Mon, 29 Oct 2018 10:29:15 +0000 (GMT)
Date:   Mon, 29 Oct 2018 10:29:15 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Russell King - ARM Linux <linux@armlinux.org.uk>
Cc:     Maksym Kokhan <maksym.kokhan@globallogic.com>,
        Daniel Walker <dwalker@fifo99.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Ard Biesheuvel <ard.biesheuvel@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Daniel Walker <danielwa@cisco.com>,
        Andrii Bordunov <aborduno@cisco.com>,
        Ruslan Bilovol <rbilovol@cisco.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-efi@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 0/8] add generic builtin command line
Message-ID: <20181029102914.GA14127@arm.com>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com>
 <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
 <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com>
 <20181023144815.GP30658@n2100.armlinux.org.uk>
 <CAMT6-xhvqy5PeQmkQ8tsLRiML_pNJTxyq7dizRRvZTEqc7uzgg@mail.gmail.com>
 <20181024090732.GS30658@n2100.armlinux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181024090732.GS30658@n2100.armlinux.org.uk>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66972
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

On Wed, Oct 24, 2018 at 10:07:32AM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 24, 2018 at 11:57:44AM +0300, Maksym Kokhan wrote:
> > Do you mean, that you haven't seen patch for ARM, which I sent on
> > September 27 along with cover and patch 1? It is strange, because
> > you was the one from recipients. If so, you can see this patch here:
> > https://lore.kernel.org/patchwork/patch/992779/
> 
> It seems that I have received patch 5, _but_ it's not threaded with
> the cover message and patch 1.  With 50k messages in my inbox, and 3k
> messages since you sent the series, it's virtually impossible to find
> it (I only found it by looking at my mail server logs from September
> to find the subject, and then searching my mailbox for that subject.)
> 
> This is unnecessarily difficult.

This comes up surprisingly often, and I think part of the issue is that
different maintainers have different preferences. I also prefer to receive
the entire series and cover-letter, but I've seen people object to being
CC'd on the whole series as well (how they manage to review things in
isolation is another question...!)

I wonder if we could have an entry in MAINTAINERS for this sort of
preference?

Maksym: in the short term, please just stick me and Russell on CC for the
entire thing.

Will
