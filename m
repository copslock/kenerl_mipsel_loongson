Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 21:04:19 +0000 (GMT)
Received: from embeddededge.com ([IPv6:::ffff:209.113.146.155]:45578 "EHLO
	penguin.netx4.com") by linux-mips.org with ESMTP
	id <S8227299AbVCVVEE>; Tue, 22 Mar 2005 21:04:04 +0000
Received: from [192.168.253.28] (tibook.embeddededge.com [192.168.253.28])
	by penguin.netx4.com (8.12.8/8.12.9) with ESMTP id j2ML2FPt013344;
	Tue, 22 Mar 2005 16:02:15 -0500
In-Reply-To: <42404E2E.1030207@romat.com>
References: <42404E2E.1030207@romat.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <62642b91fa50ac5f881ed8fa9400deed@embeddededge.com>
Content-Transfer-Encoding: 7bit
Cc:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
From:	Dan Malek <dan@embeddededge.com>
Subject: Re: Gigabit Ethernet
Date:	Tue, 22 Mar 2005 16:04:13 -0500
To:	Gilad Rom <gilad@romat.com>
X-Mailer: Apple Mail (2.619.2)
Return-Path: <dan@embeddededge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddededge.com
Precedence: bulk
X-list: linux-mips


On Mar 22, 2005, at 11:56 AM, Gilad Rom wrote:

> Has anyone ever tried using a Gigabit PCI
> adapter with one of the Au1x00 boards? Any success?

Just remember that the Au1x00 boards are 32-bit , 33 MHz,
3.3V PCI, so choose your boards accordingly.  Please don't
expect the Au1x00 to run the TCP/IP stack anywhere
near Gigabit speeds ..... :-)  Read the networking
mailing lists for the actual performance of various
systems at these network speeds.

Thanks.

	-- Dan
