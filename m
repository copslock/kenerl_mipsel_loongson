Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Mar 2010 17:09:04 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:53087 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492188Ab0CCQI5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Mar 2010 17:08:57 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1Nmr81-0006jF-4S
        for linux-mips@linux-mips.org; Wed, 03 Mar 2010 17:08:53 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 03 Mar 2010 17:08:53 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 03 Mar 2010 17:08:53 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: Re: TI AR7 7200 - no boot
Date:   Wed, 3 Mar 2010 15:54:39 +0000
Message-ID: <vad267-9it.ln1@chipmunk.wormnet.eu>
References: <27766331.post@talk.nabble.com> <27766728.post@talk.nabble.com> <27767861.post@talk.nabble.com> <201003031404.53039.florian@openwrt.org>
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26109
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Florian Fainelli <florian@openwrt.org> wrote:
>
> On Wednesday 03 March 2010 13:58:48 Dea_RU wrote:
>> 
>> If delete my debug printk-s kernel stop after first console output
>> "Calibrating delay loop... "
>> 
>> I do not MIPS arch interput specific ..... Can be MIPS need init internel
>> timer and link overflow flag to interput ??
> 
> All handlers are not correctly setup, so you should include this patch in your 
> tree:
> 
> http://www.linux-mips.org/archives/linux-mips/2010-01/msg00019.html
> 
If I could slip in with some shameless self advertising:

http://www.digriz.org.uk/wag54g

Same(ish) chipset, the 'Creating Firmwares' section should interest you 
and get you started on your buildroot journey.

Cheers

-- 
Alexander Clouter
.sigmonster says: guru, n:
                  	A computer owner who can read the manual.
