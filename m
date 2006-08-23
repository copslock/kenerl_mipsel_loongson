Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Aug 2006 17:52:47 +0100 (BST)
Received: from mx.mips.com ([63.167.95.198]:40901 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20037647AbWHWQwn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Aug 2006 17:52:43 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k7NGqU0u021188;
	Wed, 23 Aug 2006 09:52:30 -0700 (PDT)
Received: from ukservices1.mips.com (ukservices1 [192.168.192.240])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k7NGqahk025741;
	Wed, 23 Aug 2006 09:52:36 -0700 (PDT)
Received: from highbury.mips.com ([192.168.192.236])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1GFvxq-0001kb-00; Wed, 23 Aug 2006 17:52:26 +0100
Message-ID: <44EC87C9.8010402@mips.com>
Date:	Wed, 23 Aug 2006 17:52:25 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Thunderbird 1.5.0.2 (X11/20060501)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH] fix cache coherency issues
References: <20060214.011508.41198724.anemo@mba.ocn.ne.jp>	<20060523.003424.104640954.anemo@mba.ocn.ne.jp> <20060824.003130.25910593.anemo@mba.ocn.ne.jp>
In-Reply-To: <20060824.003130.25910593.anemo@mba.ocn.ne.jp>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Atsushi Nemoto wrote:
>
> +	unsigned int tlbidx;
>
>   
...

> +	if (tlbidx < 0)
>   

Doesn't tlbidx need to be declared as a signed int, else the compiler
could optimize away this comparison.


Nigel
