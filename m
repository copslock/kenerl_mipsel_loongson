Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jul 2013 20:03:57 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:57200 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6815753Ab3GRSDsnlmVD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jul 2013 20:03:48 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id 181675A6E57;
        Thu, 18 Jul 2013 21:03:47 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id 8pn2sDdonjxR; Thu, 18 Jul 2013 21:03:42 +0300 (EEST)
Received: from musicnaut.iki.fi (cs181064211.pp.htv.fi [82.181.64.211])
        by smtp4.welho.com (Postfix) with SMTP id 1E9A65BC005;
        Thu, 18 Jul 2013 21:03:41 +0300 (EEST)
Received: by musicnaut.iki.fi (sSMTP sendmail emulation); Thu, 18 Jul 2013 21:03:39 +0300
Date:   Thu, 18 Jul 2013 21:03:39 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Faidon Liambotis <paravoid@debian.org>, linux-mips@linux-mips.org
Subject: Re: octeon: oops/panic with CONFIG_SERIO_I8042=y
Message-ID: <20130718180339.GH14385@blackmetal.musicnaut.iki.fi>
References: <20130718122556.GA19040@tty.gr>
 <51E817C6.3030706@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51E817C6.3030706@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37321
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

On Thu, Jul 18, 2013 at 09:28:54AM -0700, David Daney wrote:
> On 07/18/2013 05:25 AM, Faidon Liambotis wrote:
> >My goal is to run a standard Debian kernel and its octeon variant[1] on
> >the Ubiquity EdgeRouter Lite. The ERLite needs a couple of patches
> >to boot and work (octeon-ethernet patch, octeon-usb driver) but these
> >are already merged 3.11 and I'll file Debian bugs to enable those
> >settings appropriately.
> >
> >1: e.g. http://packages.debian.org/sid/linux-image-3.10-1-octeon
> >
> >However, when trying to boot a standard Debian kernel in the ERLite I
> >get a 7s delay followed by an oops for a Data bus error on i8042_flush()
> >and ending up with a panic. It looks like the kernel is built with
> >CONFIG_SERIO_I8042=y.  The Octeon machine Debian owns prints "i8042: No
> >controller found" but works nevertheless.  This isn't the case with the
> >ERLite; I tried 3.2 & 3.10 and got the same oops which went away as soon
> >as I disabled CONFIG_SERIO_I8042.
> >
> >Are there even any octeon machines with i8042 anyway? Should I request
> >for the setting to be disabled irrespective of this bug?
> 
> Yes.  There is a rare board called NAC38 that was produced by ASUS
> in a 1U chassis.  I don't think it is important to support this, so
> the best thing seems to be not to enable SERIO_I8042

I think the real bug here is that IO space does not get properly
initialized on Octeon when there is no PCI? So any drivers trying to
probe IO space will produce some interesting results.

A.
