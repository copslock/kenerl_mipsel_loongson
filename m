Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Mar 2010 18:26:28 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:14933 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492313Ab0CKR0Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Mar 2010 18:26:24 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4b9927c70000>; Thu, 11 Mar 2010 09:26:31 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 11 Mar 2010 09:25:49 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 11 Mar 2010 09:25:49 -0800
Message-ID: <4B992797.4070006@caviumnetworks.com>
Date:   Thu, 11 Mar 2010 09:25:43 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.8) Gecko/20100301 Fedora/3.0.3-1.fc12 Thunderbird/3.0.3
MIME-Version: 1.0
To:     Mikael Starvik <mikael.starvik@axis.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: MIPS raw_local_irq_restore flags
References: <4BEA3FF3CAA35E408EA55C7BE2E61D0546AC862322@xmail3.se.axis.com>
In-Reply-To: <4BEA3FF3CAA35E408EA55C7BE2E61D0546AC862322@xmail3.se.axis.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Mar 2010 17:25:49.0303 (UTC) FILETIME=[E46E8870:01CAC13F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26203
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 03/11/2010 06:59 AM, Mikael Starvik wrote:
> For the common case CONFIG_CPU_MIPSR2&&  CONFIG_IRQ_CPU raw_local_irq_restore_flags is defined as:
>
> "       beqz    \\flags, 1f                                     \n"
> "       di                                                      \n"
> "       ei                                                      \n"
> "1:                                                             \n"
>
> Doesn't this imply that you can't do recursive local_irq_save() (with different locks ofcourse)?
>

No.  In fact local_irq_save() is intentionally designed to be used 
'recursively'.

David Daney
