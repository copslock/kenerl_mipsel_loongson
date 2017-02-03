Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Feb 2017 19:57:28 +0100 (CET)
Received: from smtprelay0024.hostedemail.com ([216.40.44.24]:41028 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993911AbdBCS5V6l72x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Feb 2017 19:57:21 +0100
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay04.hostedemail.com (Postfix) with ESMTP id 9DD733526D3;
        Fri,  3 Feb 2017 18:57:18 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-HE-Tag: cap78_228ce2eca2c31
X-Filterd-Recvd-Size: 1559
Received: from XPS-9350 (unknown [47.151.132.55])
        (Authenticated sender: joe@perches.com)
        by omf03.hostedemail.com (Postfix) with ESMTPA;
        Fri,  3 Feb 2017 18:57:17 +0000 (UTC)
Message-ID: <1486148236.22276.72.camel@perches.com>
Subject: Re: Is it time to move drivers/staging/netlogic/ out of staging?
From:   Joe Perches <joe@perches.com>
To:     Florian Fainelli <f.fainelli@gmail.com>,
        "Jayachandran C." <c.jayachandran@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, devel@driverdev.osuosl.org,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Date:   Fri, 03 Feb 2017 10:57:16 -0800
In-Reply-To: <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
References: <1486147623.22276.70.camel@perches.com>
         <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
X-Mailer: Evolution 3.22.3-0ubuntu0.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56630
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
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

On Fri, 2017-02-03 at 10:50 -0800, Florian Fainelli wrote:
> (with JC's other email)

And now with Greg's proper email too

> On 02/03/2017 10:47 AM, Joe Perches wrote:
> > 64 bit stats isn't implemented, but is that really necessary?
> > Anything else?
> 
> Joe, do you have such hardware that you are interested in getting
> supported, or was that just to reduce the amount of drivers in staging?
> I am really not clear about what happened to that entire product line,
> and whether there is any interest in having anything supported these days...

No hardware.  Just to reduce staging driver count.
