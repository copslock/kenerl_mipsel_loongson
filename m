Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Mar 2004 13:54:30 +0000 (GMT)
Received: from [IPv6:::ffff:145.253.187.130] ([IPv6:::ffff:145.253.187.130]:17924
	"EHLO proxy.baslerweb.com") by linux-mips.org with ESMTP
	id <S8225255AbUCZNy3>; Fri, 26 Mar 2004 13:54:29 +0000
Received: from comm1.baslerweb.com ([172.16.13.2]) by proxy.baslerweb.com
          (Post.Office MTA v3.5.3 release 223 ID# 0-0U10L2S100V35)
          with ESMTP id com; Fri, 26 Mar 2004 14:54:29 +0100
Received: from 172.16.13.253 (localhost [172.16.13.253]) by comm1.baslerweb.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2657.72)
	id H3NK0ZWS; Fri, 26 Mar 2004 14:54:24 +0100
From: Thomas Koeller <thomas.koeller@baslerweb.com>
Organization: Basler AG
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Subject: Re: linker script problem
Date: Fri, 26 Mar 2004 14:55:38 +0100
User-Agent: KMail/1.5.2
Cc: linux-mips@linux-mips.org
References: <200403261349.41783.thomas.koeller@baslerweb.com> <20040326125704.GF9524@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20040326125704.GF9524@rembrandt.csv.ica.uni-stuttgart.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403261455.38960.thomas.koeller@baslerweb.com>
Return-Path: <thomas.koeller@baslerweb.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.koeller@baslerweb.com
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:
> You haven't told what target you are compiling for. LOADADDR should
> be defined in arch/mips*/Makefile for every subarchitecture.

Thanks for the hint. My target is the PMC-Sierra Yosemite evaluation
board. I found that this board has no entry in arch/mips/Makefile,
which explains why LOADADDR is unset. Can you point me at some useful
information about how to choose a sensible load address? Will the RAM
base address do?

Btw. if I get this right and want to contribute a patch, what are the
rules for doing so? Would I need to provide some legal stuff (copyright
assignment) first?

tk
-- 
--------------------------------------------------

Thomas Koeller, Software Development
Basler Vision Technologies

thomas dot koeller at baslerweb dot com
http://www.baslerweb.com

==============================
