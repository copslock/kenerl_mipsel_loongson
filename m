Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Apr 2005 18:59:15 +0100 (BST)
Received: from smtp005.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.82]:44155
	"HELO smtp005.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8224851AbVDTR7A>; Wed, 20 Apr 2005 18:59:00 +0100
Received: from unknown (HELO ?192.168.1.100?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp005.bizmail.sc5.yahoo.com with SMTP; 20 Apr 2005 17:58:57 -0000
Message-ID: <42669862.7000405@embeddedalley.com>
Date:	Wed, 20 Apr 2005 10:58:58 -0700
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Clem Taylor <clem.taylor@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: mdelay() from board_setup() [is default value for loops_per_jiffy
 way off?]
References: <ecb4efd10504201050a00f941@mail.gmail.com>
In-Reply-To: <ecb4efd10504201050a00f941@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Clem Taylor wrote:
> Hi,
> 
> I'm working on a linux port for a custom Au1550 based board. Inside of
> board_setup() I need to wait for some hardware to power up. So, I
> called mdelay(), but it seems to wait for far too short a time. It
> seems that loops_per_jiffy still has the default value (4096) in
> board_setup(), the computed value is more like 245248. So, what is the
> proper way to spin wait this early in the startup process? Also, isn't
> the default value for loops_per_jiffy off by quite a bit? I'm running
> the Au1550 at 492MHz, so that would make the default value good for a
> ~8MHz processor?

It's too early in board_setup() to use the standard delay routines. You can't 
use those until after calibrate_delay() runs. To do precise delays in 
board_setup, you'll have to do something yourself where you read the cp0 timer 
periodically and wait a certain amount of time.

Pete
