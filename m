Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Aug 2007 10:04:57 +0100 (BST)
Received: from p4-3018.uk2net.com ([213.232.92.20]:44810 "EHLO
	p4-3018.uk2net.com") by ftp.linux-mips.org with ESMTP
	id S20022393AbXHXJEs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Aug 2007 10:04:48 +0100
Received: from [192.168.0.100] (f2s.colonel-panic.org [83.67.53.76])
	by p4-3018.uk2net.com (Postfix) with ESMTP id E93A917DDE;
	Fri, 24 Aug 2007 10:04:12 +0100 (BST)
Message-ID: <46CE9F03.7040207@bitbox.co.uk>
Date:	Fri, 24 Aug 2007 10:04:03 +0100
From:	Peter Horton <phorton@bitbox.co.uk>
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
MIME-Version: 1.0
To:	Martin Michlmayr <tbm@cyrius.com>
CC:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips@linux-mips.org
Subject: Re: Tulip driver broken on Cobalt RaQ1 in 2.6
References: <20070823203757.GA25971@deprecation.cyrius.com> <20070824133656.4163c577.yoichi_yuasa@tripeaks.co.jp> <20070824080215.GA31646@deprecation.cyrius.com>
In-Reply-To: <20070824080215.GA31646@deprecation.cyrius.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <phorton@bitbox.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16267
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phorton@bitbox.co.uk
Precedence: bulk
X-list: linux-mips

Martin Michlmayr wrote:
> * Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp> [2007-08-24 13:36]:
>> What error occurs on Raq1?
> 
> There is no error, but I never get a DHCP response:
> 
> Listening on LPF/eth0/00:10:e0:00:27:5c
> Sending on   LPF/eth0/00:10:e0:00:27:5c
> Sending on   Socket/fallback/fallback-net
> DHCPREQUEST on eth0 to 255.255.255.255 port 67
> eth0: Setting full-duplex based on MII#1 link partner capability of 45e1.
> DHCPREQUEST on eth0 to 255.255.255.255 port 67
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 6
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 10
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 14
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 17
> DHCPDISCOVER on eth0 to 255.255.255.255 port 67 interval 7
> No DHCPOFFERS received.
> 

What does /proc/interrupts show after this ?

Does the networking work in CoLo ?

The "PCI retry count" thing is a red herring. There's no device at 06.0 
so that's why you get the message. The kernel used to explicitly skip 
this device when PCI retries were disabled otherwise it would hang. When 
I enabled the PCI retry counter there was no need to skip it, you just 
get the debug.

P.
