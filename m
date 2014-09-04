Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Sep 2014 16:09:29 +0200 (CEST)
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54217 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025836AbaIDOJXk6r68 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Sep 2014 16:09:23 +0200
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by gateway2.nyi.internal (Postfix) with ESMTP id 9447D20532
        for <linux-mips@linux-mips.org>; Thu,  4 Sep 2014 10:09:22 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 04 Sep 2014 10:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=OwA/9rQb94UqhGim9+ZBXy5sLVw=; b=jlHz5DVP9hr9lWTCa1sAoVikgsJU
        dd5mgAbOAdQjlU+JA5bYYO1B8I2OBHMsXCE7TglhPaQ/gN39bS7izODEbATmobyE
        t+9roYHzAgfrRbOP14Bz80wmnkcwcj8vEfX5TIHZORalMho4CqrGjPYHtls7LGjS
        kWEm51wHVO+R4P8=
X-Sasl-enc: 8vszpkxN+8/nb7UpnpURkweT/5Z9X+jGRn6oAK5FA015 1409839762
Received: from localhost (unknown [24.22.230.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 4CBCBC00918;
        Thu,  4 Sep 2014 10:09:22 -0400 (EDT)
Date:   Thu, 4 Sep 2014 07:09:21 -0700
From:   Greg KH <greg@kroah.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     stable@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [request for stable inclusion] MIPS fixes for 3.16
Message-ID: <20140904140921.GA23299@kroah.com>
References: <53FDE583.9060908@imgtec.com>
 <20140827212310.GA27456@kroah.com>
 <53FEE049.8030906@imgtec.com>
 <54086EAB.3060406@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <54086EAB.3060406@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg@kroah.com
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

On Thu, Sep 04, 2014 at 02:52:43PM +0100, Markos Chandras wrote:
> On 08/28/2014 08:54 AM, Markos Chandras wrote:
> > On 08/27/2014 10:23 PM, Greg KH wrote:
> >> On Wed, Aug 27, 2014 at 03:04:51PM +0100, Markos Chandras wrote:
> >>> Hi Greg,
> >>>
> >>> Could you please apply the following patches to the 3.16.X stable kernels?
> >>>
> >>> - MIPS: EVA: Add new EVA header
> >>> (f85b71ceabb9d8d8a9e34b045b5c43ffde3623b3)
> >>> - MIPS: Malta: EVA: Rename 'eva_entry' to 'platform_eva_init'
> >>> (ca4d24f7954f3746742ba350c2276ff777f21173)
> >>> - MIPS: CPS: Initialize EVA before bringing up VPEs from secondary cores
> >>> (6521d9a436a62e83ce57d6be6e5484e1098c1380)
> >>
> >> That really looks like a new feature, how is this a bugfix / regression
> >> from previous kernel releases?
> >>
> >> thanks,
> >>
> >> greg k-h
> >>
> > Hi Greg,
> > 
> > The bugfix is the 3rd patch in that list. Without this patch, it is not
> > possible to boot a CPS kernel when EVA is enabled. The kernel will die
> > in a horrible way. The other two patches simply make the bugfix fit
> > better in the existing code. So all three are needed.
> > 
> > Thank you
> > 
> 
> Hi Greg,
> 
> Are you happy with the above explanation? If so, could you please
> consider including these patches to the 3.16 stable kernels?

My pending patch queue for 3.16-stable is now over 300 patches long,
I'll get to these again when it comes up in my queue something next week
and let you know...

thanks,

greg k-h
