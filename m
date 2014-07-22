Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jul 2014 20:42:57 +0200 (CEST)
Received: from filtteri1.pp.htv.fi ([213.243.153.184]:60615 "EHLO
        filtteri1.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860188AbaGVSlNkOedq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Jul 2014 20:41:13 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri1.pp.htv.fi (Postfix) with ESMTP id 8505321B950;
        Tue, 22 Jul 2014 21:41:10 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri1.pp.htv.fi [213.243.153.184]) (amavisd-new, port 10024)
        with ESMTP id Oc4PLP1sf2DZ; Tue, 22 Jul 2014 21:41:04 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id EA72E5BC011;
        Tue, 22 Jul 2014 21:41:03 +0300 (EEST)
Date:   Tue, 22 Jul 2014 21:41:03 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Rob Kendrick <rob.kendrick@codethink.co.uk>
Cc:     Markos Chandras <Markos.Chandras@imgtec.com>,
        linux-mips@linux-mips.org
Subject: Re: EdgeRouter Pro supported?  Strange FP problems
Message-ID: <20140722184103.GA1197@drone.musicnaut.iki.fi>
References: <20140722130616.GJ30723@humdrum>
 <53CE736E.1060009@imgtec.com>
 <20140722143311.GK30723@humdrum>
 <53CE8570.8020404@imgtec.com>
 <20140722154914.GL30723@humdrum>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140722154914.GL30723@humdrum>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41488
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

On Tue, Jul 22, 2014 at 04:49:14PM +0100, Rob Kendrick wrote:
> On Tue, Jul 22, 2014 at 04:38:24PM +0100, Markos Chandras wrote:
> > there have been quite a few FPU changes in 3.16. I am able to reproduce
> > the problem on EdgeRouter (non pro) but the result is not the same as
> > yours. The output using the 'gawk' is:
> > 
> > prefix is ''
> > suffix is 'baz'
> 
> This is still, of course, wrong ;)  I'm glad somebody's managed to
> reproduce it and it's not just madness on my part.

If your userspace is small, maybe you could try rebuilding it
with softfloat. Your script works on octeon with 3.16-rc6 + gcc 4.9 +
glibc 2.19 + gawk 4.0.3 when compiled with softfloat.

A.
