Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Jan 2005 19:26:28 +0000 (GMT)
Received: from users.sonicwall.com ([IPv6:::ffff:67.115.118.5]:9020 "EHLO
	us0exb02.us.sonicwall.com") by linux-mips.org with ESMTP
	id <S8225257AbVAMT0W>; Thu, 13 Jan 2005 19:26:22 +0000
Received: from [10.0.15.99] ([10.0.15.99]) by us0exb02.us.sonicwall.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Thu, 13 Jan 2005 11:26:20 -0800
Message-ID: <41E6CB5B.6080303@total-knowledge.com>
Date: Thu, 13 Jan 2005 11:26:19 -0800
From: "Ilya A. Volynets-Evenbakh" <ilya@total-knowledge.com>
Organization: Total Knowledge
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041221
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
CC: linux-mips@linux-mips.org
Subject: Re: O2 and 128Mb
References: <1105602134.10493.23.camel@localhost>	 <41E627F8.3010004@total-knowledge.com> <1105605285.10490.52.camel@localhost>
In-Reply-To: <1105605285.10490.52.camel@localhost>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jan 2005 19:26:20.0220 (UTC) FILETIME=[C28DA7C0:01C4F9A5]
Return-Path: <ilya@total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6905
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@total-knowledge.com
Precedence: bulk
X-list: linux-mips

Please set up serial console, and find out where kernel crashes.
It is pretty obvious that happens before gbefb is initialized, but
after ip32-reset is setup (which sets up timer to blink the LED),
thus should be able to give you some output on serial port.

Oh, and what does it have to do with fact you have 128M of RAM?
Giuseppe Sacco wrote:

>Il giorno mer, 12-01-2005 alle 23:49 -0800, Ilya A. Volynets-Evenbakh ha
>scritto:
>  
>
>>"Cannot boot" is not very good describtion of the problem.
>>
>>    
>>
>
>You are right.
>Arcboot is Debian version 0.3.8.4. I select the stanza arcboot should
>use, with 'setenv OSLoadFilename <stanza>" and the kernel is loaded.
>Then it s ran and the only change I see is the red led blinking. The
>screen messages are:
>
>Loading program segment 1 at 0x80004000, offset=0x4000, size = 0x3df086
>Zeroing memory at 0x803e3086, size = 0x2bf9a
>Starting 32-bit kernel
>
>Bye,
>Giuseppe
>
>
>  
>
