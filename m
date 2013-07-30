Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jul 2013 18:16:35 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:59885 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6817904Ab3G3QQczZEpn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 30 Jul 2013 18:16:32 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r6UGGWsA006284;
        Tue, 30 Jul 2013 18:16:32 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r6UGGWnF006283;
        Tue, 30 Jul 2013 18:16:32 +0200
Date:   Tue, 30 Jul 2013 18:16:32 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: uapi/asm/siginfo.h: Fix GCC 4.1.2 compilation
Message-ID: <20130730161631.GB6010@linux-mips.org>
References: <alpine.LFD.2.03.1307282107060.9486@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1307282107060.9486@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37404
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

On Sun, Jul 28, 2013 at 09:20:25PM +0100, Maciej W. Rozycki wrote:

>  It wasn't until GCC 4.3 I believe that the __SIZEOF_*__ predefined macros 
> were added.  The change below switches <uapi/asm/siginfo.h> to the 
> _MIPS_SZLONG macro so that compilation with e.g. GCC 4.1.2 succeeds.  
> This is a user API header so I think this is even more important, for 
> older userland support.  The change adds an unsuccessful default too, to 
> catch any compiler configuration oddities.
> 
> Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>

Thanks, applied.

  Ralf
