Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Nov 2014 21:32:43 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:47029 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013703AbaKNUcles0Bd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Nov 2014 21:32:41 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 0EDD119BCC6;
        Fri, 14 Nov 2014 22:32:41 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id 0g3PuPxsgHGc; Fri, 14 Nov 2014 22:32:34 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 57A855BC015;
        Fri, 14 Nov 2014 22:32:34 +0200 (EET)
Date:   Fri, 14 Nov 2014 22:32:32 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andreas Herrmann <herrmann.der.user@googlemail.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Alex Smith <alex.smith@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-usb <linux-usb@vger.kernel.org>
Subject: Re: [PATCH 0/3] USB: host: Misc patches to remove hard-coded octeon
 platform information
Message-ID: <20141114203232.GE984@fuloong-minipc.musicnaut.iki.fi>
References: <1415914590-31647-1-git-send-email-andreas.herrmann@caviumnetworks.com>
 <Pine.LNX.4.44L0.1411131712201.4266-100000@iolanthe.rowland.org>
 <20141114114714.GA16123@alberich>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141114114714.GA16123@alberich>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Fri, Nov 14, 2014 at 12:47:14PM +0100, Andreas Herrmann wrote:
> On Thu, Nov 13, 2014 at 05:13:36PM -0500, Alan Stern wrote:
> > At a very quick first glance, it looks great.  Have you tested it 
> > thoroughly?
> 
>  [sorry have to use another mail account, so far your mail didn't show
>   up at my caviumnetworks account]
> 
> I've tested it only on an EdgeRouterPro (Octeon II system, which I
> have on-site).

I have also tested them on EdgeRouter Pro. Thanks, this
is great improvement.

Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
