Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2016 16:15:43 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27011347AbcATPPkHFEUS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 20 Jan 2016 16:15:40 +0100
Date:   Wed, 20 Jan 2016 15:15:40 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Aurelien Jarno <aurelien@aurel32.net>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH 37/48] MIPS: math-emu: Correct delay-slot exception
 propagation
In-Reply-To: <20160120105028.GA27361@aurel32.net>
Message-ID: <alpine.LFD.2.20.1601201512200.7055@eddie.linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org> <alpine.LFD.2.11.1504031834270.21028@eddie.linux-mips.org> <20160120105028.GA27361@aurel32.net>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

Hi Aurelien,

> On 2015-04-03 23:26, Maciej W. Rozycki wrote:
> > Restore EPC at the branch whose delay slot is emulated if the delay-slot 
> > instruction signals.  This is so that code in `fpu_emulator_cop1Handler' 
> > does not see EPC having advanced and mistakenly successfully resume 
> > userland execution from the location at the branch target in that case.
> > Restoring EPC guarantees an immediate exit from the emulation loop and 
> > if EPC hasn't advanced at all since entering the loop, also issuing the 
> > signal reported by the delay-slot instruction.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> > ---
> 
> Unfortunately this patch broke the case where the delay slot contains a
> NOP instruction. In practice this causes a lot of code to now fails with
> a SIGILL. For example the following code, extracted from R, reports a
> SIGILL address 0x76f29670.
> 
> => 0x76f29670:  ldc1    $f2,40(s8)
>    0x76f29674:  ldc1    $f0,40(s8)
>    0x76f29678:  add.d   $f0,$f2,$f0
>    0x76f2967c:  sdc1    $f0,40(s8)
>    0x76f29680:  ldc1    $f2,40(s8)
>    0x76f29684:  ldc1    $f0,80(s8)
>    0x76f29688:  add.d   $f0,$f2,$f0
>    0x76f2968c:  sdc1    $f0,96(s8)
>    0x76f29690:  ldc1    $f2,96(s8)
>    0x76f29694:  ldc1    $f0,40(s8)
>    0x76f29698:  sub.d   $f0,$f2,$f0
>    0x76f2969c:  sdc1    $f0,112(s8)
>    0x76f296a0:  ldc1    $f2,112(s8)
>    0x76f296a4:  ldc1    $f0,80(s8)
>    0x76f296a8:  sub.d   $f2,$f2,$f0
>    0x76f296ac:  ldc1    $f0,144(s8)
>    0x76f296b0:  c.eq.d  $f2,$f0
>    0x76f296b4:  bc1t    0x76f29670
>    0x76f296b8:  nop

 Thanks for your report, I'll have a look ASAP.

  Maciej
