Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 10:16:23 +0000 (GMT)
Received: from rrcs-central-24-123-115-44.biz.rr.com ([IPv6:::ffff:24.123.115.44]:11904
	"EHLO zevion") by linux-mips.org with ESMTP id <S8225341AbTLIKQU>;
	Tue, 9 Dec 2003 10:16:20 +0000
Received: from radium ([192.168.0.20])
	by zevion (8.12.8/8.12.8) with ESMTP id hB9AIwx9012826;
	Tue, 9 Dec 2003 04:18:58 -0600
From: "Lyle Bainbridge" <lyle@zevion.com>
To: "'Dirk Behme'" <dirk.behme@de.bosch.com>,
	<linux-mips@linux-mips.org>
Subject: RE: GCC 3.3.2 and Alchemy AU1100
Date: Tue, 9 Dec 2003 04:16:19 -0600
Message-ID: <000001c3be3d$7d6920b0$1400a8c0@radium>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <3FD59CC1.7030907@de.bosch.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <lyle@zevion.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lyle@zevion.com
Precedence: bulk
X-list: linux-mips

Hi,

I am using GCC 3.3.2 to crosscompile the 2.4.22 kernel for
an Au1500 system under x86 Redhat 9.0 and I use the following
settings with success.

 -mtune=r4600 -mips2 -Wa,--trap

Cheers
Lyle


> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Dirk Behme
> Sent: Tuesday, December 09, 2003 3:58 AM
> To: 'linux-mips@linux-mips.org'
> Subject: Re: GCC 3.3.2 and Alchemy AU1100
> 
> 
> Hamilton, Ian wrote:
> 
> > Hi there.
> > 
> > I'm trying to build software for the AMD AU1100 processor using 
> > version 3.3.2 of the gnu compiler, and I'm having trouble 
> figuring out 
> > the -march, -mtune, etc settings.
> > 
> > Version 2.95 of gcc uses something like -mcpu=r4600, but 
> this doesn't 
> > work with 3.3.2.
> > 
> > I've tried other likely-looking options (e.g. -mips32), but the 
> > compiler fails to assembler instructions like mtc0 and cache.
> > 
> > Has anyone built for the AU1100 using gcc 3.3.2? If so, 
> could you tell 
> > me the cpu options you used please?
> 
> For a VR41xx CPU with GCC 3.3.1 I have used
> 
> -march=r4600 -mips3 -Wa,--trap
> 
> instead of the old
> 
> -mcpu=r4600 -mips2 -Wa,--trap
> 
> Not sure whether this is correct (no test of the output on a 
> target yet), but it compiles.
> 
> 
> 
