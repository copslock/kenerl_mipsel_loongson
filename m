Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 17:51:01 +0100 (BST)
Received: from adsl-67-116-42-147.dsl.sntc01.pacbell.net ([67.116.42.147]:54806
	"EHLO avtrex.com") by ftp.linux-mips.org with ESMTP
	id S8133658AbVJ1Qun (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 17:50:43 +0100
Received: from [192.168.7.26] ([192.168.7.3]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Fri, 28 Oct 2005 09:50:56 -0700
Message-ID: <436256F0.2000702@avtrex.com>
Date:	Fri, 28 Oct 2005 09:50:56 -0700
From:	David Daney <ddaney@avtrex.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Sathesh Babu Edara <satheshbabu.edara@analog.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Patch file between linux-2.6.12 from kernel.org and linux-2.6.12
 from linux-mips.org
References: <200510281635.j9SGZLrn017834@lilac.hdcindia.analog.com>
In-Reply-To: <200510281635.j9SGZLrn017834@lilac.hdcindia.analog.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Oct 2005 16:50:56.0430 (UTC) FILETIME=[C41C34E0:01C5DBDF]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9377
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Sathesh Babu Edara wrote:
> 
> 
> Hi,
>    Is there any patch file available between  linux-2.6.12 from 
> kernel.org and linux-2.6.12 from linux-mips.org.
> 
Not that I am aware of.  But thankfully we have been given the diff 
command.  Something like 'diff -rNup kernel.org linux-mips.org' should 
do the trick.

Give a man a patch file and he can patch today.  Teach a man to make 
patch files and he can patch for life...

David Daney.
