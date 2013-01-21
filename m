Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Jan 2013 10:41:29 +0100 (CET)
Received: from mms1.broadcom.com ([216.31.210.17]:3696 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6823732Ab3AUJl153GnU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 Jan 2013 10:41:27 +0100
Received: from [10.9.208.26] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 21 Jan 2013 01:38:57 -0800
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from mail-irva-13.broadcom.com (10.11.16.103) by
 IRVEXCHCAS05.corp.ad.broadcom.com (10.9.208.26) with Microsoft SMTP
 Server id 14.1.355.2; Mon, 21 Jan 2013 01:40:59 -0800
Received: from [10.176.68.30] (unknown [10.176.68.30]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id DCA8340FE4; Mon, 21
 Jan 2013 01:40:57 -0800 (PST)
Message-ID: <50FD0D28.8070905@broadcom.com>
Date:   Mon, 21 Jan 2013 10:40:56 +0100
From:   "Arend van Spriel" <arend@broadcom.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130106
 Thunderbird/17.0.2
MIME-Version: 1.0
To:     "Ralf Baechle" <ralf@linux-mips.org>
cc:     "Sergei Shtylyov" <sshtylyov@mvista.com>,
        linux-mips@linux-mips.org, "Hauke Mehrtens" <hauke@hauke-m.de>
Subject: Re: [PATCH] mips: bcm47xx: select GPIOLIB for BCMA on bcm47xx
 platform
References: <1357323005-28008-1-git-send-email-arend@broadcom.com>
 <50E80F78.9030901@mvista.com> <50E9E914.9030900@broadcom.com>
 <20130116145000.GD26569@linux-mips.org>
In-Reply-To: <20130116145000.GD26569@linux-mips.org>
X-Enigmail-Version: 1.4.6
X-WSS-ID: 7CE3D33B1Z4102130-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arend@broadcom.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 01/16/2013 03:50 PM, Ralf Baechle wrote:
> On Sun, Jan 06, 2013 at 10:13:56PM +0100, Arend van Spriel wrote:
> 
>>>    This change doesn';t seem to be documented in your changelog. Maybe
>>> it's worth another patch?
>>>
>>> WBR, Sergei
>>>
>>
>> Very observant. ;-) Yes. After fixing the other ones I got a warning on
>> that one. I could resubmit the change with a more generic description or
>> split it up as you suggest.
>>
>> Ralf,
>>
>> Please advice.
> 
> For simplicity's sake I'm going to split this myself BUT putting changes
> that are not explained in changelog comments is a good way to get your
> dear maintainer grumpy :)

Thanks, Ralf

Appreciated. Hope you can keep that smile ;-)

Regards,
Arend

>   Ralf
> 
