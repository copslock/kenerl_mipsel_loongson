Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 22:08:37 +0100 (CET)
Received: from lo.gmane.org ([80.91.229.12]:50258 "EHLO lo.gmane.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491886Ab0BAVId (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 22:08:33 +0100
Received: from list by lo.gmane.org with local (Exim 4.69)
        (envelope-from <sgi-linux-mips@m.gmane.org>)
        id 1Nc3VR-0001dP-QF
        for linux-mips@linux-mips.org; Mon, 01 Feb 2010 22:08:25 +0100
Received: from chipmunk.wormnet.eu ([195.195.131.226])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Mon, 01 Feb 2010 22:08:25 +0100
Received: from alex by chipmunk.wormnet.eu with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Mon, 01 Feb 2010 22:08:25 +0100
X-Injected-Via-Gmane: http://gmane.org/
To:     linux-mips@linux-mips.org
From:   Alexander Clouter <alex@digriz.org.uk>
Subject: Re: [PATCH 3/3] MIPS: AR7 make ar7_register_devices much more durable
Date:   Mon, 1 Feb 2010 20:15:22 +0000
Message-ID: <qbpj37-cao.ln1@chipmunk.wormnet.eu>
References: <dt2h37-ch6.ln1@chipmunk.wormnet.eu> <20100201190159.GC9806@linux-mips.org>
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: chipmunk.wormnet.eu
User-Agent: tin/1.9.3-20080506 ("Dalintober") (UNIX) (Linux/2.6.26-2-sparc64-smp (sparc64))
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25824
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@digriz.org.uk
Precedence: bulk
X-list: linux-mips

Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Sun, Jan 31, 2010 at 07:39:57PM +0000, Alexander Clouter wrote:
> 
>> MIPS: AR7 make ar7_register_devices much more durable
> 
> patches/0070-03.patch:85: space before tab in indent.
>        }
> patches/0070-03.patch:192: space before tab in indent.
>        iounmap(bootcr);
> patches/0070-03.patch:208: space before tab in indent.
>                res = platform_device_register(&ar7_wdt);
> error: patch failed: arch/mips/ar7/platform.c:529
> error: arch/mips/ar7/platform.c: patch does not apply
> 
> Grrr :-)
> 
My grovelling apologies, I do normally worship at the altar of 
checkpatch.pl however my faith was recently shattered by the acceptance 
for lines longer than 80 chars...

> I've fixed that up, also the pr_xxx changes suggested by Wu.  Queued
> for 2.6.34.
> 
I have some other code for you to rewrite if you are willing?

All this manual fixing up does makeme ponder if you are trying to avoid 
doing something else you should be doing though :)

Sorry again and also my thanks

-- 
Alexander Clouter
.sigmonster says: YOW!!  The land of the rising SONY!!
