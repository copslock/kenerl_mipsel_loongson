Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Feb 2017 10:49:09 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:55700 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990600AbdBFJtDTruD0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Feb 2017 10:49:03 +0100
Received: from localhost (unknown [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 20E572C;
        Mon,  6 Feb 2017 09:48:52 +0000 (UTC)
Date:   Mon, 6 Feb 2017 10:48:54 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Joe Perches <joe@perches.com>,
        "Jayachandran C." <c.jayachandran@gmail.com>,
        devel@driverdev.osuosl.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: Is it time to move drivers/staging/netlogic/ out of staging?
Message-ID: <20170206094854.GB8780@kroah.com>
References: <1486147623.22276.70.camel@perches.com>
 <e160890d-ed79-4e63-57af-1489064d49cb@gmail.com>
 <1486148236.22276.72.camel@perches.com>
 <20170203203609.GA14271@kroah.com>
 <50640771-abc2-dd9a-7418-7393afe23cd5@gmail.com>
 <20170203204427.GA14959@kroah.com>
 <5eb18f9b-d27c-3f35-9748-81e4ea2d2d70@gmail.com>
 <20170204080815.GA15555@kroah.com>
 <4ffd9c56-48b0-7e8d-c83a-6a335deeecb4@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4ffd9c56-48b0-7e8d-c83a-6a335deeecb4@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56650
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

On Sun, Feb 05, 2017 at 07:21:17PM -0800, Florian Fainelli wrote:
> Le 02/04/17 à 00:08, Greg KH a écrit :
> > On Fri, Feb 03, 2017 at 06:37:02PM -0800, Florian Fainelli wrote:
> >>
> >>
> >> On 02/03/2017 12:44 PM, Greg KH wrote:
> >>> On Fri, Feb 03, 2017 at 12:38:45PM -0800, Florian Fainelli wrote:
> >>>> On 02/03/2017 12:36 PM, Greg KH wrote:
> >>>>> On Fri, Feb 03, 2017 at 10:57:16AM -0800, Joe Perches wrote:
> >>>>>> On Fri, 2017-02-03 at 10:50 -0800, Florian Fainelli wrote:
> >>>>>>> (with JC's other email)
> >>>>>>
> >>>>>> And now with Greg's proper email too
> >>>>>>
> >>>>>>> On 02/03/2017 10:47 AM, Joe Perches wrote:
> >>>>>>>> 64 bit stats isn't implemented, but is that really necessary?
> >>>>>>>> Anything else?
> >>>>>>>
> >>>>>>> Joe, do you have such hardware that you are interested in getting
> >>>>>>> supported, or was that just to reduce the amount of drivers in staging?
> >>>>>>> I am really not clear about what happened to that entire product line,
> >>>>>>> and whether there is any interest in having anything supported these days...
> >>>>>>
> >>>>>> No hardware.  Just to reduce staging driver count.
> >>>>>
> >>>>> Without hardware or a "real" maintainer, it shouldn't be moved.
> >>>>>
> >>>>> Heck, if no one has the hardware, let's just delete the thing.
> >>>>
> >>>> I do have one, and other colleagues have some too, but I am not heavily
> >>>> using it, nor do I have many cycles to spend on that... sounds like we
> >>>> could keep it in staging for another 6 months and see what happens then?
> >>>
> >>> Well, if it works for you, want to maintain it?  :)
> >>
> >> I'd have to locate the documentation first, and you would have to reply
> >> to my patch series about DSA ;)
> > 
> > I don't have any patch series in my queue, sorry, so I have no idea what
> > you are talking about...
> 
> You don't really? How about this patch series:
> 
> https://www.mail-archive.com/netdev@vger.kernel.org/msg147917.html
> 
> and me asking you another time to provide feedback:
> 
> https://www.mail-archive.com/netdev@vger.kernel.org/msg150885.html

Argh, that stuff, yeah, that's in a different review queue, and is going
to take "real work" on my side to get through, which is why it hasn't
happened yet, sorry...

it's not lost.

greg k-h
