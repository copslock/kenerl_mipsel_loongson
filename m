Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Apr 2008 16:48:08 +0100 (BST)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:56209 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20040458AbYDUPsG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 21 Apr 2008 16:48:06 +0100
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id C3CF4318AFC;
	Mon, 21 Apr 2008 15:49:26 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Mon, 21 Apr 2008 15:49:26 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Mon, 21 Apr 2008 08:47:52 -0700
Message-ID: <480CB728.7060402@avtrex.com>
Date:	Mon, 21 Apr 2008 08:47:52 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [MIPS] Fix handling of trap and breakpoint instructions
References: <S20041689AbYDUAiN/20080421003813Z+6727@ftp.linux-mips.org> <20080421.100721.07644724.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20080421.100721.07644724.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 21 Apr 2008 15:47:52.0947 (UTC) FILETIME=[0F3C0430:01C8A3C7]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
>> Author: Ralf Baechle <ralf@linux-mips.org> Sun Apr 20 16:28:54 2008 +0100
>> Commit: 5881bb0de64887a60f7f49922cf73a3b4d40fc01
>> Gitweb: http://www.linux-mips.org/g/linux/5881bb0d
>> Branch: master
> 
> You must drop left shift of this line too.
> 
> 		if (bcode == (BRK_DIVZERO << 10))
> 

Note that there has been some confusion about break codes in gas over 
the years.  Ancient versions (I am not sure which) generated different 
break codes than recent versions.

Before changing it make sure that you don't break existing user space code.

One problem (fixed around 2.4.25 or so) was the integer division by zero 
in user space would result in SIGTRAP instead of SIGFPE.   If you change 
the break code handling you should verify that you don't break this.

David Daney
