Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Aug 2018 11:54:27 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:55898 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990880AbeHAJyMZ85fX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Aug 2018 11:54:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=hvPyNLQm3ZyFXyddKd3YxqhUvwHCSQ0ceGsCnecee9w=; b=Eaet4ihQRkxekiI46Vi4SDWMo
        Q943qcqjfeE7fkaMjzZD7gmHMrwmuJGHrfiaEMfhL0W6Xem4l5gNKCM4h7Q2dDv8ApkAA3Z5i11r+
        3hkBoj973wp5BoaCzA5cqc89ZrUyMACtoBVbhVBAJDCttOyZjyS/5PCuLiGJs93CVK1D4vJ9CWUf4
        PBgMQDgAD4i2udPuRpHs022HhbrQo7IS9EecgiG/Y5JIAzLdqac5HIosFSvkkqkUa+swVnV0MSL2D
        Liu5h8Xt7cVGkCOYH/qLGmsvrOSdmfx2/K0YcKMOj0w77at6B4+MNjh8by1k457XjMpTYRkbVFChG
        KnNU+8cfQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fknpU-0004jZ-NB; Wed, 01 Aug 2018 09:54:04 +0000
Date:   Wed, 1 Aug 2018 02:54:04 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Alexei Colin <acolin@isi.edu>
Cc:     Alexandre Bounine <alex.bou9@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        John Paul Walters <jwalters@isi.edu>, x86@kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180801095404.GA17585@infradead.org>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180731142954.30345-7-acolin@isi.edu>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+568b9e22b4768da93666+5456+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65344
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@infradead.org
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

On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
> Platforms with a PCI bus will be offered the RapidIO menu since they may
> be want support for a RapidIO PCI device. Platforms without a PCI bus
> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> 
> Tested that kernel builds for arm64 with RapidIO subsystem and
> switch drivers enabled, also that the modules load successfully
> on a custom Aarch64 Qemu model.

As said before, please include it from drivers/Kconfig so that _all_
architectures supporting PCI (or other Rapidio attachements) get it
and not some arbitrary selection of architectures.
