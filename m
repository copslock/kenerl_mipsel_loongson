Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Mar 2005 17:23:14 +0000 (GMT)
Received: from extgw-uk.mips.com ([IPv6:::ffff:62.254.210.129]:18974 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225346AbVCKRWt>; Fri, 11 Mar 2005 17:22:49 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id j2BHMT2F011803;
	Fri, 11 Mar 2005 17:22:29 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.1/8.13.1/Submit) id j2BHMSrb011802;
	Fri, 11 Mar 2005 17:22:28 GMT
Date:	Fri, 11 Mar 2005 17:22:28 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Manish Lachwani <mlachwani@mvista.com>
Cc:	Alan Cox <alan@lxorguk.ukuu.org.uk>, Rishabh@soc-soft.com,
	linux-mips@linux-mips.org
Subject: Re: Memory Management HAndling
Message-ID: <20050311172228.GA6407@linux-mips.org>
References: <4BF47D56A0DD2346A1B8D622C5C5902C61E22B@soc-mail.soc-soft.com> <1110548190.15943.46.camel@localhost.localdomain> <20050311155924.GD5958@linux-mips.org> <4231D022.9050604@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4231D022.9050604@mvista.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7424
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Mar 11, 2005 at 09:06:42AM -0800, Manish Lachwani wrote:

> Right, I had the 2.4.21 HIGHMEM working on PMC-Sierra Yosemite. Also, at 
> that time, Sibyte supported HIGHMEM.

It's going to work for any CPU that doesn't have cache aliases.

  Ralf
