Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Dec 2006 12:57:59 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:62631 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037578AbWLHM5z (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 8 Dec 2006 12:57:55 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 28A4F3EC9; Fri,  8 Dec 2006 04:57:32 -0800 (PST)
Message-ID: <4579619D.1080903@ru.mvista.com>
Date:	Fri, 08 Dec 2006 15:59:09 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	ashlesha@kenati.com
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: Serial 8250 driver registration:
References: <1165462754.6516.40.camel@sandbar.kenati.com>	 <20061207.131306.63741931.nemoto@toshiba-tops.co.jp>	 <1165534711.6512.10.camel@sandbar.kenati.com>	 <20061208.101112.108306293.nemoto@toshiba-tops.co.jp> <1165543305.6512.17.camel@sandbar.kenati.com>
In-Reply-To: <1165543305.6512.17.camel@sandbar.kenati.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13412
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Ashlesha Shintre wrote:

> Yeah, i thought you might have meant that :-)

> i m starting to think that the uartclk parameter that i pass to the
> platform_add_devices function might be wrong --

> i m passing the standard value of 1843200 for a baudrate of 115200...

    Since it's a standard x86 UART built into the x86 south bridge, it should 
be clocked by the standard 1.8432 MHz clock.

WBR, Sergei
