Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2012 23:40:32 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33494 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903667Ab2COWk1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2012 23:40:27 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 545D18F61;
        Thu, 15 Mar 2012 23:40:26 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 2BR6SpsGM2ey; Thu, 15 Mar 2012 23:40:12 +0100 (CET)
Received: from [192.168.1.195] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id 6EA078F60;
        Thu, 15 Mar 2012 23:40:12 +0100 (CET)
Message-ID: <4F626FCB.6010103@hauke-m.de>
Date:   Thu, 15 Mar 2012 23:40:11 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>
CC:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 4/7] USB: Add driver for the bcma bus
References: <1331597093-425-1-git-send-email-hauke@hauke-m.de> <1331597093-425-5-git-send-email-hauke@hauke-m.de> <20120315194426.GA30682@kroah.com>
In-Reply-To: <20120315194426.GA30682@kroah.com>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32716
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/15/2012 08:44 PM, Greg KH wrote:
> On Tue, Mar 13, 2012 at 01:04:50AM +0100, Hauke Mehrtens wrote:
>> This adds a USB driver using the generic platform device driver for the
>> USB controller found on the Broadcom bcma bus. The bcma bus just
>> exposes one device which serves the OHCI and the EHCI controller at the
>> same time. This driver probes for this USB controller and creates and
>> registers two new platform devices which will be probed by the new
>> generic platform device driver. This makes it possible to use the EHCI
>> and the OCHI controller on the bcma bus at the same time.
>>
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  drivers/usb/host/Kconfig    |   12 ++
> 
> This patch fails to apply here, and I can't seem to figure out what tree
> you made this against to fix it up by hand on my end.
> 
> Any thoughts?
> 
> greg k-h

This patch was against
git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git#master, but
I will rebase it onto usb/usb-next and send a new version of the patches
you have not applied.

Hauke
