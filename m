Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 May 2015 20:14:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44556 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012525AbbEOSOT3Ue7F (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 May 2015 20:14:19 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 0D0D7E0FE4AD1;
        Fri, 15 May 2015 19:14:13 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 15 May 2015 19:14:15 +0100
Received: from localhost (192.168.159.126) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 15 May
 2015 19:14:15 +0100
Date:   Fri, 15 May 2015 19:14:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: malta-time: Don't switch RTC to BCD mode
Message-ID: <20150515181413.GA30774@NP-P-BURTON>
References: <1431519473-24049-1-git-send-email-james.hogan@imgtec.com>
 <1431519473-24049-2-git-send-email-james.hogan@imgtec.com>
 <alpine.LFD.2.11.1505131829580.1538@eddie.linux-mips.org>
 <20150513221956.GE7723@jhogan-linux.le.imgtec.org>
 <20150514084130.GE22815@NP-P-BURTON>
 <55547238.1040005@imgtec.com>
 <alpine.LFD.2.11.1505141122380.19904@eddie.linux-mips.org>
 <20150515180351.GE2322@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20150515180351.GE2322@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.159.126]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47413
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Fri, May 15, 2015 at 08:03:51PM +0200, Ralf Baechle wrote:
> >  I'd prefer RTC state not to be touched at all if its state is sane.  
> > That is read Register B, check for the only valid divider setting 
> > (32kHz), and if so then exit right away, and otherwise initialise the 
> > chip from scratch.  Consistency with YAMON might be a good idea in that 
> > initialisation, but I have no strong feeling towards that.  If you think 
> > there's value in having the chip set to the BCD mode, then feel free to 
> > keep that option.
> > 
> >  Note that any inhibition of the RTC previously initialised by 
> > temporarily setting the SET bit in Register B during bootstrap will 
> > disturb timekeeping that the system may carry over reset using 
> > adjtimex(8).
> 
> So you're instead suggesting to revoke a87ea88d8f6c ?
> 
> If YAMON and U-Boot are differing in RTC handling then I suggest to
> treat that as a U-Boot bug. YAMON was there first.

That would be fair enough, and is why I added RTC handling to Malta
U-boot at all. I could see logic in suggesting U-boot be changed to use
the binary mode instead of BCD. But...

> However these Malta kernels are also frequently booted without firmware
> in Qemu. No idea how Qemu initializes the RTC.

...kernels can also be booted on real Malta boards with minimal prodding
over JTAG, and the RTC is one more thing that you need to prod if the
kernel doesn't ensure it's running. That's what motivated a87ea88d8f6c
and the other patches from the same series at all.

Thanks,
    Paul
