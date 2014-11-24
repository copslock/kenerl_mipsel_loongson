Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Nov 2014 20:13:12 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:40627 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006899AbaKXTNKwm7eK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Nov 2014 20:13:10 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id C85E519C1BD;
        Mon, 24 Nov 2014 21:13:08 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp6.welho.com ([213.243.153.40])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id t4kBYEAxbGHK; Mon, 24 Nov 2014 21:13:02 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp6.welho.com (Postfix) with ESMTP id 209C75BC003;
        Mon, 24 Nov 2014 21:13:02 +0200 (EET)
Date:   Mon, 24 Nov 2014 21:13:01 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     James Cowgill <James.Cowgill@imgtec.com>,
        "Herrmann, Andreas" <Andreas.Herrmann@caviumnetworks.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: Re: [PATCH] MIPS: octeon: Add support for the UBNT E200 board
Message-ID: <20141124191301.GC6796@fuloong-minipc.musicnaut.iki.fi>
References: <1416837096-52243-1-git-send-email-James.Cowgill@imgtec.com>
 <54736A06.9070206@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54736A06.9070206@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44392
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

Hi,

On Mon, Nov 24, 2014 at 09:25:26AM -0800, David Daney wrote:
> On 11/24/2014 05:51 AM, James Cowgill wrote:
> >From: Markos Chandras <markos.chandras@imgtec.com>
> >
> >Add support for the UBNT E200 board (EdgeRouter/EdgeRouter Pro 8 port).
> >
> >Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> >Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
> 
> NACK.
> 
> As far as I know, these boards have a boot loader that supplies a correct
> device tree, there should be no need to hack up the kernel like this.
> 
> As far as I know, Andreas is running a kernel.org kernel on these boards
> without anything like this.

It gets called from Octeon Ethernet driver through cvmx_helper_link_get()
frequently so the console gets spammed about unknown board, and probably
also the link status is bogus as a result.

I guess all those board helper functions should be factored
out and Octeon Ethernet should use DT only. I think we need TODO
file under staging/octeon.

A.
