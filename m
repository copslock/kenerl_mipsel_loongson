Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Nov 2004 22:24:47 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:18418 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225005AbUKXWYm>; Wed, 24 Nov 2004 22:24:42 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 7116F186C2; Wed, 24 Nov 2004 14:24:40 -0800 (PST)
Message-ID: <41A50A28.8060007@mvista.com>
Date: Wed, 24 Nov 2004 14:24:40 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: [PATCH] Synthesize TLB refill handler at runtime
References: <20041121170242.GR20986@rembrandt.csv.ica.uni-stuttgart.de> <Pine.GSO.4.61.0411212048520.26374@waterleaf.sonytel.be> <20041121203757.GS20986@rembrandt.csv.ica.uni-stuttgart.de> <20041122070117.GB25433@linux-mips.org>
In-Reply-To: <20041122070117.GB25433@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6444
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Nov 21, 2004 at 09:37:57PM +0100, Thiemo Seufer wrote:
> 
> 
>>Aww, fatal error in the spelling module. :-)
>>Updated.
> 
> 
> The patch was looking good, so I gave it a shot on one of my machines also
> and it was working fine, applied.
> 
> Thanks!
> 
>   Ralf
> 
Hello !

FYI, I have also tried this patch on Broadcom Sibyte (SWARM board) and 
PMC Rm79XX (Rm9000 core on Ocelot-3) and it has worked well.

Thanks
Manish Lachwani
