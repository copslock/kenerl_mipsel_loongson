Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Oct 2016 12:56:13 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:30469 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992121AbcJYK4GpRej5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Oct 2016 12:56:06 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 6CEFBE571FC26;
        Tue, 25 Oct 2016 11:55:57 +0100 (IST)
Received: from [10.20.78.214] (10.20.78.214) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Tue, 25 Oct 2016
 11:55:59 +0100
Date:   Tue, 25 Oct 2016 11:55:49 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <devicetree@vger.kernel.org>, Stephan Linz <linz@li-pro.net>,
        Jacek Anaszewski <j.anaszewski@samsung.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        <linux-kernel@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 11/14] MIPS: Malta: Use syscon-reboot driver to
 reboot
In-Reply-To: <2861325.0K2k6plxiD@np-p-burton>
Message-ID: <alpine.DEB.2.00.1610251003330.31859@tp.orcam.me.uk>
References: <20160919212132.28893-1-paul.burton@imgtec.com> <20160919212132.28893-12-paul.burton@imgtec.com> <alpine.DEB.2.00.1610220956020.31859@tp.orcam.me.uk> <2861325.0K2k6plxiD@np-p-burton>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.214]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Hi Paul,

> >  This has broken reboot support, all I get now is:
> > 
> > reboot: Restarting system
> > Unable to restart system
> > Reboot failed -- System halted
> > 
> > at which point I need to issue a serial BREAK to regain control of the
> > board and get back to YAMON; fortunately the board is wired for that.
> 
> This was already reported over here:
> 
> https://www.linux-mips.org/archives/linux-mips/2016-10/msg00120.html 
> 
> These 2 patches fix it:
> 
> https://patchwork.linux-mips.org/patch/14395/ 
> https://patchwork.linux-mips.org/patch/14396/ 

 Thanks, good to know and sorry to raise a late alarm then.

 As it happens the board I've been fiddling with has been temporarily 
sitting idle, so I went ahead and verified that these changes have indeed 
removed the regression in my configuration.  So you've got a confirmation 
from a real Malta hardware user now too (QEMU may have its own quirks).

> I've asked Ralf if we can get those, along with a few others, in ASAP - 
> preferrably for -rc3.

 As these are fixes to a functional regression I also recommend merging 
them ASAP.

  Maciej
