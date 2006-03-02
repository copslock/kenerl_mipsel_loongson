Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Mar 2006 17:02:44 +0000 (GMT)
Received: from mail8.fw-bc.sony.com ([160.33.98.75]:47869 "EHLO
	mail8.fw-bc.sony.com") by ftp.linux-mips.org with ESMTP
	id S8133799AbWCBRCa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 2 Mar 2006 17:02:30 +0000
Received: from mail3.sjc.in.sel.sony.com (mail3.sjc.in.sel.sony.com [43.134.1.211])
	by mail8.fw-bc.sony.com (8.12.11/8.12.11) with ESMTP id k22HAHBF009283;
	Thu, 2 Mar 2006 17:10:18 GMT
Received: from [192.168.1.10] ([43.134.85.105])
	by mail3.sjc.in.sel.sony.com (8.12.11/8.12.11) with ESMTP id k22HAHMr018391;
	Thu, 2 Mar 2006 17:10:17 GMT
Message-ID: <440726F9.7090000@am.sony.com>
Date:	Thu, 02 Mar 2006 09:10:17 -0800
From:	Geoff Levand <geoffrey.levand@am.sony.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Geert Uytterhoeven <geert@linux-m68k.org>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: DDB5074 and DDB5476 eval boards
References: <20060302161136.GA12460@linux-mips.org> <Pine.LNX.4.62.0603021717360.22852@pademelon.sonytel.be> <20060302162942.GB8487@linux-mips.org>
In-Reply-To: <20060302162942.GB8487@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <geoffrey.levand@am.sony.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10724
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoffrey.levand@am.sony.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Mar 02, 2006 at 05:18:59PM +0100, Geert Uytterhoeven wrote:
> 
>> On Thu, 2 Mar 2006, Ralf Baechle wrote:
>> > Both boards don't compile anymore since include/linux/kbd_ll.h was removed
>> > and nobody did complain making them perfect candidates for somebody who
>> > either wants to take over maintenance or alternatively, removal of the
>> > code.  Anybody still interested?
>> 
>> Since I finally moved last week, I hope to have more spare time in the future
>> and revive my DDB5074. So please don't remove it yet.
> 
> If anything I'd be planning to remove the code after 2.6.17 has been
> released which would leave several months.  But of course until then
> you and Peter De Schrijver who also raised his hand for the DDB5074
> will have fixed things ;-)
> 
> Any takers for the DDB5476?
> 

I have a DDB5476, and if someone wants to maintain the code, can help
with testing, etc.  I was just thinking of throwing it in the trash a
week or so ago...

-Geoff
