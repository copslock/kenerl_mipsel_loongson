Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 23:11:33 +0000 (GMT)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:3564 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225319AbUCQXLc>; Wed, 17 Mar 2004 23:11:32 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (rwcrmhc12) with ESMTP
          id <2004031723105601400jbv7ce>
          (Authid: kumba12345);
          Wed, 17 Mar 2004 23:11:01 +0000
Message-ID: <4058DAE2.8000902@gentoo.org>
Date: Wed, 17 Mar 2004 18:10:26 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de> <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org> <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>  The patch just triggers it.  Previously, the segment's start address as
> set by Linux in a linker script was already aligned to the page size as it
> was defined then.

Hmm, so would removing the patch function as a temporary workaround 
until the real problem is fixed, or not recommended (meaning unbootable 
kernels till it's fixed)?


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
