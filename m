Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jan 2006 13:31:09 +0000 (GMT)
Received: from sccrmhc13.comcast.net ([204.127.202.64]:47020 "EHLO
	sccrmhc13.comcast.net") by ftp.linux-mips.org with ESMTP
	id S8133479AbWAXNaw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 24 Jan 2006 13:30:52 +0000
Received: from [192.168.1.4] (pcp04414054pcs.nrockv01.md.comcast.net[69.140.185.48])
          by comcast.net (sccrmhc13) with ESMTP
          id <200601241335050130014f7pe>; Tue, 24 Jan 2006 13:35:05 +0000
Message-ID: <43D62D06.8040602@gentoo.org>
Date:	Tue, 24 Jan 2006 08:35:02 -0500
From:	Kumba <kumba@gentoo.org>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Add R14K Support (generic)
References: <20060123230424.GA31197@toucan.gentoo.org> <20060124131741.GA3459@linux-mips.org>
In-Reply-To: <20060124131741.GA3459@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10101
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> 
> Afaik it's not as trivial as this.  The R14000 has some changes to the FPU
> which seem to require handling.  I unfortunately know no details.

My guess is a lot of the R14K and R16K details are still protected.  I can't 
find any processor manuals on them.  Hopefully, I'll be able to get a hold of an 
R14K eventually to figure out just how well this patch works (maybe it'll reveal 
enough to see what the FPU does differently).  If only the prices on eVay drop...


--Kumba

-- 
Gentoo/MIPS Team Lead
Gentoo Foundation Board of Trustees

"Such is oft the course of deeds that move the wheels of the world: small hands 
do them because they must, while the eyes of the great are elsewhere."  --Elrond
