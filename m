Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Mar 2005 18:47:17 +0000 (GMT)
Received: from smtp006.bizmail.sc5.yahoo.com ([IPv6:::ffff:66.163.175.83]:31358
	"HELO smtp006.bizmail.sc5.yahoo.com") by linux-mips.org with SMTP
	id <S8227126AbVCVSrC>; Tue, 22 Mar 2005 18:47:02 +0000
Received: from unknown (HELO ?192.168.1.101?) (ppopov@embeddedalley.com@63.194.214.47 with plain)
  by smtp006.bizmail.sc5.yahoo.com with SMTP; 22 Mar 2005 18:47:00 -0000
Message-ID: <42406826.2040302@embeddedalley.com>
Date:	Tue, 22 Mar 2005 10:47:02 -0800
From:	Pete Popov <ppopov@embeddedalley.com>
Reply-To:  ppopov@embeddedalley.com
Organization: Embedded Alley Solutions, Inc
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20041020
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Gilad Rom <gilad@romat.com>
CC:	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Au1500 and 1Gbps
References: <42406706.90409@romat.com>
In-Reply-To: <42406706.90409@romat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

Gilad Rom wrote:
> Hello,
> 
> As a follow up to my last posting, I was wondering if anyone
> ever actually benchmarked the Au1500 in terms of networking
> throughput.
> 
> We make a custom board, based on the Au1500. 100Mbps
> performance is 100% (100Mbps FTP transfers when using brctl to bridge
> both ethernet MAC's), but What we would like to do, ultimately,
> is build a board with two Gigabit MAC/PHY's and use our board
> to construct a much more powerful gateway.
> 
> Any insight? can the Au1500 even try to handle 1000Mbps?

Should be easy to get up and running the benchmarked. The Intel 1G driver 
(e100?) should run fine on mips with, hopefully, little or no modifications.

Pete
