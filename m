Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2003 12:11:24 +0100 (BST)
Received: from mx2.mips.com ([IPv6:::ffff:206.31.31.227]:57493 "EHLO
	mx2.mips.com") by linux-mips.org with ESMTP id <S8225230AbTFPLLU>;
	Mon, 16 Jun 2003 12:11:20 +0100
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx2.mips.com (8.12.5/8.12.5) with ESMTP id h5GBB6Ue025101;
	Mon, 16 Jun 2003 04:11:07 -0700 (PDT)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id EAA23960;
	Mon, 16 Jun 2003 04:11:04 -0700 (PDT)
Message-ID: <00da01c333f9$498b11f0$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "He Jin" <thesistarball@yahoo.com.cn>, <linux-mips@linux-mips.org>
References: <20030616093215Z8225220-1272+2626@linux-mips.org>
Subject: Re: bootloader problem
Date: Mon, 16 Jun 2003 13:20:02 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="GB2312"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MIMEOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips


> I met a problem when debuging a bootloader in IT8172G+RM5231A platform, it's like this:
> 
> the bootloader had 2 parts, the first part executes in ROM (0xbfc00000-0xbfc0xxxx) and
> it move another part from ROM into SDRAM, then jump to the SDRAM entry point to continue.
> 
> In the ROM resident code, if I initialized&flushed the cache, it can jump to SDRAM entry
> continue normally. However,if I comment out those cache related code and make cache disabled, 
> it seems can not jump to SDRAM entry. 
> 
> Who can tell me why I must initialize&flush when cache disabled ? 

Precisely what do you mean by "cache disabled",
and what is the address of the SDRAM entry?

            Kevin K.
