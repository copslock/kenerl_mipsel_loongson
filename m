Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jan 2010 19:36:26 +0100 (CET)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:56177 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493421Ab0AZSgU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 26 Jan 2010 19:36:20 +0100
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: ApoEAGvFXkurRN+J/2dsb2JhbADDWJcihDkE
X-IronPort-AV: E=Sophos;i="4.49,347,1262563200"; 
   d="scan'208";a="140289602"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-5.cisco.com with ESMTP; 26 Jan 2010 18:36:06 +0000
Received: from dvomlehn-lnx2.corp.sa.net ([64.101.20.155])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id o0QIa67t022355;
        Tue, 26 Jan 2010 18:36:06 GMT
Date:   Tue, 26 Jan 2010 10:36:06 -0800
From:   David VomLehn <dvomlehn@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] powertv: Fix support for timer interrupts when using
        >64 external IRQs
Message-ID: <20100126183606.GA9784@dvomlehn-lnx2.corp.sa.net>
References: <20091222014922.GA30164@dvomlehn-lnx2.corp.sa.net> <20100126142614.GC17849@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100126142614.GC17849@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 25686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16861

On Tue, Jan 26, 2010 at 08:26:14AM -0600, Ralf Baechle wrote:
> On Mon, Dec 21, 2009 at 05:49:22PM -0800, David VomLehn wrote:
> 
> > The MIPS processor is limited to 64 external interrupt sources. Using a
> > greater number without IRQ sharing requires reading platform-specific
> > registers. On such platforms, reading the IntCtl register to determine
> > which interrupt corresponds to a timer interrupt will not work.
> > 
> > On MIPSR2 systems there is a solution--the TI bit in the Cause register,
> > specifically indicates that a timer interrupt has occured. This patch
> > uses that bit to detect interrupts for MIPSR2 processors, which may be
> > expected to work regardless of how the timer interrupt may be routed
> > in the hardware.
> 
> I think this isn't relevant for any currently in-tree supported platforms (?)
> so I've queued this for 2.6.34.
> 
> Thanks,
> 
>   Ralf

It's required for the PowerTV platform, but the release that includes it
is at your discretion.
-- 
David VL
