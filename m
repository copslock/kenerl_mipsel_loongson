Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2006 23:30:47 +0100 (BST)
Received: from dmz.mips-uk.com ([194.74.144.194]:48392 "EHLO dmz.mips-uk.com")
	by ftp.linux-mips.org with ESMTP id S20037666AbWIJWap (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 10 Sep 2006 23:30:45 +0100
Received: from dmzgw.mips-uk.com ([194.74.144.193] helo=ukservices1.mips.com)
	by dmz.mips-uk.com with esmtp (Exim 3.35 #1 (Debian))
	id 1GMXox-0000qP-00; Sun, 10 Sep 2006 23:30:35 +0100
Received: from bank.mips.com ([192.168.192.132] helo=[127.0.0.1])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GMXob-0002Kw-00; Sun, 10 Sep 2006 23:30:13 +0100
Message-ID: <450491FA.3010600@mips.com>
Date:	Sun, 10 Sep 2006 23:30:18 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies Inc
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, dan@debian.org, macro@linux-mips.org,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] fast path for rdhwr emulation for TLS
References: <20060711025342.GA6898@nevyn.them.org>	<20060711.122014.52129937.nemoto@toshiba-tops.co.jp>	<4501AABC.1050009@mips.com> <20060909.225641.41198763.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060909.225641.41198763.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12549
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 08 Sep 2006 18:39:08 +0100, Nigel Stephens <nigel@mips.com> wrote:
>   
>>> I asked on GCC bugzilla a few days ago but can not got feedback yet.
>>> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=28126
>>>   
>>>       
>> In spite of the GCC issue, is this patch now at the point where it could
>> be applied, or at least queued?
>>     
>
> GCC 4.2 does not put RDHWR in delay slot now.  Also, there is a
> "hackish fix" to prevent gcc move a RDHWR outside of a conditional
> (from Richard Sandiford).
>
> For kernel side, my patch can be still applied to current git tree as
> is.
>
> But I'm still looking for better solution (silver bullet?) for
> cpu_has_vtag_icache case.
>
> How about something like this (and do not touch tlbex.c)?
>
> 	LEAF(handle_ri_rdhwr_vivt)
> 	.set	push
> 	.set	noat
> 	.set	noreorder
> 	/* check if TLB contains a entry for EPC */
> 	MFC0	K1, CP0_ENTRYHI
> 	andi	k1, ASID_MASK
> 	MFC0	k0, CP0_EPC
> 	andi	k0, PAGE_MASK << 1
> 	or	k1, k0
> 	MTC0	k1, CP0_ENTRYHI
> 	tlbp
> 	mfc0	k1, CP0_INDEX
> 	bltz	k1, handle_ri	/* slow path */
> 	 nop
> 	/* fall thru */
> 	LEAF(handle_ri_rdhwr)
>
> I'm wondering if this could work on CONFIG_MIPS_MT_SMTC case...
>
>   

No, that wouldn't be reliable for CONFIG_MIPS_MT_SMTC, but then again 
the only CPU which currently runs SMTC has VIPT caches

Nigel
