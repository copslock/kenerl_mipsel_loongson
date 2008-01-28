Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jan 2008 16:36:45 +0000 (GMT)
Received: from fig.raritan.com ([12.144.63.197]:57232 "EHLO fig.raritan.com")
	by ftp.linux-mips.org with ESMTP id S28576678AbYA1Qgh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 28 Jan 2008 16:36:37 +0000
Received: from [192.168.32.206] ([192.168.32.206]) by fig.raritan.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 28 Jan 2008 11:36:24 -0500
Message-ID: <479E0488.7070408@raritan.com>
Date:	Mon, 28 Jan 2008 11:36:24 -0500
From:	Gregor Waltz <gregor.waltz@raritan.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070403)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Toshiba JMR 3927 working setup?
References: <479A134D.7090206@ucsd.edu> <20080126.140802.126142689.anemo@mba.ocn.ne.jp>
In-Reply-To: <20080126.140802.126142689.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Jan 2008 16:36:24.0910 (UTC) FILETIME=[EC334EE0:01C861CB]
Return-Path: <Gregor.Waltz@raritan.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregor.waltz@raritan.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Fri, 25 Jan 2008 08:50:21 -0800, Max Okumoto <okumoto@ucsd.edu> wrote:
>   
>> I have a JMR3927 based system and I got it to work with the 2.6.23.14 kernel, but
>> used 0xff0000 instead of 0xff000.  The offset passed in was 0xfffec000 which isn't
>> within the 0xff000000 - 0xff0ff000.
>>     
>
> Thank you for good news.  (and excuse my double fault...)
>
> Ralf, please apply this to 2.6.23-stable and 2.6.24-stable.
>   

The change does appear to work for me also, however, I still see no 
kernel messages at all. The only way that I can get any output is via 
puts() and prom_putchar() (the latter I put into emit_log_char(char c) 
of printk.c).

I have not gotten past the root mounting stage because I have not 
attached an image yet, which I will try as soon as I get some time again.

Thanks for your help
