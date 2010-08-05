Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Aug 2010 04:32:59 +0200 (CEST)
Received: from sj-iport-5.cisco.com ([171.68.10.87]:35508 "EHLO
        sj-iport-5.cisco.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1493293Ab0HECcx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Aug 2010 04:32:53 +0200
Authentication-Results: sj-iport-5.cisco.com; dkim=neutral (message not signed) header.i=none
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEAAa/WUyrR7Hu/2dsb2JhbACgK3GpPpshghqDIQSEHg
X-IronPort-AV: E=Sophos;i="4.55,318,1278288000"; 
   d="scan'208";a="235756576"
Received: from sj-core-5.cisco.com ([171.71.177.238])
  by sj-iport-5.cisco.com with ESMTP; 05 Aug 2010 02:32:44 +0000
Received: from dvomlehn-lnx2.corp.sa.net (dhcp-171-71-47-241.cisco.com [171.71.47.241])
        by sj-core-5.cisco.com (8.13.8/8.14.3) with ESMTP id o752WipP006839;
        Thu, 5 Aug 2010 02:32:44 GMT
Date:   Wed, 4 Aug 2010 19:32:44 -0700
From:   David VomLehn <dvomlehn@cisco.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, greg@kroah.com,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 2/2][MIPS] USB/PowerTV: Separate PowerTV USB support
        from non-USB code
Message-ID: <20100805023244.GA6780@dvomlehn-lnx2.corp.sa.net>
References: <20100803014058.GA31552@dvomlehn-lnx2.corp.sa.net> <20100805004941.GB28402@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100805004941.GB28402@linux-mips.org>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27587
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 05, 2010 at 01:49:41AM +0100, Ralf Baechle wrote:
> David,
> 
> can this patch be safely applied alone until I get an Ack for patch 1/1?
> 
> Thanks,
> 
>   Ralf

Yes. It's the first time I've submitted something that crosses maintainer
lines, so I made sure it would work with USB disabled.
-- 
David VL
