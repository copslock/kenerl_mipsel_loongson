Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Mar 2004 02:54:26 +0000 (GMT)
Received: from sorrow.cyrius.com ([IPv6:::ffff:65.19.161.204]:9990 "EHLO
	sorrow.cyrius.com") by linux-mips.org with ESMTP
	id <S8225314AbUCJCyZ>; Wed, 10 Mar 2004 02:54:25 +0000
Received: by sorrow.cyrius.com (Postfix, from userid 10)
	id B834664D3A; Wed, 10 Mar 2004 02:54:21 +0000 (UTC)
Received: by deprecation.cyrius.com (Postfix, from userid 1000)
	id 64607FEC6; Wed, 10 Mar 2004 02:53:46 +0000 (GMT)
Date: Wed, 10 Mar 2004 02:53:46 +0000
From: Martin Michlmayr <tbm@cyrius.com>
To: Jun Sun <jsun@mvista.com>
Cc: linux-mips@linux-mips.org
Subject: Re: "eth%d" - net dev name in 2.6?
Message-ID: <20040310025346.GA5661@deprecation.cyrius.com>
References: <20040310023308.GU31326@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040310023308.GU31326@mvista.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <tbm@cyrius.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tbm@cyrius.com
Precedence: bulk
X-list: linux-mips

* Jun Sun <jsun@mvista.com> [2004-03-09 18:33]:
> eth%d: SiByte Ethernet at 0x10064000, address: 00-02-4C-FE-0C-B2                
> eth%d: enabling TCP rcv checksum                                                
> 
> Any body has a clue here?  I don't think it is driver's job though ...

I have no idea, but I've seen a similar bug report at
http://bugs.debian.org/234817

-- 
Martin Michlmayr
tbm@cyrius.com
