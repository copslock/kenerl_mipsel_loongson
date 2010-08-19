Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Aug 2010 00:55:49 +0200 (CEST)
Received: from sj-iport-4.cisco.com ([171.68.10.86]:46939 "EHLO
        sj-iport-4.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491099Ab0HSWzo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Aug 2010 00:55:44 +0200
Authentication-Results: sj-iport-4.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAF9TbUyrRN+J/2dsb2JhbACgUnGkW5tkghWDIgSEMw
X-IronPort-AV: E=Sophos;i="4.56,235,1280707200"; 
   d="scan'208";a="174359479"
Received: from sj-core-3.cisco.com ([171.68.223.137])
  by sj-iport-4.cisco.com with ESMTP; 19 Aug 2010 22:55:37 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-3.cisco.com (8.13.8/8.14.3) with ESMTP id o7JMtZk5021019;
        Thu, 19 Aug 2010 22:55:35 GMT
Date:   Thu, 19 Aug 2010 15:55:37 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     Greg KH <greg@kroah.com>
Cc:     linux-mips@linux-mips.org, linux-usb@vger.kernel.org,
        ralf@linux-mips.org
Subject: Re: [PATCH 1/2][USB] USB/PowerTV: Add support for PowerTV USB
        interface
Message-ID: <20100819225537.GA9830@dvomlehn-lnx2.corp.sa.net>
References: <20100803014054.GA31524@dvomlehn-lnx2.corp.sa.net> <20100819174341.GA13561@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100819174341.GA13561@kroah.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 19, 2010 at 10:43:41AM -0700, Greg KH wrote:
> On Mon, Aug 02, 2010 at 06:40:54PM -0700, David VomLehn wrote:
> > Add support for the Cisco PowerTV USB interface.
> > 
> > This is a very simple set of glue functions, apparently derived some time
> > ago from the au1xxx driver by Matt Porter.
> > 
> > Signed-off-by: David VomLehn <dvomlehn@cisco.com>
> 
> Do you want me to take this through the USB tree?  It's that useful
> without the 2/2 patch, right?

Yes, this is not useful without the 2/2 patch.

> If so, Ralf, feel free to add this to your tree with an:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> to the patch.
> 
> If not, I'll be glad to take it in mine, just let me know.

If it's okay with Ralf, it's okay with me.

> thanks,
> 
> greg k-h

Thanks!
-- 
David VL
