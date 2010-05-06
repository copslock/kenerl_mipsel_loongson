Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 May 2010 13:25:23 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:56297 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492290Ab0EFLZS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 May 2010 13:25:18 +0200
Received: by wyi11 with SMTP id 11so201414wyi.36
        for <multiple recipients>; Thu, 06 May 2010 04:25:13 -0700 (PDT)
Received: by 10.227.152.76 with SMTP id f12mr4098822wbw.54.1273145113042;
        Thu, 06 May 2010 04:25:13 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-77-53-176.pppoe.mtu-net.ru [91.77.53.176])
        by mx.google.com with ESMTPS id u8sm6657904wbc.17.2010.05.06.04.25.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 06 May 2010 04:25:12 -0700 (PDT)
Message-ID: <4BE2A6EE.80705@mvista.com>
Date:   Thu, 06 May 2010 15:24:30 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@paralogos.com>
CC:     Atsushi Nemoto <anemo@mba.ocn.ne.jp>, ralf@linux-mips.org,
        mcdonald.shane@gmail.com, linux-mips@linux-mips.org
Subject: Re: [MIPS] FPU emulator: allow Cause bits of FCSR to be writeable
 by ctc1
References: <4BE122D1.3000609@paralogos.com>    <20100505091159.GA4016@linux-mips.org>  <4BE19214.4010209@paralogos.com> <20100506.012240.118951273.anemo@mba.ocn.ne.jp> <4BE1C4EA.1020202@paralogos.com>
In-Reply-To: <4BE1C4EA.1020202@paralogos.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26624
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Kevin D. Kissell wrote:

> I'm cool with the patch as is, but in the general spirit of regarding 
> numeric constants other than 0 and 1 as instruments of Satan, it would 
> probably be even better if those reserved bits were defined 
> (FPU_CSR_RSVD, or whatever is compatible with existing convention for 
> such bits) along with the other FCSR bit masks in mipsregs.h, so that 
> the assigment looks like:
>
>          ctx->fcr31 = (value & ~(FPU_CSR_RSVD | 0x3)) |
>                   ieee_rm[value & 0x3];

   0x3 is still neither 0 nor 1, and so remains an instrument of Satan. 
How about #defining it also? :-)

WBR, Sergei
