Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 16:54:39 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:34690 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994571AbeEGOyavuR6d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 May 2018 16:54:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding
        :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=QnmsAmCxqtyYQ/Us3729PkzE2U4b9T4RaZuVYL+Jl6M=; b=D5Ax27U6ed6tJEG5GRMN/uribC
        qCtiZOlAMegMg8aoXZN9FL8f/HS2EZCuwTaFWWLC1b64MYhHKHiNsLCaTfgBDjfCZvy6D5R4vaZNE
        WS9YFppT5H8/7h4MA0IXa4rTtpL/BVbqKZLaKLNI0iUsaoZltUZSxIFgvxnUicosjB0/fGNupZWnw
        jRj3PnNSfPo0UKbeP01KoEOIzllMIiT2T1kEB+nbUvHG8la7irD+ZOQ3/pjCgkrz55tIUFFn57R3Q
        kujNQC0r5MMFaosRGIsN80Is8xEDug9g76b8x++9OUvG2QYbjIUEG/FXOcI6D9Z8kisys7RrxdIlR
        Yxx9hAtQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50766 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.89)
        (envelope-from <linux@roeck-us.net>)
        id 1fFhWr-001OAp-8R; Mon, 07 May 2018 14:54:17 +0000
Date:   Mon, 7 May 2018 07:54:16 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     John Crispin <john@phrozen.org>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        linux-watchdog@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] watchdog: ath79: fix maximum timeout
Message-ID: <20180507145416.GA14523@roeck-us.net>
References: <20180507131642.11440-1-john@phrozen.org>
 <319719c3-eeec-c75f-68c1-b6d15cf884c5@roeck-us.net>
 <3c24c84f-baa1-2eef-4b5c-85d0e5803e7b@phrozen.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3c24c84f-baa1-2eef-4b5c-85d0e5803e7b@phrozen.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Mon, May 07, 2018 at 03:40:57PM +0200, John Crispin wrote:
> 
> 
> On 07/05/18 15:34, Guenter Roeck wrote:
> >On 05/07/2018 06:16 AM, John Crispin wrote:
> >>If the userland tries to set a timeout higher than the max_timeout,
> >>then we should fallback to max_timeout.
> >>
> >
> >We don't do that for drivers using the watchdog core, so we should not
> >do it here either for consistency.
> >
> >Guenter
> 
> Hi,
> thanks for the quick feedback. I'll mark the patch as "rejected by upstream
> due to subsystem consistency" inside OpenWrt.

Note that I am not completely opposed to the idea, but it should go through
the watchdog core. You could convert the driver to use it, and then make
the case that the subsystem should report <min, max> to userspace, relax
set_timeout to adjust the requested timeout to [min,max] instead of letting
userspace guess it, or both. Plus, of course, submit patches to actually
implement and document the necessary changes.

Thanks,
Guenter
