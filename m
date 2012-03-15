Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Mar 2012 23:43:50 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:33530 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903667Ab2COWno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Mar 2012 23:43:44 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 2C9BF8F61;
        Thu, 15 Mar 2012 23:43:44 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id xxu-Z8z3IgFW; Thu, 15 Mar 2012 23:43:31 +0100 (CET)
Received: from [192.168.1.195] (unknown [134.102.132.222])
        by hauke-m.de (Postfix) with ESMTPSA id C11F48F60;
        Thu, 15 Mar 2012 23:43:30 +0100 (CET)
Message-ID: <4F627092.7030207@hauke-m.de>
Date:   Thu, 15 Mar 2012 23:43:30 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.2) Gecko/20120216 Thunderbird/10.0.2
MIME-Version: 1.0
To:     Greg KH <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     stern@rowland.harvard.edu, linux-mips@linux-mips.org,
        ralf@linux-mips.org, m@bues.ch, linux-usb@vger.kernel.org,
        linux-wireless@vger.kernel.org
Subject: Re: [PATCH v4 3/7] bcma: scan for extra address space
References: <1331597093-425-1-git-send-email-hauke@hauke-m.de> <1331597093-425-4-git-send-email-hauke@hauke-m.de> <20120315194453.GB30682@kroah.com>
In-Reply-To: <20120315194453.GB30682@kroah.com>
X-Enigmail-Version: 1.3.5
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 32717
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 03/15/2012 08:44 PM, Greg KH wrote:
> On Tue, Mar 13, 2012 at 01:04:49AM +0100, Hauke Mehrtens wrote:
>> Some cores like the USB core have two address spaces. In the USB host
>> controller one address space is used for the OHCI and the other for the
>> EHCI controller interface. The USB controller is the only core I found
>> with two address spaces. This code is based on the AI scan function
>> ai_scan() in shared/aiutils.c in the Broadcom SDK.
>>
>> CC: Rafał Miłecki <zajec5@gmail.com>
>> CC: linux-wireless@vger.kernel.org
>> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
>> ---
>>  drivers/bcma/scan.c       |   19 ++++++++++++++++++-
>>  include/linux/bcma/bcma.h |    1 +
>>  2 files changed, 19 insertions(+), 1 deletions(-)
> 
> Is this required for the 4/7 patch?
> 
> If so, can I get an ack from the BCMA developers so that I can take this
> through the USB tree?
> 
> thanks,
> 
> greg k-h

Hi Rafał,

could you give me an ack for this patch please.

This patch is only required for the patch "Add driver for the bcma bus".

Hauke
