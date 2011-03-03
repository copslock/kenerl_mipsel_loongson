Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Mar 2011 11:15:43 +0100 (CET)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:58526 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491771Ab1CCKPk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Mar 2011 11:15:40 +0100
Received: by wwb29 with SMTP id 29so4978180wwb.0
        for <multiple recipients>; Thu, 03 Mar 2011 02:15:33 -0800 (PST)
Received: by 10.216.155.205 with SMTP id j55mr391566wek.90.1299147333615;
        Thu, 03 Mar 2011 02:15:33 -0800 (PST)
Received: from localhost (cpc3-chap8-2-0-cust205.aztw.cable.virginmedia.com [94.171.253.206])
        by mx.google.com with ESMTPS id m6sm486383wej.34.2011.03.03.02.15.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 03 Mar 2011 02:15:32 -0800 (PST)
Date:   Thu, 3 Mar 2011 10:15:27 +0000
From:   Jamie Iles <jamie@jamieiles.com>
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        Wim Van Sebroeck <wim@iguana.be>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH V2 05/10] MIPS: lantiq: add watchdog support
Message-ID: <20110303101527.GE2955@pulham.picochip.com>
References: <1298996006-15960-1-git-send-email-blogic@openwrt.org>
 <1298996006-15960-6-git-send-email-blogic@openwrt.org>
 <4D6E286D.9050100@mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D6E286D.9050100@mvista.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jamie@jamieiles.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@jamieiles.com
Precedence: bulk
X-list: linux-mips

On Wed, Mar 02, 2011 at 02:22:21PM +0300, Sergei Shtylyov wrote:
> >+static int
> >+ltq_wdt_remove(struct platform_device *dev)
> 
>    __exit?

No, I think this should be __devexit and the probe function should be 
__devinit.  When assigning the exit function to the platform_driver it 
should be surrounded with __devexit_p().

Jamie
