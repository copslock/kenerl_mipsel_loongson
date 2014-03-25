Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Mar 2014 17:11:03 +0100 (CET)
Received: from mail.skyhub.de ([78.46.96.112]:49659 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819766AbaCYQKdUDfSZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 25 Mar 2014 17:10:33 +0100
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1395763832; bh=eXykLaC44u/LUIZKc04pF3CiSLLHWRDZjfIPUQh0WOM=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=WgFyaXBvmXXvJyKGGfQvs3OYgPJc58DIokGaMb
        hdolpXa3OWBLDRruEmJ9lOmVaQpqpp5VdiqTUu2HX5KZ9vCEopxGdofVSJjg0ad4s5F
        T/uy6tsifOBCnCSW6V7D2QHcGlrv4L5fyCIeCFq7et5W/UoU8wxRv8d7opVeoDjLsE=
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id GRsqUXSCmsSr; Tue, 25 Mar 2014 17:10:32 +0100 (CET)
Received: from liondog.tnic (p4FF1CBAE.dip0.t-ipconnect.de [79.241.203.174])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 5B78C1D9730;
        Tue, 25 Mar 2014 17:10:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1395763832; bh=eXykLaC44u/LUIZKc04pF3CiSLLHWRDZjfIPUQh0WOM=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=WgFyaXBvmXXvJyKGGfQvs3OYgPJc58DIokGaMb
        hdolpXa3OWBLDRruEmJ9lOmVaQpqpp5VdiqTUu2HX5KZ9vCEopxGdofVSJjg0ad4s5F
        T/uy6tsifOBCnCSW6V7D2QHcGlrv4L5fyCIeCFq7et5W/UoU8wxRv8d7opVeoDjLsE=
Received: by liondog.tnic (Postfix, from userid 1000)
        id 3D534100B7A; Tue, 25 Mar 2014 17:10:28 +0100 (CET)
Date:   Tue, 25 Mar 2014 17:10:28 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Krause <nickkrause@sympatico.ca>
Cc:     "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>
Subject: Re: RESEND: PATCH[60485 Bug adding breakpoint for msi-pci]
Message-ID: <20140325161028.GA6393@pd.tnic>
References: <SNT145-W982FA6E38A0213DE61456DA5780@phx.gbl>
 <SNT145-W3682AF4AA1AE6F941FDC1BA57A0@phx.gbl>
 <SNT145-W659480DCC260415F2FA288A5650@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SNT145-W659480DCC260415F2FA288A5650@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bp@alien8.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39579
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
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

On Tue, Mar 25, 2014 at 02:27:04AM +0000, Nick Krause wrote:
> > Here is my new patch as corrected for the the bug 60845.
> > https://bugzilla.kernel.org/show_bug.cgi?id=60845
> > This is the link to the bug and my comments / conversation on to get the corrections needed.
> >  Below is my patch for the bug, please let me know if it gets added finally Alan .
> >
> >  --- linux-3.13.6/arch/mips/pci/msi-octeon.c.orig    2014-03-22 17:32:44.762754254 -0400
> >  +++ linux-3.13.6/arch/mips/pci/msi-octeon.c    2014-03-22 17:34:19.974753699 -0400
> >  @@ -150,6 +150,7 @@ msi_irq_allocated:
> >           msg.address_lo =
> >               ((128ul << 20) + CVMX_PCI_MSI_RCV) & 0xffffffff;
> >           msg.address_hi = ((128ul << 20) + CVMX_PCI_MSI_RCV)>> 32;
> >  +        break;

Looks like this has been fixed already: 7f02c463057fc527f52066742b84d9d89b22e83d

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
