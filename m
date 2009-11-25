Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2009 16:18:24 +0100 (CET)
Received: from mail1.pearl-online.net ([62.159.194.147]:6065 "EHLO
        mail1.pearl-online.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492922AbZKYPSV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2009 16:18:21 +0100
Received: from Mobile0.Peter (85.233.43.202.dynamic.cablesurf.de [85.233.43.202])
        by mail1.pearl-online.net (Postfix) with ESMTP id B3496D1F1;
        Wed, 25 Nov 2009 16:18:16 +0100 (CET)
Received: from Opal.Peter (Opal.Peter [192.168.1.1])
        by Mobile0.Peter (8.12.6/8.12.6/Sendmail/Linux 2.2.13) with ESMTP id nAPGMJUZ001181;
        Wed, 25 Nov 2009 16:22:20 GMT
Received: from Opal.Peter (localhost [127.0.0.1])
        by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Sendmail/Linux 2.4.24-1-386) with ESMTP id nAPFIfnh001209;
        Wed, 25 Nov 2009 16:18:41 +0100
Received: from localhost (pf@localhost)
        by Opal.Peter (8.12.11.Beta0/8.12.11.Beta0/Debian-1) with ESMTP id nAPFIeuI001205;
        Wed, 25 Nov 2009 16:18:41 +0100
X-Authentication-Warning: Opal.Peter: pf owned process doing -bs
Date:   Wed, 25 Nov 2009 16:18:40 +0100 (CET)
From:   peter fuerst <post@pfrst.de>
X-Sender: pf@Opal.Peter
To:     Arnaud Patard <arnaud.patard@rtp-net.org>
Cc:     Florian Lohoff <flo@rfc822.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org
Subject: Re: Syncing CPU caches from userland on MIPS
In-Reply-To: <87ljhuacen.fsf@lechat.rtp-net.org>
Message-ID: <Pine.LNX.4.21.0911251607530.1196-100000@Opal.Peter>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <post@pfrst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25129
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: post@pfrst.de
Precedence: bulk
X-list: linux-mips


Hi Arnaud,

this is an age-old "feature", still resistent to all the patches, which
tried to change it since ;-)

from MIPS git-head:

SYSCALL_DEFINE3(cacheflush, unsigned long, addr, unsigned long, bytes,
        unsigned int, cache)
{
	if (bytes == 0)
		return 0;
	if (!access_ok(VERIFY_WRITE, (void __user *) addr, bytes))
		return -EFAULT;

	flush_icache_range(addr, addr + bytes);

	return 0;
}

DCACHE as well as BCACHE are silently taken as ICACHE (You have to fix
your local copy of the kernel source, and you are not alone with this 
problem: anyone who wants to run the Xserver on IP28 has to do)


kind regards

peter


On Wed, 25 Nov 2009, Arnaud Patard wrote:

> Date: Wed, 25 Nov 2009 15:48:16 +0100
> From: Arnaud Patard <arnaud.patard@rtp-net.org>
> To: Florian Lohoff <flo@rfc822.org>
> Cc: Aurelien Jarno <aurelien@aurel32.net>, linux-mips@linux-mips.org
> Subject: Re: Syncing CPU caches from userland on MIPS
> 
> Florian Lohoff <flo@rfc822.org> writes:
> 
> > On Wed, Nov 25, 2009 at 03:39:01PM +0100, Arnaud Patard wrote:
> >> > Would this only evict stuff from the ICACHE? When trying to execute
> >> > a just written buffer and with a writeback DCACHE you would need to 
> >> > explicitly writeback the DCACHE to memory and invalidate the ICACHE.
> >> 
> >> we already though about using BCACHE instead of ICACHE only but it
> >> didn't make any difference. the bug is still there.
> >
> > My understanding is you need both ...
> >
> > FLUSH/WRITEBACK the dcache and INVALIDATE the icache - the icache needs
> > to load the data which is in the dcache via memory.
> 
> I undertstood that using BCACHE would be better but still, it doesn't
> solve our issue. Can we please go ahead ? :)
> 
> Arnaud
> 
> 
