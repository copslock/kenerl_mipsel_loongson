Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 20:57:28 +0000 (GMT)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:3988
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8225002AbVCUU5N>; Mon, 21 Mar 2005 20:57:13 +0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 21 Mar 2005 20:57:11 -0000
Message-ID: <423F3528.4060907@embeddedalley.com>
Date:	Mon, 21 Mar 2005 12:57:12 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ulrich Eckhardt <eckhardt@satorlaser.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050320224028.GB6727@linux-mips.org> <423DFE7C.7040406@embeddedalley.com> <200503212151.22059.eckhardt@satorlaser.com>
In-Reply-To: <200503212151.22059.eckhardt@satorlaser.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7490
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Ulrich Eckhardt wrote:
> On Sunday 20 March 2005 23:51, Pete Popov wrote:
> 
>>It works and no one has complained about any bugs. 
> 
> 
> I hereby do complain that it doesn't work. ;)
> 
> I'd give more details, but I'm neither at work nor did I investigate the 
> situation properly. What I remember trying is to add 'console=/dev/ttyS0' or 
> somesuch to the commandline, but couldn't get it to work there. 

Well, come on, I know that much works :) Which board and kernel rev?

Pete

> The funny 
> thing is that when I use the GDB support over serial line (which seems to use 
> a primitive, stripped-down version of a serial driver) it works, I can then 
> redirect boot messages via 'console=gdb'.
> 
> Uli
> 
> 
