Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 May 2008 00:32:07 +0100 (BST)
Received: from koto.vergenet.net ([210.128.90.7]:7103 "HELO koto.vergenet.net")
	by ftp.linux-mips.org with SMTP id S20044359AbYE0XcF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 28 May 2008 00:32:05 +0100
Received: from yukiko.shinjuku.tokyo.vergenet.net (unknown [202.128.119.22])
	by koto.vergenet.net (Postfix) with ESMTP id 083C83406E;
	Wed, 28 May 2008 08:31:53 +0900 (JST)
Received: by yukiko.shinjuku.tokyo.vergenet.net (Postfix, from userid 7100)
	id F0C0FC22C2; Wed, 28 May 2008 09:31:49 +1000 (EST)
Date:	Wed, 28 May 2008 09:31:49 +1000
From:	Simon Horman <horms@verge.net.au>
To:	Tomasz Chmielewski <mangoo@wpkg.org>
Cc:	Nicolas Schichan <nschichan@freebox.fr>, linux-mips@linux-mips.org,
	Kexec Mailing List <kexec@lists.infradead.org>
Subject: Re: kexec on mips - anyone has it working?
Message-ID: <20080527233148.GB6752@verge.net.au>
References: <483BCB75.4050901@wpkg.org> <200805271405.55346.nschichan@freebox.fr> <483C0135.9070203@wpkg.org> <200805271449.45124.nschichan@freebox.fr> <483C4F73.4040909@wpkg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <483C4F73.4040909@wpkg.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Return-Path: <horms@verge.net.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19365
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: horms@verge.net.au
Precedence: bulk
X-list: linux-mips

On Tue, May 27, 2008 at 08:14:11PM +0200, Tomasz Chmielewski wrote:
> Nicolas Schichan schrieb:
> > On Tuesday 27 May 2008 14:40:21 you wrote:
> >>> Could you try to add the following line in machine_kexec.c, just before
> >>> jumping to the trampoline:
> >>>
> >>>        change_c0_config(CONF_CM_CMASK, CONF_CM_UNCACHED);
> >> And machine_kexec.c file is in where? It's not in the above one, it's
> >> not in kexec-tools-testing-20080324?
> > 
> > 
> > machine_kexec.c is in the kernel not in the kexec userland tools.
> 
> Aah, I see.
> 
> Anyway, it doesn't work - with or without this slight change in 
> machine_kexec.c, with kexec compiled from the sources in the link you 
> gave or with kexec-tools-testing-20080324, it just doesn't work on 
> BCM43XX with OpenWRT patches. At least on Asus WL-500gP.

Hi,

MIPS support was merged into kexec-tools-testing-20080324.
However, as far as I could tell it only supports one of the
many boot protocols that are used by various MIPS machines.

If things aren't working for a particular peice of hardware, I would
start by looking into what boot protocol the kernel uses on that
machine, and making sure that kexec-tools understands it.

As always if there are any patches for MIPS for kexec-tools, please send
them to me and this list.

-- 
Horms
