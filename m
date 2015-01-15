Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Jan 2015 21:24:38 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:39845 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009397AbbAOUYgSN80v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Jan 2015 21:24:36 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id E251156F703;
        Thu, 15 Jan 2015 22:24:35 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id dV7gn0WHJtOq; Thu, 15 Jan 2015 22:24:30 +0200 (EET)
Received: from fuloong-minipc (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id D0FF15BC012;
        Thu, 15 Jan 2015 22:24:30 +0200 (EET)
Date:   Thu, 15 Jan 2015 22:24:30 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Hemmo Nieminen <hemmo.nieminen@iki.fi>, stable@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: OCTEON: fix kernel crash when offlining a CPU
Message-ID: <20150115202430.GB8087@fuloong-minipc.musicnaut.iki.fi>
References: <1421347767-21740-1-git-send-email-aaro.koskinen@iki.fi>
 <54B816AC.7070902@gmail.com>
 <20150115195345.GA8087@fuloong-minipc.musicnaut.iki.fi>
 <54B81EA0.8060409@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54B81EA0.8060409@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45138
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

On Thu, Jan 15, 2015 at 12:10:08PM -0800, David Daney wrote:
> On 01/15/2015 11:53 AM, Aaro Koskinen wrote:
> >Hi,
> >
> >On Thu, Jan 15, 2015 at 11:36:12AM -0800, David Daney wrote:
> >>On 01/15/2015 10:49 AM, Aaro Koskinen wrote:
> >>>octeon_cpu_disable() will unconditionally enable interrupts when called
> >>>with interrupts disabled. Fix that.
> >>
> >>interrupts are always disabled here, so...
> >
> >Is that also true for all the currently supported stable kernels...?
> 
> I haven't done extensive research recently, but I have removed that pair of
> local_irq_disable/local_irq_enable in our SDK kernel based on 3.10

Ok, I'll add stable tag only for 3.18 as that is the oldest I can test
with at the moment.

A.
