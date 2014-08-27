Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Aug 2014 23:23:13 +0200 (CEST)
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45684 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007114AbaH0VXMWN2rp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 27 Aug 2014 23:23:12 +0200
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by gateway2.nyi.internal (Postfix) with ESMTP id 83C19206B5
        for <linux-mips@linux-mips.org>; Wed, 27 Aug 2014 17:23:11 -0400 (EDT)
Received: from frontend2 ([10.202.2.161])
  by compute6.internal (MEProxy); Wed, 27 Aug 2014 17:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:to:cc:subject:message-id
        :references:mime-version:content-type:in-reply-to; s=smtpout;
         bh=woYWUbjI+ABnvR/DK5/nnG4G07E=; b=JOfmAqlOIuJclbq4DWdSbAR02pse
        b9FWWzyuYVgtOSgNOAutkhDEXWY7PlPhdGCvctcqijXaVVheFjE4U3Y32Axn1R0t
        YKlS29ch9L5quknPzTK6lafQkvzmBN2ToVc80IUW/oxh8IIdQtjZhJV2wsmCQ6q2
        sW4z/sVWaKF5Gbg=
X-Sasl-enc: YPDxXfWIQEEV+1J0/yKn9VfzS9kPIi7qfQ7VhTrpcpPg 1409174591
Received: from localhost (unknown [24.22.230.10])
        by mail.messagingengine.com (Postfix) with ESMTPA id 31F756800E3;
        Wed, 27 Aug 2014 17:23:11 -0400 (EDT)
Date:   Wed, 27 Aug 2014 14:23:10 -0700
From:   Greg KH <greg@kroah.com>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     stable@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [request for stable inclusion] MIPS fixes for 3.16
Message-ID: <20140827212310.GA27456@kroah.com>
References: <53FDE583.9060908@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <53FDE583.9060908@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <greg@kroah.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42287
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

On Wed, Aug 27, 2014 at 03:04:51PM +0100, Markos Chandras wrote:
> Hi Greg,
> 
> Could you please apply the following patches to the 3.16.X stable kernels?
> 
> - MIPS: EVA: Add new EVA header
> (f85b71ceabb9d8d8a9e34b045b5c43ffde3623b3)
> - MIPS: Malta: EVA: Rename 'eva_entry' to 'platform_eva_init'
> (ca4d24f7954f3746742ba350c2276ff777f21173)
> - MIPS: CPS: Initialize EVA before bringing up VPEs from secondary cores
> (6521d9a436a62e83ce57d6be6e5484e1098c1380)

That really looks like a new feature, how is this a bugfix / regression
from previous kernel releases?

thanks,

greg k-h
