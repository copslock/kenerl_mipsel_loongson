Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jan 2015 09:49:03 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:50618 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011370AbbALItBnfD44 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Jan 2015 09:49:01 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1YAagH-0002sn-00; Mon, 12 Jan 2015 09:49:01 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 1B4361D35C; Mon, 12 Jan 2015 09:48:49 +0100 (CET)
Date:   Mon, 12 Jan 2015 09:48:49 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ip22-gio: Remove legacy suspend/resume support
Message-ID: <20150112084849.GA14477@alpha.franken.de>
References: <1420992417-21294-1-git-send-email-lars@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1420992417-21294-1-git-send-email-lars@metafoo.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45080
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Sun, Jan 11, 2015 at 05:06:56PM +0100, Lars-Peter Clausen wrote:
> There are currently no gio device drivers that implement suspend/resume
> and this patch removes the bus specific legacy suspend and resume callbacks.
> This will allow us to eventually remove struct bus_type legacy suspend and
> resume support altogether.
> 
> gio device drivers wanting to implement suspend and resume can use dev PM
> ops which will work out of the box without further modifications necessary.

I don't expect that to happen soon ;-)

> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>

Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
