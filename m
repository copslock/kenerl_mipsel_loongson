Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Dec 2004 22:22:20 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:62192 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225262AbULIWWP>; Thu, 9 Dec 2004 22:22:15 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id AB15E18303; Thu,  9 Dec 2004 14:21:28 -0800 (PST)
Message-ID: <41B8CFE8.7070503@mvista.com>
Date: Thu, 09 Dec 2004 14:21:28 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org, Manish Lachwani <mlachwani@mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: CVS Update@-mips.org: linux
References: <20041209220930Z8225298-1751+3401@linux-mips.org>
In-Reply-To: <20041209220930Z8225298-1751+3401@linux-mips.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6625
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

ralf@linux-mips.org wrote:
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ralf@ftp.linux-mips.org	04/12/09 22:09:24
> 
> Modified files:
> 	arch/mips/sibyte/sb1250: irq_handler.S 
> 
> Log message:
> 	And yet another build fix.
> 
> 

Hi Ralf

There is one more build fix needed in drivers/net/sb1250-mac.c



if (sbmac_init(dev, idx)) {
			port = A_MAC_CHANNEL_BASE(idx);
			SBMAC_WRITECSR(KSEG1ADDR(port+R_MAC_ETHERNET_ADDR),
					sbmac_orig_hwaddr[idx] );
			free_netdev(dev);
			continue;
		}

If you wish, I can send a patch

Thanks
Manish Lachwani
