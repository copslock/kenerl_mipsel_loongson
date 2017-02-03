Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 21:36:36 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:41092 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993911AbdBCUgaL55L5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 21:36:30 +0100
Received: from localhost (unknown [37.169.168.106])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 00BE1720;
        Fri,  3 Feb 2017 20:36:22 +0000 (UTC)
Date:   Fri, 3 Feb 2017 21:36:09 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Joe Perches <joe@perches.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        "Jayachandran C." <c.jayachandran@gmail.com>,
        devel@driverdev.osuosl.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: Is it time to move drivers/staging/netlogic/ out of staging?
Message-ID: <20170203203609.GA14271@kroah.com>
References: <1486147623.22276.70.camel@perches.com>
 <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
 <1486148236.22276.72.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1486148236.22276.72.camel@perches.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56631
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

On Fri, Feb 03, 2017 at 10:57:16AM -0800, Joe Perches wrote:
> On Fri, 2017-02-03 at 10:50 -0800, Florian Fainelli wrote:
> > (with JC's other email)
> 
> And now with Greg's proper email too
> 
> > On 02/03/2017 10:47 AM, Joe Perches wrote:
> > > 64 bit stats isn't implemented, but is that really necessary?
> > > Anything else?
> > 
> > Joe, do you have such hardware that you are interested in getting
> > supported, or was that just to reduce the amount of drivers in staging?
> > I am really not clear about what happened to that entire product line,
> > and whether there is any interest in having anything supported these days...
> 
> No hardware.  Just to reduce staging driver count.

Without hardware or a "real" maintainer, it shouldn't be moved.

Heck, if no one has the hardware, let's just delete the thing.

thanks,

greg k-h
