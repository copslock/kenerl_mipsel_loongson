Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Sep 2012 10:58:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:56222 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903305Ab2IKI62 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Sep 2012 10:58:28 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8B8wREK022300;
        Tue, 11 Sep 2012 10:58:27 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8B8wRqr022299;
        Tue, 11 Sep 2012 10:58:27 +0200
Date:   Tue, 11 Sep 2012 10:58:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Rich Felker <dalias@aerifal.cx>, linux-mips@linux-mips.org
Subject: Re: Is r25 saved across syscalls?
Message-ID: <20120911085827.GF24448@linux-mips.org>
References: <20120909193008.GA15157@brightrain.aerifal.cx>
 <20120910170830.GB24448@linux-mips.org>
 <20120910172248.GN27715@brightrain.aerifal.cx>
 <alpine.LFD.2.00.1209110059580.8926@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1209110059580.8926@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34466
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Tue, Sep 11, 2012 at 01:29:52AM +0100, Maciej W. Rozycki wrote:

>  Relying on any call-clobbered registers, including $7 to be preserved 
> across a syscall is risky, to say the least, as this is not guaranteed by 
> the syscall ABI.  I do wonder however why we have these instructions to 
> save/restore $25 in SAVE_SOME/RESTORE_SOME.  This dates back to 2.4 at the 
> very least.
> 
>  Ralf, any insights?

It dates back to the initial commit in 36ea5120 from March 27, 1998 for
2.1.90 when for the sake of better lmbench syscall latency numbers I had
introduced the concept of partial saving of a register frame.  I think it
should rather have been in SAVE_TEMP/RESTORE_TEMP instead.

  Ralf
