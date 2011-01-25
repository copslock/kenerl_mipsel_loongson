Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Jan 2011 14:37:12 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56084 "EHLO
        duck.linux-mips.net" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491201Ab1AYNhI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Jan 2011 14:37:08 +0100
Received: from duck.linux-mips.net (duck [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.4) with ESMTP id p0PDafL7026053;
        Tue, 25 Jan 2011 14:36:41 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p0PDaeRB026051;
        Tue, 25 Jan 2011 14:36:40 +0100
Date:   Tue, 25 Jan 2011 14:36:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Ray Will <hustos@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-mm@vger.kernel.org
Subject: Re: merge two insts into one in a time sensitive routing
Message-ID: <20110125133640.GB25526@linux-mips.org>
References: <AANLkTikSRmSpU+8FXOnqQ8Xm=ms=SZdrj=7WN3SLPVuJ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikSRmSpU+8FXOnqQ8Xm=ms=SZdrj=7WN3SLPVuJ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@localhost.localdomain>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29083
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jan 25, 2011 at 05:04:01PM +0800, Ray Will wrote:

> The following two lines should be merged into one inst. It is the tlb
> refill handler, quite time sensitive.
> 569         uasm_i_lui(p, tmp, PM_HUGE_MASK >> 16);
> 570         uasm_i_ori(p, tmp, tmp, PM_HUGE_MASK & 0xffff);
> 
> Merged to
>  uasm_i_lui(p, tmp, ((PM_HUGE_MASK & 0xffff) | (PM_HUGE_MASK >> 16));

With 4K pages (=> 1M huge pages) we'd want the value 0x001fe000 to be
loaded.  Your change results in in a LUI $tmp, 0xe01f instruction being
generated and that's an illegal value for the c0_pagemask register so
the operation is now architecturally undefined.  Similar for other
page sizes.

All possible values for PM_HUGE_MASK will have bits set in the upper and
lower 16 halves of the register so there will always two instructions be
required to load the pagemask value.

  Ralf
