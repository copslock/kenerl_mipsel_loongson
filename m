Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2005 19:30:23 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:32272 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8225351AbVAUTaS>; Fri, 21 Jan 2005 19:30:18 +0000
Received: from [10.1.100.52] (mail.chipsandsystems.com [64.164.196.27])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j0LJCSfA012497;
	Fri, 21 Jan 2005 14:12:29 -0500
In-Reply-To: <ecb4efd1050121112268e163ba@mail.gmail.com>
References: <ecb4efd10501210949db48ce1@mail.gmail.com> <ecb4efd1050121112268e163ba@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <DF642A6E-6BE2-11D9-B764-003065F9B7DC@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: CONFIG_PM depends on CONFIG_MACH_AU1X00?
Date:	Fri, 21 Jan 2005 11:30:13 -0800
To:	Clem Taylor <clem.taylor@gmail.com>
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6984
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Jan 21, 2005, at 11:22 AM, Clem Taylor wrote:

> I guess I should recompile after making a change to a Kconfig file. It
> turns out that the arch/mips/au1000/common/irq.c code doesn't compile
> for the Au1550 with CONFIG_PM defined.

Ooops.  I guess I haven't done this for 2.6.  I'll add it to my list of
things to look into.

Thanks.


	-- Dan
