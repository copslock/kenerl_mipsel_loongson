Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2005 23:14:11 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:32018 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225552AbVFWWNu>;
	Thu, 23 Jun 2005 23:13:50 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1DlaDw-0001e1-00; Thu, 23 Jun 2005 23:31:04 +0100
Received: from kingsx.mips.com ([192.168.192.254] helo=[127.0.0.1])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1DlZvq-0003vj-00; Thu, 23 Jun 2005 23:12:22 +0100
Message-ID: <42BB33C6.7010707@mips.com>
Date:	Thu, 23 Jun 2005 23:12:22 +0100
From:	Nigel Stephens <nigel@mips.com>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	rolf liu <rolfliu@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: which 2.6 kernel can be run on db1550?
References: <2db32b72050623133731f7b098@mail.gmail.com>	 <ecb4efd1050623144816f7f528@mail.gmail.com> <2db32b72050623150411886bbd@mail.gmail.com>
In-Reply-To: <2db32b72050623150411886bbd@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.809,
	required 4, AWL, BAYES_00)
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



rolf liu wrote:

>Thanks very much for the information.
>
>SDE is the toolchain from mips, which is based on gcc 2.96.
>
>  
>

Just a quick warning that you should not be using the "SDE lite" package 
to build a Linux kernel. For that you need the Linux configuration of 
the toolchain, which is described here 
http://www.linux-mips.org/wiki/Toolchains#MIPS_SDE
