Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Mar 2014 11:58:30 +0100 (CET)
Received: from mail.skyhub.de ([78.46.96.112]:35358 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822287AbaCFK620KDaZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 6 Mar 2014 11:58:28 +0100
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1394103507; bh=XNcwaTGirH4Xe5XomBZ9WbZEeXHS1ubRLU5oVB3f4j0=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Transfer-Encoding:In-Reply-To; b=nTgxnB0jXscW
        99QcjVWIsMwOOH9u5YG0a+PL9fkC/PPGTcLoRi4dzMp4FGiaL4tIhqmlQ1LGQnK6bbM
        HLl+Tg36Wjogk5eoqEg0xasC8nLkqP5XD+Uody4wCWqr3iiOFSHhvG5JPdpzcPTfwBX
        AFQf+39LZXIfSL5We3IzYuKcY=
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OxYlJonoCDPo; Thu,  6 Mar 2014 11:58:27 +0100 (CET)
Received: from liondog.tnic (p4FF1C440.dip0.t-ipconnect.de [79.241.196.64])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 421C21D96BD;
        Thu,  6 Mar 2014 11:58:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1394103507; bh=XNcwaTGirH4Xe5XomBZ9WbZEeXHS1ubRLU5oVB3f4j0=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Transfer-Encoding:In-Reply-To; b=nTgxnB0jXscW
        99QcjVWIsMwOOH9u5YG0a+PL9fkC/PPGTcLoRi4dzMp4FGiaL4tIhqmlQ1LGQnK6bbM
        HLl+Tg36Wjogk5eoqEg0xasC8nLkqP5XD+Uody4wCWqr3iiOFSHhvG5JPdpzcPTfwBX
        AFQf+39LZXIfSL5We3IzYuKcY=
Received: by liondog.tnic (Postfix, from userid 1000)
        id 8BD7F10020D; Thu,  6 Mar 2014 11:58:21 +0100 (CET)
Date:   Thu, 6 Mar 2014 11:58:21 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Nick Krause <nickkrause@sympatico.ca>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alan@lxorguk.ukuu.org.uk" <alan@lxorguk.ukuu.org.uk>,
        David Daney <ddaney@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Patch[Kernel 3.13.5]
Message-ID: <20140306105821.GA24636@pd.tnic>
References: <SNT145-W1141791FC5F60B7E0788170A5880@phx.gbl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <SNT145-W1141791FC5F60B7E0788170A5880@phx.gbl>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <bp@alien8.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39430
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

On Thu, Mar 06, 2014 at 04:00:04AM +0000, Nick Krause wrote:
> Here is my first patch, adding a break point to fix bug 60845, case fallout through on switch 
> in arch/mips/pci/msi-octeon.c.
> 
> --- //home/nick/linux-3.13.5/arch/mips/pci/msi-octeon.c.orig    2014-03-05 22:48:19.084372515 -0500
> +++ //home/nick/linux-3.13.5/arch/mips/pci/msi-octeon.c    2014-03-05 22:48:48.388372344 -0500
> @@ -150,6 +150,7 @@ msi_irq_allocated:
>          msg.address_lo =
>              ((128ul << 20) + CVMX_PCI_MSI_RCV) & 0xffffffff;
>          msg.address_hi = ((128ul << 20) + CVMX_PCI_MSI_RCV)>> 32;
> +        break;
>      case OCTEON_DMA_BAR_TYPE_BIG:
>          /* When using big bar, Bar 0 is based at 0 */
>          msg.address_lo = (0 + CVMX_PCI_MSI_RCV) & 0xffffffff;
> Got one error no maintainer otherwise not issues with coding style.

Looks like a real bug you've found, as e8635b484f644 still has the
"break" in there.

However, if you want to learn how to prepare patches properly, take a
look at Documentation/SubmittingPatches.

There it also says how to find out who exactly to send this patch to:

$ ./scripts/get_maintainer.pl -f arch/mips/pci/msi-octeon.c
Ralf Baechle <ralf@linux-mips.org> (supporter:MIPS)
linux-mips@linux-mips.org (open list:MIPS)

I've CCed them.

-- 
Regards/Gruss,
    Boris.

Sent from a fat crate under my desk. Formatting is fine.
--
