Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 00:09:05 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:26781 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225322AbUCRAJE>; Thu, 18 Mar 2004 00:09:04 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc12) with ESMTP
          id <2004031800085701200ncr5ae>
          (Authid: kumba12345);
          Thu, 18 Mar 2004 00:08:57 +0000
Message-ID: <4058E89B.3010208@gentoo.org>
Date: Wed, 17 Mar 2004 19:08:59 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de> <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl> <4058BC76.9020204@gentoo.org> <Pine.LNX.4.55.0403172202060.14525@jurand.ds.pg.gda.pl> <4058DAE2.8000902@gentoo.org> <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0403180041560.14525@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4569
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>  A simpler workaround (no need to rebuild binutils) might be setting:
> 
> LOADADDR := 0x88010000
> 
> for CONFIG_SGI_IP22 in arch/mips/Makefile.

And/or CONFIG_SGI_IP32.  I've seen the issue appear there as well.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
