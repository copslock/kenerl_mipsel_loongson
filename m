Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Apr 2012 12:04:55 +0200 (CEST)
Received: from mail.skyhub.de ([78.46.96.112]:56907 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903642Ab2DAKEv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 1 Apr 2012 12:04:51 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4487F1D9C11;
        Sun,  1 Apr 2012 12:04:50 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1333274690; bh=fgfW1dIwbkHrIwNqgGQYRlP+jtXz1e1sbfrsBb6KgmY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=YaX6/gEGQne0Sa4MLA6gXja4tar7YIHIlSnZZy
        Hv2rbpF08atGOYiVww/ccmWVM0IJDn4VoPI5BAvKkqaxR8EGg9ra+1IGoNFEPIEpvDp
        2VBWYpevhqiniR5klEScrQY03tribAqda01SWT34RpeQinIZdpS9pPDX2IamL4Vnyc=
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id a4sRHMOeaefi; Sun,  1 Apr 2012 12:04:50 +0200 (CEST)
Received: from liondog.tnic (p4FF1D52B.dip.t-dialin.net [79.241.213.43])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id A52D71D9B04;
        Sun,  1 Apr 2012 12:04:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1333274689; bh=fgfW1dIwbkHrIwNqgGQYRlP+jtXz1e1sbfrsBb6KgmY=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=BdGci+M7wnSfbDrg7Zjh5aTbjEidehfCbQY8Bw
        oTqjS9ycftxmrSI0Nr0Ndaz/kfLkqlH9BNgdvadcKVZ87Txawq/voaoPLnTUeNj4FJs
        KCwdy2/0dwU6zs4KHpgZ8Haex+De2enfOZ5nyOxYegw3khCPoCTx+Fjjm7DgNusIqs=
Received: by liondog.tnic (Postfix, from userid 1000)
        id 455264B8D46; Sun,  1 Apr 2012 12:04:48 +0200 (CEST)
Date:   Sun, 1 Apr 2012 12:04:48 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc:     linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        linux@arm.linux.org.uk, dhowells@redhat.com, jejb@parisc-linux.org,
        linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com
Subject: Re: [PATCH RFC] Simplify the Linux kernel by reducing its state space
Message-ID: <20120401100448.GD14848@liondog.tnic>
Mail-Followup-To: Borislav Petkov <bp@alien8.de>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m32r@ml.linux-m32r.org, linux-m32r-ja@ml.linux-m32r.org,
        linux-mips@linux-mips.org, linux-am33-list@redhat.com,
        linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, tglx@linutronix.de,
        linux@arm.linux.org.uk, dhowells@redhat.com, jejb@parisc-linux.org,
        linux390@de.ibm.com, x86@kernel.org, cmetcalf@tilera.com
References: <20120331163321.GA15809@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20120331163321.GA15809@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 32851
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Apr 01, 2012 at 12:33:21AM +0800, Paul E. McKenney wrote:
> Although there have been numerous complaints about the complexity of
> parallel programming (especially over the past 5-10 years), the plain
> truth is that the incremental complexity of parallel programming over
> that of sequential programming is not as large as is commonly believed.
> Despite that you might have heard, the mind-numbing complexity of modern
> computer systems is not due so much to there being multiple CPUs, but
> rather to there being any CPUs at all.  In short, for the ultimate in
> computer-system simplicity, the optimal choice is NR_CPUS=0.
> 
> This commit therefore limits kernel builds to zero CPUs.  This change
> has the beneficial side effect of rendering all kernel bugs harmless.
> Furthermore, this commit enables additional beneficial changes, for
> example, the removal of those parts of the kernel that are not needed
> when there are zero CPUs.
> 
> Signed-off-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

Looks good, thanks for doing that.

Btw, I just got confirmation from hw folk that we can actually give you
hardware support for that code with an upcoming CPU which has NR_CPUS=0
cores.

Oh, and additionally, we can disable some of those so getting into the
negative is also doable from the hw perspective, so feel free to explore
that side of the problem too.

ACK.

-- 
Regards/Gruss,
    Boris.
