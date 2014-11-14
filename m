Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 18:05:44 +0100 (CET)
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:55220 "EHLO
        mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013725AbaKNRFm1uszS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2014 18:05:42 +0100
Received: from pool-96-249-243-124.nrflva.fios.verizon.net ([96.249.243.124] helo=titan)
        by mho-01-ewr.mailhop.org with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.72)
        (envelope-from <jason@lakedaemon.net>)
        id 1XpKJN-000NB9-8o; Fri, 14 Nov 2014 17:05:29 +0000
Received: from titan.lakedaemon.net (localhost [127.0.0.1])
        by titan (Postfix) with ESMTP id 936CD61B22F;
        Fri, 14 Nov 2014 12:05:25 -0500 (EST)
X-Mail-Handler: Dyn Standard SMTP by Dyn
X-Originating-IP: 96.249.243.124
X-Report-Abuse-To: abuse@dyndns.com (see http://www.dyndns.com/services/sendlabs/outbound_abuse.html for abuse reporting information)
X-MHO-User: U2FsdGVkX1/+cwHq3FCkD8ZMocp3MZeFeOBsnVzddrw=
X-DKIM: OpenDKIM Filter v2.0.1 titan 936CD61B22F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1415984725;
        bh=FiB2iizQBrpjO+pYwoLOoFBowbEY/5UuN35ZaUNyIpc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=MjkOS7ZNLRMKCE4spfPqY4Byu1npy9Ena63h0Y5jBJ1Eg6C/ARmfeBqzQhSo0dEc8
         uDY4aGJA9oOhNGBh3b8OAdMsSBPe2c20j0hDWJ1sQKEFpG4YhFEZlOcat2AWaiwmSx
         088y0ZDmTW6r50YyD33VTI6yO9YbTpOGHr3ISXj01eVbX0PwOgRPiTWVln/xRCnJuz
         6NiRpPwT1iSR+z4LAoLQ45Mtf7fxKdSGPTLSF1hKJiNbYlaRhLEm2TXKuBP4baA0oa
         O8SxZMEGVGPx4+TQiL76YVVwhrIW3Dm8gXX3cUdyUwhUS8ViTB8EaqMH+6ZxOyhRLw
         3frusNynKtY5A==
Date:   Fri, 14 Nov 2014 12:05:25 -0500
From:   Jason Cooper <jason@lakedaemon.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V4 01/14] sh: Eliminate unused irq_reg_{readl,writel}
 accessors
Message-ID: <20141114170525.GL3698@titan.lakedaemon.net>
References: <1415342669-30640-1-git-send-email-cernekee@gmail.com>
 <1415342669-30640-2-git-send-email-cernekee@gmail.com>
 <CAMuHMdW+L8YbE8Z8jrtnm8xWk63sRGaFdM7TPM6MmrDg9XwHuQ@mail.gmail.com>
 <20141114163843.GH29662@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141114163843.GH29662@linux-mips.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44176
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

On Fri, Nov 14, 2014 at 05:38:44PM +0100, Ralf Baechle wrote:
> On Mon, Nov 10, 2014 at 09:13:49AM +0100, Geert Uytterhoeven wrote:
> 
> > On Fri, Nov 7, 2014 at 7:44 AM, Kevin Cernekee <cernekee@gmail.com> wrote:
> > > Defining these macros way down in arch/sh/.../irq.c doesn't cause
> > > kernel/irq/generic-chip.c to use them.  As far as I can tell this code
> > > has no effect.
> > >
> > > Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> > 
> > Compared preprocessor and asm output before and after, no difference
> > except for line numbers, so
> > 
> > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> 
> I noticed the remainder of of this series is now in Jason Cooper's irqchip
> tree.  Is anybody still taking care of SH?  If not I can funnel it
> through the MIPS tree.

Are the SH maintainers active?  I admit I know very little about the
arch.  I'm more than happy to pick it up and keep it with the rest of
the series, I just didn't want to step on toes...

thx,

Jason.
