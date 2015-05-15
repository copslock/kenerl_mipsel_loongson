Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 20:03:54 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:37687 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27025344AbbEOSDwzIk5M (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 15 May 2015 20:03:52 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t4FI3psd006923;
        Fri, 15 May 2015 20:03:51 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t4FI3pwn006922;
        Fri, 15 May 2015 20:03:51 +0200
Date:   Fri, 15 May 2015 20:03:51 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] MIPS: malta-time: Don't switch RTC to BCD mode
Message-ID: <20150515180351.GE2322@linux-mips.org>
References: <1431519473-24049-1-git-send-email-james.hogan@imgtec.com>
 <1431519473-24049-2-git-send-email-james.hogan@imgtec.com>
 <alpine.LFD.2.11.1505131829580.1538@eddie.linux-mips.org>
 <20150513221956.GE7723@jhogan-linux.le.imgtec.org>
 <20150514084130.GE22815@NP-P-BURTON>
 <55547238.1040005@imgtec.com>
 <alpine.LFD.2.11.1505141122380.19904@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1505141122380.19904@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47412
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

On Thu, May 14, 2015 at 11:53:22AM +0100, Maciej W. Rozycki wrote:

> > > The reason for init_rtc was touched upon in the commit message for
> > > a87ea88d8f6c (MIPS: Malta: initialise the RTC at boot) but could perhaps
> > > have been clearer. Straight out of reset the RTC may not be running at
> > > all, but the code in estimate_frequencies (note: not the RTC driver)
> > > relies upon the RTC having been started. This was an issue when using
> > > earlier builds of U-boot which didn't touch the RTC at all, and is still
> > > an issue if you do something like load the kernel via a JTAG probe
> > > rather than using U-boot or YAMON. If the kernel doesn't ensure the RTC
> > > is started then it'll just hang in estimate_frequencies waiting for the
> > > UIP bit to change even though it never will. YAMON isn't the only way to
> > > boot on Malta, and dependencies such as this between the kernel & the
> > > bootloader should really be minimised.
> 
>  You do need to take reverse dependencies into account though, such as 
> this one where YAMON relies upon a certain state of hardware (that it 
> does initialise) to function correctly.  Granted, this RTC issue is 
> probably the only one as other hardware on the Malta board does not 
> carry initialised state over reset I believe.
> 
> > > ...and since it seems the U-boot & YAMON RTC drivers use it in different
> > > modes, I'd consider this patch reasonable. Feel free to have my:
> > > 
> > >   Reviewed-by: Paul Burton <paul.burton@imgtec.com>
> > 
> > Thanks Paul,
> > 
> > Assuming Maciej is satisfied I'll rewrite the commit message, add a
> > stable tag, and resend.
> 
>  I'd prefer RTC state not to be touched at all if its state is sane.  
> That is read Register B, check for the only valid divider setting 
> (32kHz), and if so then exit right away, and otherwise initialise the 
> chip from scratch.  Consistency with YAMON might be a good idea in that 
> initialisation, but I have no strong feeling towards that.  If you think 
> there's value in having the chip set to the BCD mode, then feel free to 
> keep that option.
> 
>  Note that any inhibition of the RTC previously initialised by 
> temporarily setting the SET bit in Register B during bootstrap will 
> disturb timekeeping that the system may carry over reset using 
> adjtimex(8).

So you're instead suggesting to revoke a87ea88d8f6c ?

If YAMON and U-Boot are differing in RTC handling then I suggest to
treat that as a U-Boot bug.  YAMON was there first.  However these
Malta kernels are also frequently booted without firmware in Qemu.
No idea how Qemu initializes the RTC.

  Ralf
