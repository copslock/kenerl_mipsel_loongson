Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Oct 2015 15:20:22 +0200 (CEST)
Received: from ec2-54-201-57-178.us-west-2.compute.amazonaws.com ([54.201.57.178]:51879
        "EHLO ip-172-31-12-36.us-west-2.compute.internal"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27009438AbbJNNUURRoGC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Oct 2015 15:20:20 +0200
Received: by ip-172-31-12-36.us-west-2.compute.internal (Postfix, from userid 1001)
        id 7FA3B411D8; Wed, 14 Oct 2015 13:15:58 +0000 (UTC)
Date:   Wed, 14 Oct 2015 06:15:58 -0700
From:   dwalker@fifo99.com
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     alex.smith@imgtec.com, linux-mips@linux-mips.org
Subject: Re: mips VDSO
Message-ID: <20151014131558.GA15858@fifo99.com>
References: <20150909164309.GB27534@fifo99.com>
 <55F13BDA.3030304@imgtec.com>
 <20151014124438.GA15821@fifo99.com>
 <561E50BE.3010605@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <561E50BE.3010605@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <dwalker@fifo99.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dwalker@fifo99.com
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

On Wed, Oct 14, 2015 at 01:55:26PM +0100, Markos Chandras wrote:
> On 10/14/2015 01:44 PM, dwalker@fifo99.com wrote:
> > On Thu, Sep 10, 2015 at 09:14:18AM +0100, Markos Chandras wrote:
> >> On 09/09/2015 05:43 PM, dwalker@fifo99.com wrote:
> >>> Hi,
> >>>
> >>> I was wondering if you've made any progress on this? I was also interested in implementing a faster gettimeofday()
> >>> for mips.
> >>>
> >>> Daniel
> >>>
> >> Hi,
> >>
> >> I am currently reviewing Alex's VSDO implementation and I will post it
> >> to this list within the next couple of weeks.
> > 
> > Did you an Alex finalize the VDSO implementation ?
> > 
> > Daniel
> > 
> 
> I have submitted the kernel patches to that last a few weeks ago. I am
> waiting for them to be merged before I submit the libc part of it.

https://patchwork.linux-mips.org/patch/11249/

Not sure if that's the most recent one, but patchwork lists it as "Rejected". Did you have
more work to do on it ?

Daniel
