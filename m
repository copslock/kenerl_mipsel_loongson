Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Dec 2006 15:48:26 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:50181 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28583461AbWLTPsW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 20 Dec 2006 15:48:22 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 728453EC9; Wed, 20 Dec 2006 07:48:17 -0800 (PST)
Message-ID: <45895B3C.9030204@ru.mvista.com>
Date:	Wed, 20 Dec 2006 18:48:12 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, danieljlaird@hotmail.com,
	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Vitaly Wool <vwool@ru.mvista.com>
Subject: Re: 2.6.19 timer API changes
References: <20061219.233410.25911550.anemo@mba.ocn.ne.jp>	<20061220.000113.59033093.anemo@mba.ocn.ne.jp>	<7949125.post@talk.nabble.com> <20061220.021508.97296486.anemo@mba.ocn.ne.jp> <458948C5.4050909@ru.mvista.com>
In-Reply-To: <458948C5.4050909@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13493
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello, I wrote:

>> +
>> +static void pnx8550_timer_ack(void)
>> +{
>> +    write_c0_compare(cycles_per_jiffy);
>> +}
>> +
>> +static cycle_t pnx8550_hpt_read(void)
>> +{
>> +    /* FIXME: we should use timer2 or timer3 as freerun counter */
>> +    return read_c0_count();
>> +}

>    I'd suggest read_c0_count2() here, possibly adding an interrupt 
> handler for it since it will interrupt upon hitting compare2 reg. value 
> (but we could probably just mask the IRQ off), and enabling the timer 2, 
> of course (the current code disables it)...

    No, we'll have to handle IRQ it once the timer is enabled -- there seems 
to be no provision to mask it off other than disabling the timer.

WBR, Sergei
