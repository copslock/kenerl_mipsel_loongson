Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2016 18:42:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56047 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992123AbcLERmJEmrEK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2016 18:42:09 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 37A8FE34AD11C;
        Mon,  5 Dec 2016 17:41:57 +0000 (GMT)
Received: from [10.20.78.176] (10.20.78.176) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 5 Dec 2016
 17:41:59 +0000
Date:   Mon, 5 Dec 2016 17:41:49 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Paul Burton <paul.burton@imgtec.com>
CC:     Matt Redfearn <matt.redfearn@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: Re: [PATCH 3/5] MIPS: Only change $28 to thread_info if coming from
 user mode
In-Reply-To: <40031221.jIbnRxB01Q@np-p-burton>
Message-ID: <alpine.DEB.2.00.1612051733070.6743@tp.orcam.me.uk>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com> <1480685957-18809-4-git-send-email-matt.redfearn@imgtec.com> <alpine.DEB.2.00.1612051605590.6743@tp.orcam.me.uk> <40031221.jIbnRxB01Q@np-p-burton>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.176]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55947
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

On Mon, 5 Dec 2016, Paul Burton wrote:

> Agreed we ought to use .set reorder (or rather, not use .set noreorder) 
> wherever possible but FYI one thing I've only noticed recently is that we 
> don't actually get any reordering anyway, presumably because we don't provide 
> any -O flags when building asm source. I haven't yet done the legwork or 
> figuring out whether we've ever had optimisation & if so what changed...

 Reordering or `-O2' is the default for GAS, you actually have to pass a 
different `-O*' option explicitly to GAS to disable it.  NB it's *not* the 
same as passing one of the `-O*' options to GCC, you'd need e.g. `-Wa,-O'.

 So perhaps one of our Makefiles or a particular configuration of the GCC 
driver does the wrong thing?

  Maciej
