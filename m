Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Mar 2004 06:07:38 +0000 (GMT)
Received: from sccrmhc13.comcast.net ([IPv6:::ffff:204.127.202.64]:48037 "EHLO
	sccrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225198AbUCIGHh>; Tue, 9 Mar 2004 06:07:37 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc13) with ESMTP
          id <20040309060732016004je32e>
          (Authid: kumba12345);
          Tue, 9 Mar 2004 06:07:32 +0000
Message-ID: <404D6008.9060900@gentoo.org>
Date: Tue, 09 Mar 2004 01:11:20 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309040919.GA11345@linux-mips.org>
In-Reply-To: <20040309040919.GA11345@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4515
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

> PAX can't be fully supported on MIPS anyway; the architecture doesn't
> have a no-exec flag in it's pages.
> 
> PAX docs are bullshit btw.  execution proection doesn't require a split TLB
> and anyway, the MIPS uTLBs are split.
> 
>   Ralf

I'm aware of the inability to fully support PaX on mips.  It does give 
some support, mainly in the Address Space Layout Randomization bit, so 
it's better than nothing, imho.  The binutils patch for this support in 
gentoo isn't targetted at mips anyways, it's applied for all the 
supported architectures.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
