Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 19:31:37 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51576 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27010718AbbDGRbfdLTKA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 7 Apr 2015 19:31:35 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.9/8.14.8) with ESMTP id t37HVaiR007486;
        Tue, 7 Apr 2015 19:31:36 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.9/8.14.9/Submit) id t37HVaF5007485;
        Tue, 7 Apr 2015 19:31:36 +0200
Date:   Tue, 7 Apr 2015 19:31:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 46/48] MIPS: math-emu: Make ABS.fmt and NEG.fmt
 arithmetic again
Message-ID: <20150407173136.GB27914@linux-mips.org>
References: <alpine.LFD.2.11.1504030054200.21028@eddie.linux-mips.org>
 <alpine.LFD.2.11.1504032201480.21028@eddie.linux-mips.org>
 <alpine.LFD.2.11.1504071620230.21028@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1504071620230.21028@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46811
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Tue, Apr 07, 2015 at 04:24:32PM +0100, Maciej W. Rozycki wrote:

> > Revert the damage done by the series of changes then, and take the 
> > opportunity to simplify implementation by calling `ieee754dp_sub' and 
> > `ieee754dp_add' as required and also the rounding mode set towards -Inf 
> > temporarily so that the sign of 0 is correctly handled.
> > 
> > Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
> > ---
> 
>  One point to make here is the use of `ieee754dp_sub' and `ieee754dp_add' 
> makes emulated ABS.fmt and NEG.fmt respect FCSR.FS for denormals just as 
> hardware does.  I should have noted that in the commit message, perhaps it 
> can be retrofitted?

Yes, it can.  Just send the new commit message.

  Ralf
