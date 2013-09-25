Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 13:02:34 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:48200 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817090Ab3IYLCcasMso (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Sep 2013 13:02:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8PB2VYd026364;
        Wed, 25 Sep 2013 13:02:31 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8PB2Vxr026363;
        Wed, 25 Sep 2013 13:02:31 +0200
Date:   Wed, 25 Sep 2013 13:02:31 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Tell R4k SC and MC variations apart
Message-ID: <20130925110231.GM31185@linux-mips.org>
References: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org>
 <20130924084845.GA21257@linux-mips.org>
 <alpine.LFD.2.03.1309250019490.17450@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309250019490.17450@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37970
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

On Wed, Sep 25, 2013 at 12:37:42AM +0100, Maciej W. Rozycki wrote:

> > My reservations may have been about userland reading /proc/cpuinfo and
> > looking at the CPU type.  Some software may know how to handle the
> > PC/SC variants but not the MC versions.  But this seems to be a fairly
> > weak concern - and I trust you checked gcc's parsing of /proc/cpuinfo.
> 
>  Actually I wasn't actually aware GCC's got /proc/cpuinfo-based native 
> arch support for the MIPS target these days, thanks for the hint.
> 
>  I have now checked the relevant source file and support is pretty weak 
> there, only half a dozen processors are recognised and no R4k model is 
> among them.  In any case strstr is used to check for matches there so I'd 
> expect strings like "R4000" or "R4400" without a further suffix to be 
> chosen.

It'd be worth a change in particular for users how higher end CPUs and
enhanced ISAs such as Octeons.

Or should we just default to O32 w/ MIPS I + LL/SC as the MIPS Esperanto
forever ...

  Ralf
