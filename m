Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Feb 2010 18:45:17 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:38363 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492448Ab0BARpL (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 1 Feb 2010 18:45:11 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o11HjENO018072;
        Mon, 1 Feb 2010 18:45:15 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o11HjDEK018070;
        Mon, 1 Feb 2010 18:45:13 +0100
Date:   Mon, 1 Feb 2010 18:45:12 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: AR7 whitespace hacking
Message-ID: <20100201174512.GA9806@linux-mips.org>
References: <bq2h37-ch6.ln1@chipmunk.wormnet.eu>
 <1265005758.31984.8.camel@falcon>
 <1hli37-4t9.ln1@chipmunk.wormnet.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1hli37-4t9.ln1@chipmunk.wormnet.eu>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 01, 2010 at 10:03:45AM +0000, Alexander Clouter wrote:
> From: Alexander Clouter <alex@digriz.org.uk>
> Date:   Mon, 1 Feb 2010 10:03:45 +0000
> To: linux-mips@linux-mips.org
> Subject: Re: [PATCH 1/3] MIPS: AR7 whitespace hacking
> 
> Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> >
> >> +/*****************************************************************************
> >> + * VLYNQ Bus
> >> + ****************************************************************************/
> > 
> > Why not simply use:
> > 
> > /* VLYNQ Bus */
> > 
> > You have deleted lots of whitespaces, but added more *.
> >
> "good enough for ARM[1]" :)
> 
> Compromise on this instead?
> ----
> /*
>  * VLYNQ Bus
>  */
> ---- 

Just did this one myself.

The patch also had a reject on the lest segment of arch/mips/ar7/prom.c.rej;
it seems that you've not created your patches against a recent version
of the -queue tree.  Either way, queued for 2.6.34.

  Ralf
