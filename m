Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Dec 2016 18:23:05 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3154 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992123AbcLERW6o0rz0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 5 Dec 2016 18:22:58 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1C1AAB936B7F3;
        Mon,  5 Dec 2016 17:22:49 +0000 (GMT)
Received: from [10.20.78.176] (10.20.78.176) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Mon, 5 Dec 2016
 17:22:51 +0000
Date:   Mon, 5 Dec 2016 17:22:41 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matt Redfearn <matt.redfearn@imgtec.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH 3/5] MIPS: Only change $28 to thread_info if coming from
 user mode
In-Reply-To: <9579f0c6-9f67-cf1d-94c1-34d14f38afd6@imgtec.com>
Message-ID: <alpine.DEB.2.00.1612051705280.6743@tp.orcam.me.uk>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com> <1480685957-18809-4-git-send-email-matt.redfearn@imgtec.com> <alpine.DEB.2.00.1612051605590.6743@tp.orcam.me.uk> <9579f0c6-9f67-cf1d-94c1-34d14f38afd6@imgtec.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.176]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55945
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

On Mon, 5 Dec 2016, Matt Redfearn wrote:

> Ah yes, I missed the .set reorder above the EVA ifdef and just included the
> .set reorder as the similar snippet here:
> http://lxr.free-electrons.com/source/arch/mips/include/asm/stackframe.h#L149

 That's a global `.set reorder' for the whole of SAVE_SOME, just as I 
suggested for all the macros here.

 Then a temporary `.set noreorder' override follows just for the manually 
scheduled BLTZ/MOVE sequence, where someone has later inserted a whole 
CONFIG_EVA block.  As I noted this temporary override is unnecessary.  
Incidentally it does not harm the CONFIG_EVA block either, because EVA 
processors have MFC0 interlocked.

 NB I think the MFC0 macro ought to be called REG_MFC0, to avoid confusion 
and for consistency with the rest of such macros.

  Maciej
