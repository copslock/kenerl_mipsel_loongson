Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 May 2013 20:29:11 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:40110 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817318Ab3EOS2VoO8-4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 May 2013 20:28:21 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 915A819BE7D;
        Wed, 15 May 2013 21:27:40 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 5c7Vx0AnYfGj; Wed, 15 May 2013 21:27:35 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id A897B5BC009;
        Wed, 15 May 2013 21:27:34 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Wed, 15 May 2013 21:27:34 +0300
Date:   Wed, 15 May 2013 21:27:34 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: loongson: fix random early boot hang
Message-ID: <20130515182734.GC3157@blackmetal.musicnaut.iki.fi>
References: <1361232039-12555-1-git-send-email-aaro.koskinen@iki.fi>
 <20130313134137.GB17165@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20130313134137.GB17165@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36409
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Wed, Mar 13, 2013 at 02:41:37PM +0100, Ralf Baechle wrote:
> On Tue, Feb 19, 2013 at 02:00:39AM +0200, Aaro Koskinen wrote:
> > Subject: [PATCH] MIPS: loongson: fix random early boot hang
> > 
> > Some Loongson boards (e.g. Lemote FuLoong mini-PC) use ISA/southbridge
> > device (CS5536 general purpose timer) for the timer interrupt. It starts
> > running early and is already enabled during the PCI configuration,
> > during which there is a small window in pci_read_base() when the register
> > access is temporarily disabled. If the timer interrupts at this point,
> > the system will hang. Fix this by adding a fixup that keeps the register
> > access always enabled.
> 
> Applied, though a bit late.  I really was hoping for one of the Lemote
> folks to chime in.

I wonder if this patch is going to the mainline kernel? I don't see it
in 3.10-rc1...

A.
