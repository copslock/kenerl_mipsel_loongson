Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 08:01:37 +0000 (GMT)
Received: from d062149.adsl.hansenet.de ([IPv6:::ffff:80.171.62.149]:16901
	"EHLO gruft.cubic.org") by linux-mips.org with ESMTP
	id <S8226333AbVCVIBV>; Tue, 22 Mar 2005 08:01:21 +0000
Received: from cubic.org (starbase [192.168.10.1])
	by gruft.cubic.org (8.12.2/8.12.2) with ESMTP id j2M81Hm9030651
	for <linux-mips@linux-mips.org>; Tue, 22 Mar 2005 09:01:18 +0100
Message-ID: <423FC900.4010108@cubic.org>
Date:	Tue, 22 Mar 2005 08:28:00 +0100
From:	Michael Stickel <michael@cubic.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
References: <20050319172101.C23907@flint.arm.linux.org.uk> <200503212151.22059.eckhardt@satorlaser.com> <423F3528.4060907@embeddedalley.com> <200503212307.18304.eckhardt@satorlaser.com>
In-Reply-To: <200503212307.18304.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <michael@cubic.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael@cubic.org
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:

>On Monday 21 March 2005 21:57, Pete Popov wrote:
>  
>
>>Ulrich Eckhardt wrote:
>>    
>>
>>>I'd give more details, but I'm neither at work nor did I investigate the
>>>situation properly. What I remember trying is to add 'console=/dev/ttyS0'
>>>or somesuch to the commandline, but couldn't get it to work there.
>>>
Did you try console=ttyS0,*
I also had some problems with the 2.6 release and the serial console.

Michael
