Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Dec 2004 20:26:09 +0000 (GMT)
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:32263 "EHLO
	sorrow.cyrius.com") by linux-mips.org with ESMTP
	id <S8225242AbULWU0E>; Thu, 23 Dec 2004 20:26:04 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id 4ECE564D40; Thu, 23 Dec 2004 20:25:51 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 26F844FA17; Thu, 23 Dec 2004 20:25:27 +0000 (GMT)
Date: Thu, 23 Dec 2004 20:25:26 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: linux-mips@linux-mips.org
Subject: Re: [PATCH] Further TLB handler optimizations
Message-ID: <20041223202526.GA2254@deprecation.cyrius.com>
References: <20041222215524.GB3539@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041222215524.GB3539@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.6+20040907i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de> [2004-12-22 22:55]:
> The patch was tested on an O200 SMP system with 2 x R12000. Other
> machines are untested. Please test if it still works for you,

It breaks SB1 SWARM.
-- 
Martin Michlmayr
http://www.cyrius.com/
