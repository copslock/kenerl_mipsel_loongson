Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2018 15:34:18 +0200 (CEST)
Received: from pandora.armlinux.org.uk ([IPv6:2001:4d48:ad52:3201:214:fdff:fe10:1be6]:33660
        "EHLO pandora.armlinux.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeJNNePZlUaJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Oct 2018 15:34:15 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2014; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4+5BIwGkZ5fzO5Jb/ZW+HgKRlS4/jDjKt+4UtGEYqSk=; b=QlxpNzxYrDrnFczwEmitjWqiz
        wOti9c8fHhacIodmg4wyIaJV0KhST89twrFR4EZx+xCtiTUum76lq44OgTrmm2MRILa/tCkH767MT
        N4isVxJIsZDzs5ZINYJYNYMfmb4h9L1D+JR2C6WsAEw7rnpmSPlEepV32KKltASuNPbjU=;
Received: from n2100.armlinux.org.uk ([2001:4d48:ad52:3201:214:fdff:fe10:4f86]:39214)
        by pandora.armlinux.org.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.90_1)
        (envelope-from <linux@armlinux.org.uk>)
        id 1gBgWu-0003s9-82; Sun, 14 Oct 2018 14:34:00 +0100
Received: from linux by n2100.armlinux.org.uk with local (Exim 4.90_1)
        (envelope-from <linux@n2100.armlinux.org.uk>)
        id 1gBgWp-0005D9-4y; Sun, 14 Oct 2018 14:33:55 +0100
Date:   Sun, 14 Oct 2018 14:33:53 +0100
From:   Russell King - ARM Linux <linux@armlinux.org.uk>
To:     Tianyu Lan <lantianyu1986@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-mips@linux-mips.org,
        kvm <kvm@vger.kernel.org>, Radim Krcmar <rkrcmar@redhat.com>,
        benh@kernel.crashing.org, will.deacon@arm.com,
        christoffer.dall@arm.com, paulus@ozlabs.org,
        "H. Peter Anvin" <hpa@zytor.com>, kys@microsoft.com,
        kvmarm@lists.cs.columbia.edu, sthemmin@microsoft.com,
        mpe@ellerman.id.au, the arch/x86 maintainers <x86@kernel.org>,
        michael.h.kelley@microsoft.com, Ingo Molnar <mingo@redhat.com>,
        catalin.marinas@arm.com, jhogan@kernel.org,
        Tianyu Lan <Tianyu.Lan@microsoft.com>, marc.zyngier@arm.com,
        haiyangz@microsoft.com, kvm-ppc@vger.kernel.org,
        liran.alon@oracle.com, Paolo Bonzini <pbonzini@redhat.com>,
        linux-arm-kernel@lists.infradead.org,
        "linux-kernel@vger kernel org" <linux-kernel@vger.kernel.org>,
        ralf@linux-mips.org, paul.burton@mips.com,
        devel@linuxdriverproject.org, vkuznets@redhat.com,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V4 2/15] KVM/MMU: Add tlb flush with range helper function
Message-ID: <20181014133352.GX30658@n2100.armlinux.org.uk>
References: <20181013145406.4911-1-Tianyu.Lan@microsoft.com>
 <20181013145406.4911-3-Tianyu.Lan@microsoft.com>
 <4D709C3A-A91C-4CA7-922A-E77618EF21B4@oracle.com>
 <alpine.DEB.2.21.1810141014350.1438@nanos.tec.linutronix.de>
 <20181014092734.GV30658@n2100.armlinux.org.uk>
 <20181014093541.GW30658@n2100.armlinux.org.uk>
 <CAOLK0pzHAc1ipDbd3Trg2W_Gb_DxdEKM2ML5Fk09u0-O8y6UAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLK0pzHAc1ipDbd3Trg2W_Gb_DxdEKM2ML5Fk09u0-O8y6UAg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <linux+linux-mips=linux-mips.org@armlinux.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66830
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

On Sun, Oct 14, 2018 at 09:21:23PM +0800, Tianyu Lan wrote:
> Sorry to confuse your. I get from CCers from get_maintainer.pl script.

Unfortunately you seem to have made a mistake.  My email address is
'linux@armlinux.org.uk' not 'linux@armlinux.org'.  There is no
'linux@armlinux.org' in MAINTAINERS, yet your emails appear to be
copied to this address.

Consequently, if it was your intention to copy me with the entire
series, that didn't happen.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 12.1Mbps down 622kbps up
According to speedtest.net: 11.9Mbps down 500kbps up
