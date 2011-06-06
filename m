Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2011 12:16:42 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:3705 "EHLO MMS3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490995Ab1FFKQg convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2011 12:16:36 +0200
Received: from [10.9.200.131] by MMS3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.3.2)); Mon, 06 Jun 2011 03:13:48 -0700
X-Server-Uuid: B55A25B1-5D7D-41F8-BC53-C57E7AD3C201
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHHUB01.corp.ad.broadcom.com (10.9.200.131) with Microsoft SMTP
 Server id 8.2.247.2; Mon, 6 Jun 2011 03:09:51 -0700
Received: from mail-sj1-12.sj.broadcom.com (mail-sj1-12.sj.broadcom.com
 [10.17.16.106]) by mail-irva-13.broadcom.com (Postfix) with ESMTP id
 C54E274D03; Mon, 6 Jun 2011 03:09:51 -0700 (PDT)
Received: from [192.168.1.120] (unknown [10.176.68.21]) by
 mail-sj1-12.sj.broadcom.com (Postfix) with ESMTP id E553D20501; Mon, 6
 Jun 2011 03:09:49 -0700 (PDT)
Message-ID: <4DECA76C.90000@broadcom.com>
Date:   Mon, 6 Jun 2011 12:09:48 +0200
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.17)
 Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
cc:     "Hauke Mehrtens" <hauke@hauke-m.de>,
        "Arnd Bergmann" <arnd@arndb.de>, "Greg KH" <greg@kroah.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "mb@bu3sch.de" <mb@bu3sch.de>,
        "george@znau.edu.ua" <george@znau.edu.ua>,
        "b43-dev@lists.infradead.org" <b43-dev@lists.infradead.org>,
        "bernhardloos@googlemail.com" <bernhardloos@googlemail.com>
Subject: Re: [RFC][PATCH 01/10] bcma: Use array to store cores.
References: <1307311658-15853-1-git-send-email-hauke@hauke-m.de>
 <1307311658-15853-2-git-send-email-hauke@hauke-m.de>
 <BANLkTimAPHPcqKKJ+Rphef_+1RB0aHR4ug@mail.gmail.com>
In-Reply-To: <BANLkTimAPHPcqKKJ+Rphef_+1RB0aHR4ug@mail.gmail.com>
X-WSS-ID: 61F277D64NS16610534-01-01
Content-Type: text/plain;
 charset=utf-8;
 format=flowed
Content-Transfer-Encoding: 8BIT
X-archive-position: 30242
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4054

On 06/06/2011 11:42 AM, Rafał Miłecki wrote:
> Greg, Arnd: could you take a look at this patch, please?
>
> With proposed patch we are going back to this ugly array and wrappers hacks.
>
> I was really happy with our final solution, but it seems it's not
> doable for embedded systems...? Is there something better we can do
> about this?

I do agree with Rafał that we should look for another alternative. I 
posted a suggestion earlier regarding this patch. Can anyone tell me 
whether that could prevent need for the array/wrapper hack.

Gr. AvS

-- 
Almost nobody dances sober, unless they happen to be insane.
-- H.P. Lovecraft --
