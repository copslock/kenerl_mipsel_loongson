Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2014 14:15:08 +0200 (CEST)
Received: from plane.gmane.org ([80.91.229.3]:57267 "EHLO plane.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6821191AbaDJMPGcCzUF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Apr 2014 14:15:06 +0200
Received: from list by plane.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1WYDsl-00027Q-DH
        for linux-mips@linux-mips.org; Thu, 10 Apr 2014 14:15:03 +0200
Received: from V10K1.bull.fr ([129.184.84.11])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 10 Apr 2014 14:15:03 +0200
Received: from miod by V10K1.bull.fr with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Thu, 10 Apr 2014 14:15:03 +0200
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Miod Vallat <miod@online.fr>
Subject: Re: arch/mips/sgi-ip22/Platform:29: *** gcc doesn't support needed option -mr10k-cache-barrier=store.  Stop.
Date:   Thu, 10 Apr 2014 12:10:41 +0000 (UTC)
Message-ID: <loom.20140410T140715-346@post.gmane.org>
References: <534138d9.RISUZQYUMS8U8s42%fengguang.wu@intel.com> <20140409051929.GA29246@localhost> <20140409082445.GC1438@pax.zz.de> <20140409133229.GA22315@alpha.franken.de> <20140409231345.GC8370@localhost> <5345DB6A.7060004@gentoo.org> <20140410003806.GV17197@linux-mips.org> <534609B2.5070808@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: sea.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 129.184.84.11 (Mozilla/5.0 (Windows NT 5.1; rv:28.0) Gecko/20100101 Firefox/28.0)
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miod@online.fr
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

> Odd, I thought R10K systems were locked to booting 64-bit kernels only.  At
> least the Octane was when it was bootable.  Not sure about IP27.

The Octane needs a 64-bit ARCS and kernel only because none of its
physical memory is addressable with KSEG0/KSEG1.

> >> IP26 (R8000) is not supported in Linux.  I think OpenBSD got it
working, though.

For some very limited value of working (it boots single-user but does not
last long due to page table corruption).

Miod
