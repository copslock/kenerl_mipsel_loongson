Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Oct 2018 11:45:42 +0100 (CET)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:42874
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992087AbeJ2KphhlOUQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 29 Oct 2018 11:45:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=8Ualk9jtkWpjB7bYVqz+vL2mjxb2tON7rk5yFRjsZiY=; b=iFgYPtVn6CfKr9y0zoGZhB96M
        sfibn3qSfl8xZi14MnhfT4+mfYNtMPMn7lS+kZiMYrW0qp7lIh9KKlQJKv1/epan7fdFFOQpc9QCX
        6m7LyWVG8qVtmFyzCz0k6PODEai84MFC4+80F67NZfIyLLECggMuol3vQ9Mhi2smGEqJI=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:47390)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gH52M-00044N-G1; Mon, 29 Oct 2018 10:44:46 +0000
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gH52J-00084H-4y; Mon, 29 Oct 2018 10:44:43 +0000
Date:   Mon, 29 Oct 2018 10:44:41 +0000
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Will Deacon <will.deacon@arm.com>
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
Message-ID: <20181029104441.GF30658@n2100.armlinux.org.uk>
References: <1538067309-5711-1-git-send-email-maksym.kokhan@globallogic.com>
 <20180929181725.GB27441@fifo99.com>
 <CAMT6-xiQ0vGcKpA+SiWHQWQFwU9Oo9j=Zin+UXDoPqKTz5fbeA@mail.gmail.com>
 <CAMT6-xj1rjVAy1AWFiMHc5wH36eu=TUSMtdKU=-qRtUbwr9bkg@mail.gmail.com>
 <20181023144815.GP30658@n2100.armlinux.org.uk>
 <CAMT6-xhvqy5PeQmkQ8tsLRiML_pNJTxyq7dizRRvZTEqc7uzgg@mail.gmail.com>
 <20181024090732.GS30658@n2100.armlinux.org.uk>
 <20181029102914.GA14127@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029102914.GA14127@arm.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@armlinux.org.uk
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

On Mon, Oct 29, 2018 at 10:29:15AM +0000, Will Deacon wrote:
> On Wed, Oct 24, 2018 at 10:07:32AM +0100, Russell King - ARM Linux wrote:
> > On Wed, Oct 24, 2018 at 11:57:44AM +0300, Maksym Kokhan wrote:
> > > Do you mean, that you haven't seen patch for ARM, which I sent on
> > > September 27 along with cover and patch 1? It is strange, because
> > > you was the one from recipients. If so, you can see this patch here:
> > > https://lore.kernel.org/patchwork/patch/992779/
> > 
> > It seems that I have received patch 5, _but_ it's not threaded with
> > the cover message and patch 1.  With 50k messages in my inbox, and 3k
> > messages since you sent the series, it's virtually impossible to find
> > it (I only found it by looking at my mail server logs from September
> > to find the subject, and then searching my mailbox for that subject.)
> > 
> > This is unnecessarily difficult.
> 
> This comes up surprisingly often, and I think part of the issue is that
> different maintainers have different preferences. I also prefer to receive
> the entire series and cover-letter, but I've seen people object to being
> CC'd on the whole series as well (how they manage to review things in
> isolation is another question...!)

This series has the odd situation where patch 1 is threaded to the
cover letter, but nothing else is - that makes it inconsistent.

Where I've seen people disagree with threading is when sending
follow-up series - whether that should be threaded to the previous
series or not - some people want it others hate it.

However, I haven't seen any disagreement is about having the patches
threaded to the cover.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
