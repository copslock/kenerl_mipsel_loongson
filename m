Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Feb 2005 18:13:38 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:62197 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225463AbVBCSNW>; Thu, 3 Feb 2005 18:13:22 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 561EA188B8; Thu,  3 Feb 2005 10:13:21 -0800 (PST)
Message-ID: <420269C1.6050701@mvista.com>
Date:	Thu, 03 Feb 2005 10:13:21 -0800
From:	Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Rojhalat Ibrahim <ibrahim@schenk.isar.de>
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Titan ethernet and little endian
References: <42023C54.7060801@schenk.isar.de>
In-Reply-To: <42023C54.7060801@schenk.isar.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7136
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Rojhalat Ibrahim wrote:

> Hi,
> a while ago I posted the attached patch,
> which makes the titan_ge driver work in
> little-endian mode. I got no reaction
> whatsoever. What did I do wrong?
> Rojhalat Ibrahim
>
>------------------------------------------------------------------------
>
>Index: titan_ge.h
>===================================================================
>RCS file: /home/cvs/linux/drivers/net/titan_ge.h,v
>retrieving revision 1.17
>diff -u -r1.17 titan_ge.h
>--- titan_ge.h	4 Dec 2004 23:42:53 -0000	1.17
>+++ titan_ge.h	10 Jan 2005 12:59:20 -0000
>@@ -153,8 +153,10 @@
> 
> /* Define the Rx descriptor */
> typedef struct eth_rx_desc {
>-	u32	buffer_addr;	/* Buffer address inclusive of checksum */
>-	u32     cmd_sts;	/* Command and Status info */
>+	u32     buffer_addr;	/* CPU buffer address 	*/
>+	u32     reserved;	/* Unused 		*/
>+	u32	buffer;		/* XDMA buffer address	*/
>+	u32	cmd_sts;	/* Command and Status	*/
> } titan_ge_rx_desc;
> 
> /* Define the Tx descriptor */
>  
>
Hi !

So, have you got the titan to work in the LE mode? Are you using the 
Yosemite board? Does this patch break BE?

Please do let us know.

Thanks
Manish Lachwani
