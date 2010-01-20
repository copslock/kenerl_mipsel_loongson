Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jan 2010 13:08:35 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:53588 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492335Ab0ATMI3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jan 2010 13:08:29 +0100
Received: from list by lo.gmane.org with local (Exim 4.50)
        id 1NXZMG-0000ig-E4
        for linux-mips@linux-mips.org; Wed, 20 Jan 2010 13:08:24 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 20 Jan 2010 13:08:24 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Wed, 20 Jan 2010 13:08:24 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject:  Re: [PATCH] MIPS: cleanup switches with cases that can be merged
Date:   Wed, 20 Jan 2010 11:47:29 +0000
Message-ID:  <h37j27-hgu.ln1@chipmunk.wormnet.eu>
References:  <4B56475F.8070608@gmail.com> <4B56641E.1030803@caviumnetworks.com>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Cc:     linux-kernel@vger.kernel.org
X-archive-position: 25618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 13216

In gmane.linux.ports.mips.general David Daney <ddaney@caviumnetworks.com> wrote:
>
> [snipped]
> 
> This brings us to the larger question:  This is just code churn.  Is it 
> even worthwhile?
> 
Anything which reduces the line count and remove duplication whilst 
sticking to CodingStyle I would always argue for, but "who am I" :)

It at a glance, this type of code churn, shows there are no differences 
between two classes of <whatever> and the effect is it makes the chunk 
of code a mental NOOP for the person reading the code. :)

To me this is a natural extension of running with Chapter 14 of 
CodingStyle where you kmalloc using 'sizeof(*p)' rather than 
'sizeof(struct *foo)' so reducing the chance of errors later on.

Just my thoughts.

Cheers

-- 
Alexander Clouter
.sigmonster says: Snoopy: No problem is so big that it can't be run away from.
