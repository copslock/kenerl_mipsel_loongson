Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Mar 2005 23:42:45 +0000 (GMT)
Received: from smtp007.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.170.10]:27000
	"HELO smtp007.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224917AbVCTXma>; Sun, 20 Mar 2005 23:42:30 +0000
Received: from unknown (HELO ?192.168.1.102?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp007.bizmail.sc5.yahoo.com with SMTP; 20 Mar 2005 23:42:27 -0000
Message-ID: <423E0A63.7050802@embeddedalley.com>
Date:	Sun, 20 Mar 2005 15:42:27 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Russell King <rmk+lkml@arm.linux.org.uk>
CC:	Ralf Baechle <ralf@linux-mips.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
References: <20050319172101.C23907@flint.arm.linux.org.uk> <20050319141351.74f6b2a5.akpm@osdl.org> <20050320224028.GB6727@linux-mips.org> <423DFE7C.7040406@embeddedalley.com> <20050320232438.B31657@flint.arm.linux.org.uk>
In-Reply-To: <20050320232438.B31657@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Russell King wrote:
> On Sun, Mar 20, 2005 at 02:51:40PM -0800, Pete Popov wrote:
> 
>>>>>- __register_serial, register_serial, unregister_serial
>>>>> (this driver doesn't support PCMCIA cards, all of which are based on
>>>>>  8250-compatible devices.)
>>
>>I tried a couple of times to cleanly add support to the 8250 for the Au1x 
>>serial. The uart is just different enough to make that hard, though I admit I 
>>never spent too much time on it. Sounds like it's time to revisit it again.
> 
> 
> I would prefer to have a patch to remove (or ack to do so myself) the
> above three mentioned functions so I can avoid breaking your driver,
> rather than a large update to it.

Go for it. I'll test the driver afterwards and think about getting it into the 
8250 again.

Thanks,

Pete
