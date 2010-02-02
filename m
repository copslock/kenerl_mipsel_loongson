Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Feb 2010 14:46:03 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56936 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492247Ab0BBNp7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 2 Feb 2010 14:45:59 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o12DkEXR015076;
        Tue, 2 Feb 2010 14:46:14 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o12DkECX015074;
        Tue, 2 Feb 2010 14:46:14 +0100
Date:   Tue, 2 Feb 2010 14:46:13 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
Cc:     Guenter Roeck <guenter.roeck@ericsson.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH v5] Virtual memory size detection for 64 bit MIPS CPUs
Message-ID: <20100202134613.GD13987@linux-mips.org>
References: <1265107061-18355-1-git-send-email-guenter.roeck@ericsson.com>
 <20100202130153.GB10837@linux-mips.org>
 <90edad821002020505x6ecfd03ejb03f316d9859b9db@mail.gmail.com>
 <20100202131015.GB13987@linux-mips.org>
 <90edad821002020534s54c4120atb7ac183f39d44847@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90edad821002020534s54c4120atb7ac183f39d44847@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 02, 2010 at 03:34:31PM +0200, Dmitri Vorobiev wrote:

> >> I haven't been following this closely enough, so maybe my question is
> >> stupid. However: will this work on SGI R5000? I'm using an Indy, so
> >> I'm quite concerned about this CPU.
> >
> > The point is that your Indy right now is not working with a 64-bit kernel :)
> 
> I know. :)
> 
> What I was asking about was whether my Indy is going to work with the
> new scheme of calculating VMALLOC_END.

Of course it will.

  Ralf
