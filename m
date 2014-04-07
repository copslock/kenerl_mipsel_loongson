Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 18:29:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51460 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822088AbaDGQ3CPNGeH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 Apr 2014 18:29:02 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s37GSwIY009330;
        Mon, 7 Apr 2014 18:28:58 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s37GSvMD009329;
        Mon, 7 Apr 2014 18:28:57 +0200
Date:   Mon, 7 Apr 2014 18:28:57 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [RFC PATCH v4 2/2] MIPS: make FPU emulator optional
Message-ID: <20140407162857.GQ17197@linux-mips.org>
References: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
 <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com>
 <20140407135315.GX14803@pburton-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140407135315.GX14803@pburton-linux.le.imgtec.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39681
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Mon, Apr 07, 2014 at 02:53:15PM +0100, Paul Burton wrote:

> On Mon, Apr 07, 2014 at 12:57:04PM +0200, Manuel Lauss wrote:
> > This small patch makes the MIPS FPU emulator optional. The kernel
> > kills float-users on systems without a hardware FPU by sending a SIGILL.
> 
> One issue with this is that if someone runs a kernel with the FPU
> emulator disabled on hardware that has an FPU, they're likely to hit
> seemingly odd behaviour where FP works just fine until they hit a
> condition the hardware doesn't support. To make it clear that using FP
> without the emulator is a bad idea, perhaps it would be safer to disable
> FP entirely rather than only the emulator? Then userland can die the
> first time it uses FP instead of when it happens to operate on a
> denormal.
> 
> Unless there are FPUs which never generate an unimplemented operation
> exception, in which case perhaps more Kconfig is needed to identify such
> systems & allow the emulator to be disabled for those only.

The original reason for me to remove the FPU emulator option was that I
was getting flooded by bogus bug reports because users thought they could
remove the FPU emulator with a hardware FPU present.

Another pain point is that soft-FPU establishes another ABI variant so
I'd not mind to see soft-FPU go.

Some of the tradeoffs involved were a bit bogus at times.  Soft-fp
application code can be much bigger than hard-fp - to the point where the
50k or so for the kernel FP software are a good investment.

But I don't mind making the FPU emulator selectable again - but this
time with nasty kernel messages and killing of processes that happen to
dare to execute a FPU instruction.

  Ralf
