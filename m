Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Mar 2004 21:00:46 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:2285 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225315AbUCQVAo>; Wed, 17 Mar 2004 21:00:44 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc12) with ESMTP
          id <2004031721003701200nb8spe>
          (Authid: kumba12345);
          Wed, 17 Mar 2004 21:00:37 +0000
Message-ID: <4058BC76.9020204@gentoo.org>
Date: Wed, 17 Mar 2004 16:00:38 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: 2.4 kernels + >=binutils-2.14.90.0.8
References: <404D0132.3020202@gentoo.org> <20040308234450.GF16163@rembrandt.csv.ica.uni-stuttgart.de> <404D0A18.6050802@gentoo.org> <20040309003447.GH16163@rembrandt.csv.ica.uni-stuttgart.de> <404D1909.1020005@gentoo.org> <20040309013841.GI16163@rembrandt.csv.ica.uni-stuttgart.de> <404D28B1.4010608@gentoo.org> <20040309023737.GJ16163@rembrandt.csv.ica.uni-stuttgart.de> <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.55.0403171829130.14525@jurand.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:

>  It looks like a bug somewhere in binutils, probably BFD.  The segment's
> start address should be rounded up to 0x8010000, not down to 0x8000000.

Well, I did test removing the patch Thiemo mentioned 
(http://sources.redhat.com/ml/binutils/2003-12/msg00380.html), and 
rebuilding a kernel, and now they boot.  I tested a 2.4.25 on an Indy, 
and 2.6.4 on an O2.  Perhaps a bug in this specific patch?


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
