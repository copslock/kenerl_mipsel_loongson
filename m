Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 10:32:23 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4444 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491055Ab1FFIcU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 6 Jun 2011 10:32:20 +0200
Received: from [10.9.200.131] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 06 Jun 2011 01:36:24 -0700
X-Server-Uuid: 02CED230-5797-4B57-9875-D5D2FEE4708A
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 6 Jun 2011 01:32:02 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 A75FA74D0D; Mon, 6 Jun 2011 01:32:01 -0700 (PDT)
Received: from [192.168.1.120] (unknown [10.176.68.21]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id 0DA7020501; Mon, 6
 Jun 2011 01:31:59 -0700 (PDT)
Message-ID: <4DEC907E.9040405@broadcom.com>
Date:   Mon, 6 Jun 2011 10:31:58 +0200
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     "Hauke Mehrtens" <hauke@hauke-m.de>
cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "zajec5@gmail.com" <zajec5@gmail.com>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "george@znau.edu.ua" <george@znau.edu.ua>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
 <1307311658-15853-2-git-send-email-hauke@hauke-m.de>
In-Reply-To: <1307311658-15853-2-git-send-email-hauke@hauke-m.de>
X-WSS-ID: 61F24E021IC16574349-01-01
Content-Type: text/plain;
 charset=iso-8859-1;
 format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 30238
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3919

On 06/06/2011 12:07 AM, Hauke Mehrtens wrote:
> When using bcma on a embedded device it is initialized very early at
> boot. We have to do so as the cpu and interrupt management and all
> other devices are attached to this bus and it has to be initialized so
> early. In that stage we can not allocate memory or sleep, just use the
> memory on the stack and in the text segment as the kernel is not
> initialized far enough. This patch removed the kzallocs from the scan
> code. Some earlier version of the bcma implementation and the normal
> ssb implementation are doing it like this.
> The __bcma_dev_wrapper struct is used as the container for the device
> struct as bcma_device will be too big if it includes struct device.

Does this prevent using list_for_each() and friends to be used on the 
device list? If so, could you consider a different approach. There were 
good reasons to get rid of the bcma_dev_wrapper struct if I recall 
discussions on the mailing list correctly. I also see tendency to use 
ssb solutions without considering alternatives. For this particular 
example, please consider adding a bcma_zalloc(), which does kzalloc for 
non-embedded platforms and returns array pointers for embedded platform. 
You could also consider this behavior for the embedded bus only.

Gr. AvS

-- 
Almost nobody dances sober, unless they happen to be insane.
-- H.P. Lovecraft --
