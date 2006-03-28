Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Mar 2006 15:17:45 +0100 (BST)
Received: from fw01.bwg.de ([213.144.14.242]:56118 "EHLO fw01.bwg.de")
	by ftp.linux-mips.org with ESMTP id S8126480AbWC1ORh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 28 Mar 2006 15:17:37 +0100
Received: from fw01.bwg.de (localhost [127.0.0.1])
	by fw01.bwg.de (8.13.3/8.13.3) with ESMTP id k2SES4AC013870
	for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 16:28:04 +0200 (CEST)
Received: from kundenmail (193.47.152.5) by fw01-4.bwg.de (smtprelay) with ESMTP Tue Mar 28 16:27:53 2006.
Received: from ximap.arbeitsgruppe (217.81.172.162)
          by kundenmail with MERCUR Mailserver (v4.03.15 MTI1LTI0MzctNDg3Nw==)
          for <linux-mips@linux-mips.org>; Tue, 28 Mar 2006 16:29:22 +0200
Received: from [192.168.178.44] (rr-2600 [192.168.178.44])
	by ximap.arbeitsgruppe (Postfix) with ESMTP
	id 28020174B2E; Tue, 28 Mar 2006 16:28:23 +0200 (CEST)
Message-ID: <442947E7.2000105@rw-gmbh.de>
Date:	Tue, 28 Mar 2006 16:27:51 +0200
From:	=?ISO-8859-15?Q?Ralf_R=F6sch?= <ralf.roesch@rw-gmbh.de>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: Assember error in arch/mips/kernel/r4k_switch.S / latest git
 2.6.16
References: <44292D57.3060400@rw-gmbh.de> <20060328.223659.07643634.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060328.223659.07643634.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <ralf.roesch@rw-gmbh.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10959
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf.roesch@rw-gmbh.de
Precedence: bulk
X-list: linux-mips

Atshuhi, thanks a lot, this solved my problem.

--
Ralf  Rösch

Atsushi Nemoto schrieb:
>
>> Since a few days I have following compiler / assembler problem:
>>     
>
> Try a patch I posted yesterday:
>
>   
>> Subject: [PATCH] Fix sed regexp to generate asm-offset.h
>>     
>
> ---
> Atsushi Nemoto
>
>   
