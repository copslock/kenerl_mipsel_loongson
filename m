Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2008 01:41:26 +0100 (BST)
Received: from smtp.sprintpcs.com ([68.28.27.84]:47236 "EHLO
	mta02.smtp.sprintpcs.com") by ftp.linux-mips.org with ESMTP
	id S20024779AbYEIAlX (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 9 May 2008 01:41:23 +0100
Received: from [192.168.1.100] ([67.169.24.75])
 by lswsmta02.nmcc.sprintspectrum.com
 (iPlanet Messaging Server 5.2 HotFix 2.06 (built Mar 28 2005))
 with ESMTPA id <0K0K007QGSKCCS@lswsmta02.nmcc.sprintspectrum.com> for
 linux-mips@linux-mips.org; Thu, 08 May 2008 19:41:01 -0500 (CDT)
Date:	Thu, 08 May 2008 17:41:02 -0700
From:	David VomLehn <vomlehn@texas.net>
Subject: Re: Alchemy DB1200: do_cpu()
To:	abhiruchi.g@vaultinfo.com
Cc:	linux-mips@linux-mips.org
Message-id: <48239D9E.8040207@texas.net>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 7BIT
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
Return-Path: <vomlehn@texas.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19170
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vomlehn@texas.net
Precedence: bulk
X-list: linux-mips

>
> I am not able to find out:
>
>   From which function and which file "do_cpu()" is called?
Look in arch/mips/entry.S, line 414, or so. The assembler macro 
BUILD_HANDLER is used to create a function named handle_cpu, which does 
a jump to do_cpu.

-- 
David VomLehn         +1 512-297-7814
vomlehn@texas.net
