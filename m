Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Nov 2013 20:06:02 +0100 (CET)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:42443 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817315Ab3KOTF7QsO1b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Nov 2013 20:05:59 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id EB7E35A7534;
        Fri, 15 Nov 2013 21:05:56 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id KfRdwJ8sb0nx; Fri, 15 Nov 2013 21:05:52 +0200 (EET)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp5.welho.com (Postfix) with SMTP id BDF985BC002;
        Fri, 15 Nov 2013 21:05:51 +0200 (EET)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Fri, 15 Nov 2013 21:05:51 +0200
Date:   Fri, 15 Nov 2013 21:05:51 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     LMOL <linux-mips@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: Release of Linux MTI-3.10-LTS kernel.
Message-ID: <20131115190551.GC10997@blackmetal.musicnaut.iki.fi>
References: <528246BA.10607@imgtec.com>
 <20131112210234.GB30010@blackmetal.musicnaut.iki.fi>
 <5284CFCB.8040009@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5284CFCB.8040009@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38535
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

On Thu, Nov 14, 2013 at 07:27:39AM -0600, Steven J. Hill wrote:
> I wanted to apologize for my earlier email that could have been much
> shorter without being snarky. In short, we have a long test cycle
> and that we are tracking LTS support kernels and will be doing
> regular updates. A few months ago 3.10 was chosen as the next LTS
> version. We decided for stability and continued bug fixes to go with
> it.

No worries. I was actually curious about, and should have asked directly,
if and how you are planning to track the long term kernels in the
future. I look forward seeing how this tree will work in longer term,
it's also great that someone is testing MIPS kernel with such a wide
range of boards.

Thanks,

A.
