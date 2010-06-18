Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jun 2010 09:43:11 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:60144 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491768Ab0FRHnH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 18 Jun 2010 09:43:07 +0200
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id o5I7gul2016350;
        Fri, 18 Jun 2010 11:42:56 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id o5I7RfWh004707;
        Fri, 18 Jun 2010 11:27:41 +0400
Message-ID: <4C1B263E.7070906@niisi.msk.ru>
Date:   Fri, 18 Jun 2010 11:54:38 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Jesper Nilsson <jesper@jni.nu>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: MIPS: return after handling coprocessor 2 exception
References: <20100617132554.GB24162@jni.nu> <4C1A57AE.9080706@caviumnetworks.com>
In-Reply-To: <4C1A57AE.9080706@caviumnetworks.com>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
X-archive-position: 27167
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 12658

On 17.06.2010 21:13, David Daney wrote:
> On 06/17/2010 06:25 AM, Jesper Nilsson wrote:
>> Breaking here dropped us to the default code which always sends
>> a SIGILL to the current process, no matter what the CU2 notifier says.
>>
>> Signed-off-by: Jesper Nilsson<jesper@jni.nu>
[...]
>> case 2:
>> raw_notifier_call_chain(&cu2_chain, CU2_EXCEPTION, regs);
>> - break;
>> + return;
>>
>
> What happens when the call chain is empty, and the proper action *is*
> SIGILL?

It's never empty, in fact. The default notifier declared at top of 
traps.c sends SIGILL. The problem that current code is sending SIGILL in 
all cases.

Gleb.
