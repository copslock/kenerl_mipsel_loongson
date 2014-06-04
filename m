Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Jun 2014 20:53:14 +0200 (CEST)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:41672 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6854763AbaFDSxLPhDoW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 4 Jun 2014 20:53:11 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 86E9A56F7EB;
        Wed,  4 Jun 2014 21:53:10 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id MsgpeXr925QS; Wed,  4 Jun 2014 21:53:04 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id E813C5BC012;
        Wed,  4 Jun 2014 21:53:03 +0300 (EEST)
Date:   Wed, 4 Jun 2014 21:53:03 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Alex Smith <alex.smith@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@nsn.com>,
        David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org
Subject: Re: [1/3] MIPS: octeon: Add interface mode detection for Octeon II
Message-ID: <20140604185303.GA562@drone.musicnaut.iki.fi>
References: <1401358203-60225-2-git-send-email-alex.smith@imgtec.com>
 <20140604144739.GB24816@ak-desktop.emea.nsn-net.net>
 <538F420A.60007@imgtec.com>
 <538F5387.8000200@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <538F5387.8000200@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40435
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

On Wed, Jun 04, 2014 at 10:12:39AM -0700, David Daney wrote:
> On 06/04/2014 08:58 AM, Alex Smith wrote:
> >On 04/06/14 15:47, Aaro Koskinen wrote:
> >>On Thu, May 29, 2014 at 11:10:01AM +0100, Alex Smith wrote:
> >>>Add interface mode detection for Octeon II. This is necessary to detect
> >>>the interface modes correctly on the UBNT E200 board. Code is taken
> >>>from the UBNT GPL source release, with some alterations: SRIO, ILK and
> >>>RXAUI interface modes are removed and instead return disabled as these
> >>>modes are not currently supported.
> >>>
> >>>Tested-by: David Daney <david.daney@cavium.com>
> >>>Signed-off-by: Alex Smith <alex.smith@imgtec.com>
> >>
> >>I tried booting ebb6800 board with these patches.
> 
> There seem to be problems (I think in the interrupt controller code) for
> cn68xx based systems in the kernel.org kernel.  So I couldn't get it to boot
> on my ebb6800 even to the point it tries to initialize the networking
> hardware.

I tested two boards with 3.15-rc8. They boot fine to shell, it's just
modprobing octeon-ethernet that is causing issues.

> >>It hangs somewhere in __cvmx_helper_xaui_enable() with XAUI port. Looking
> >>at the UBNT GPL package, xaui init is quite different with 68XX specific
> >>code paths.  Maybe those bits should be added too, or then disable XAUI
> >>support as well?
> >
> >Probably the best thing to do for now would be to disable it. Does it
> >boot successfully for you if you switch CVMX_HELPER_INTERFACE_MODE_XAUI
> >to disabled?
> 
> ... I don't think it matters.  The patch Alex et al. came up with is an
> improvement over what is already there.  The fact that there are still some
> configurations that don't work can be addressed with follow-on patches.

Fair enough; previously octeon-ethernet panic()ed on ebb6800 and now it
silently hangs - so it's not really any serious regression.

If these patches already make it work on ER Pro then good, at least
it's a some kind of improvement towards a proper Octeon II support.

A.
