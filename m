Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jun 2010 06:48:32 +0200 (CEST)
Received: from pfepb.post.tele.dk ([195.41.46.236]:54485 "EHLO
        pfepb.post.tele.dk" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492533Ab0FBEs2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jun 2010 06:48:28 +0200
Received: from merkur.ravnborg.org (x1-6-00-1e-2a-84-ae-3e.k225.webspeed.dk [80.163.61.94])
        by pfepb.post.tele.dk (Postfix) with ESMTP id 89C66F84011;
        Wed,  2 Jun 2010 06:48:27 +0200 (CEST)
Date:   Wed, 2 Jun 2010 06:48:27 +0200
From:   Sam Ravnborg <sam@ravnborg.org>
To:     wu zhangjin <wuzhangjin@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Alexander Clouter <alex@digriz.org.uk>,
        Manuel Lauss <manuel.lauss@gmail.com>
Subject: Re: [PATCH v3] MIPS: Clean up the calculation of
        VMLINUZ_LOAD_ADDRESS
Message-ID: <20100602044827.GA6295@merkur.ravnborg.org>
References: <616317d6d889537d03c3c0860231da9a2cce0b69.1275372093.git.wuzhangjin@gmail.com> <20100601152750.GA5131@merkur.ravnborg.org> <AANLkTikR8qY2NwurQ76R1F-AQ4QcmmqXvoWtlOqCB5Ou@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikR8qY2NwurQ76R1F-AQ4QcmmqXvoWtlOqCB5Ou@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-archive-position: 26982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 980

> >
> > Note: The load_addr local variable _must_ use "=" asignment
> 
> This is the _key_ stuff. I  tried to use VMLINUZ_LOAD_ADDR(like your
> load_addr) as the load address, but failed all the time, seems I used
> the ":=" assignment, now with "=", it works, thanks!

:= evaluate at once. So the right hand side is executed when Make see the line.
= do late evaluation, so the right hand side is executed/evaluated when
required.

In your case you need the late version because calc_vmlinux_load_Addr needs
to be built before you do the evaluation.

	Sam
