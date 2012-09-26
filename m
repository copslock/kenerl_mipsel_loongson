Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2012 23:09:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:58261 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1903846Ab2IZVJs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Sep 2012 23:09:48 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id q8QL9jIl019834;
        Wed, 26 Sep 2012 23:09:45 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id q8QL9h1x019830;
        Wed, 26 Sep 2012 23:09:43 +0200
Date:   Wed, 26 Sep 2012 23:09:43 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-mips@linux-mips.org, linux-next@vger.kernel.org
Subject: Re: [PATCH -next] MIPS: ptrace: Add missing #include <asm/syscall.h>
Message-ID: <20120926210943.GA4745@linux-mips.org>
References: <1347913216-11140-1-git-send-email-geert@linux-m68k.org>
 <20120923173609.GE13842@linux-mips.org>
 <5060A52C.1050504@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5060A52C.1050504@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34553
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Sep 24, 2012 at 11:23:40AM -0700, David Daney wrote:

> >Thanks, I already had fixed that in the linux-trace tree; the latest
> >version just had not yet propagated yet to the other trees.
> >
> 
> It is still not on mips-for-linux-next.  Perhaps we should arrange
> for it to be there, so that the actual propagation may commence.

Seems my fix one branch, push the other strategy didn't work so well ;-)

Fixed, sorry.

  Ralf
