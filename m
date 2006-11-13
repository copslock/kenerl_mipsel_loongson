Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Nov 2006 13:43:28 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:18444 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038444AbWKMNnX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 13 Nov 2006 13:43:23 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 802913EBE; Mon, 13 Nov 2006 05:43:16 -0800 (PST)
Message-ID: <455876D7.2010501@ru.mvista.com>
Date:	Mon, 13 Nov 2006 16:44:55 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] mips hpt cleanup: make clocksource_mips public
References: <20061112.001028.41198601.anemo@mba.ocn.ne.jp>	<455774BD.6010706@ru.mvista.com> <20061113.223800.98359482.anemo@mba.ocn.ne.jp>
In-Reply-To: <20061113.223800.98359482.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Atsushi Nemoto wrote:

>>>-		mips_hpt_read = dec_ioasic_hpt_read;
>>>+		clocksource_mips.read = dec_ioasic_hpt_read;
>>
>>    I'd like to see clocksource_mips.name overriden there as well.

    And also I forgot about that clocksource continuity thing: TX3927 and 
other clocksource making use of jiffies should not be considered countinous. 
This is not an issue though, till GENERIC_CLOCKEVENTS are ported to these 
platforms...

> Yes now it is possible without touching generic code.  You can do it
> if you wanted.  I do not have strong feeling for custom name :)

   Well, it seems Ralf wants this to be converted into serveral clocksources 
eventually...

> ---
> Atsushi Nemoto

WBR, Sergei
