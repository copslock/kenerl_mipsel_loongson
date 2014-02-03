Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Feb 2014 19:35:54 +0100 (CET)
Received: from filtteri6.pp.htv.fi ([213.243.153.189]:52645 "EHLO
        filtteri6.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822136AbaBCSfuBiJ7T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Feb 2014 19:35:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri6.pp.htv.fi (Postfix) with ESMTP id 8F15656F98A;
        Mon,  3 Feb 2014 20:35:47 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri6.pp.htv.fi [213.243.153.189]) (amavisd-new, port 10024)
        with ESMTP id raIT8y2Ttpfw; Mon,  3 Feb 2014 20:35:43 +0200 (EET)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 65BE65BC017;
        Mon,  3 Feb 2014 20:35:42 +0200 (EET)
Date:   Mon, 3 Feb 2014 20:35:06 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        devel@driverdev.osuosl.org, David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org,
        linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 0/2] MIPS/staging: Probe octeon-usb driver via device-tree
Message-ID: <20140203183506.GE589@drone.musicnaut.iki.fi>
References: <1386100012-6077-1-git-send-email-ddaney.cavm@gmail.com>
 <20131204232953.GA7698@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20131204232953.GA7698@kroah.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39202
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

On Wed, Dec 04, 2013 at 03:29:53PM -0800, Greg Kroah-Hartman wrote:
> On Tue, Dec 03, 2013 at 11:46:50AM -0800, David Daney wrote:
> > From: David Daney <david.daney@cavium.com>
> > 
> > Tested against both EdgeRouter LITE (no bootloader supplied device
> > tree), and ebb5610 (device tree supplied by bootloader).
> > 
> > The patch set is spread across both the MIPS and staging trees, so it
> > would be great if Ralf could merge at least the MIPS parts, if not
> > both parts.
> 
> That's fine with me:
> 
> Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

It seems only the MIPS part was merged, and as a result the OCTEON
USB build is now broken in 3.14-rc1.

Would it be possible to merge the missing part through the staging
tree? The original is here: http://patchwork.linux-mips.org/patch/6186/
The below one is rebased for 3.14-rc1 and tested on EdgeRouter Lite.

A.

---8<---
