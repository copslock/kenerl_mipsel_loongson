Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Dec 2014 00:51:15 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:39419 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009498AbaLWXvNl1yx- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Dec 2014 00:51:13 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 4170956FAA8;
        Wed, 24 Dec 2014 01:51:13 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id 92Ahy-sdpaaY; Wed, 24 Dec 2014 01:51:08 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 6F76E5BC012;
        Wed, 24 Dec 2014 01:51:08 +0200 (EET)
Date:   Wed, 24 Dec 2014 01:51:08 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 07/10] MIPS: support for hybrid FPRs
Message-ID: <20141223235108.GA582@fuloong-minipc.musicnaut.iki.fi>
References: <1410420623-11691-1-git-send-email-paul.burton@imgtec.com>
 <1410420623-11691-8-git-send-email-paul.burton@imgtec.com>
 <20141223232111.GA593@fuloong-minipc.musicnaut.iki.fi>
 <20141223233154.GA4171@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20141223233154.GA4171@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44909
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

On Tue, Dec 23, 2014 at 11:31:54PM +0000, James Hogan wrote:
> On Wed, Dec 24, 2014 at 01:21:11AM +0200, Aaro Koskinen wrote:
> > On Thu, Sep 11, 2014 at 08:30:20AM +0100, Paul Burton wrote:
> > > Hybrid FPRs is a scheme where scalar FP registers are 64b wide, but
> > > accesses to odd indexed single registers use bits 63:32 of the
> > > preceeding even indexed 64b register. In this mode all FP code
> > > except that built for the plain FP64 ABI can execute correctly. Most
> > > notably a combination of FP64A & FP32 code can execute correctly,
> > > allowing for existing FP32 binaries to be linked with new FP64A binaries
> > > that can make use of 64 bit FP & MSA.
> > 
> > This commit (4227a2d4efc9c84f35826dc4d1e6dc183f6c1c05, bisected)
> > in 3.19-rc1 breaks my Loongson-2F system. I get endless amount
> > of "Reserved instruction in kernel code" exceptions when booting.
> > See some examples below. Nothing crashes, and there is some forward
> > progress, but obviously it's completely unusable.
> > 
> > Any ideas?
> > 
> > [    2.872000] Reserved instruction in kernel code[#1]:
> ...
> > Code: 30420001  2c420001  0040202d <40038005> 2405feff  00651824  40838005  3c032000  3c052400 
> 
> 0x40038005 = mfc0 v1,$16,5 = mfc0 v1,Config5
> 
> Does this help (in linux-next)?:
> http://git.linux-mips.org/cgit/ralf/upstream-sfr.git/commit/?id=5bba8dec735f18fe7a2fcd8327f28ef095337ff2

Yes, it does. Many thanks!

A.
