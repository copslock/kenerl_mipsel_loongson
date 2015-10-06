Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Oct 2015 13:29:43 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46177 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009648AbbJFL3lFLnDb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Oct 2015 13:29:41 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id t96BTewf026374;
        Tue, 6 Oct 2015 13:29:40 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id t96BTd5Y026373;
        Tue, 6 Oct 2015 13:29:39 +0200
Date:   Tue, 6 Oct 2015 13:29:39 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Thierry Reding <thierry.reding@gmail.com>
Cc:     Alban <albeu@free.fr>, Lars-Peter Clausen <lars@metafoo.de>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: jz4740: Add missing gpio.h include
Message-ID: <20151006112939.GB26251@linux-mips.org>
References: <1444044571-11304-1-git-send-email-thierry.reding@gmail.com>
 <20151005151803.5b5a5b40@avionic-0020>
 <20151005132934.GA22979@ulmo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20151005132934.GA22979@ulmo>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49446
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

On Mon, Oct 05, 2015 at 03:29:34PM +0200, Thierry Reding wrote:

> > > platform and thus broke the qi_lb60_defconfig build.
> > 
> > The fix for this break has just been merged upstream yesterday.
> 
> Okay, great.

So I dropped this one.

  Ralf
