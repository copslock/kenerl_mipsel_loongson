Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 24 Aug 2014 10:34:42 +0200 (CEST)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:40466 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27025898AbaHWUYzmUMxW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Aug 2014 22:24:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 0D2CC19BD9D;
        Sat, 23 Aug 2014 23:24:55 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id C1CCxF0cvVoD; Sat, 23 Aug 2014 23:24:48 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id 590AF5BC003;
        Sat, 23 Aug 2014 23:24:48 +0300 (EEST)
Date:   Sat, 23 Aug 2014 23:24:48 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Markos (GMail)" <markos.chandras@gmail.com>,
        Markos <markos.chandras@imgtec.com>,
        Paul <paul.burton@imgtec.com>,
        Rob Kendrick <rob.kendrick@codethink.co.uk>,
        Alex Smith <alex@alex-smith.me.uk>,
        Huacai Chen <chenhc@lemote.com>
Subject: Re: Please add my temporary MIPS fixes branch to linux-next
Message-ID: <20140823202447.GB6818@drone.musicnaut.iki.fi>
References: <53D9169D.3020705@imgtec.com>
 <53E8A470.1050603@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53E8A470.1050603@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42194
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

On Mon, Aug 11, 2014 at 12:09:36PM +0100, James Hogan wrote:
> On 30/07/14 17:00, James Hogan wrote:
> > Hi Stephen & MIPS people
> > 
> > v3.16 is fast approaching and there are quite a few important MIPS
> > patches pending. Since Ralf appears to be unavailable at the moment I've
> > reviewed and applied some of those patches which are least controversial
> > to a fixes branch with the intention of sending a pull request to Ralf &
> > Linus so that one of them can hopefully merge it before the release.
> 
> I sent you a pull request for these fixes prior to v3.16 but
> unfortunately they still missed the release, and only two of the patches
> were applied in the main v3.17 MIPS merge.
> 
> What are you intentions for the remaining fixes from Markos & Aaro?

Ralf, any comments? I think at least this fix is imporant,
because currently users can hang OCTEON systems simply by lauching
multiple readers of the proc file:

https://git.kernel.org/cgit/linux/kernel/git/jhogan/mips.git/commit/?id=08a9c3c9afcf6e8975fc1c9a97e871e6a039c25a

A.
