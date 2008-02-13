Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Feb 2008 17:31:53 +0000 (GMT)
Received: from smtp1.dnsmadeeasy.com ([205.234.170.144]:8872 "EHLO
	smtp1.dnsmadeeasy.com") by ftp.linux-mips.org with ESMTP
	id S20025498AbYBMRbp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 13 Feb 2008 17:31:45 +0000
Received: from smtp1.dnsmadeeasy.com (localhost [127.0.0.1])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP id 9BBFB313D31;
	Wed, 13 Feb 2008 17:31:44 +0000 (UTC)
X-Authenticated-Name: js.dnsmadeeasy
X-Transit-System: In case of SPAM please contact abuse@dnsmadeeasy.com
Received: from avtrex.com (unknown [67.116.42.147])
	by smtp1.dnsmadeeasy.com (Postfix) with ESMTP;
	Wed, 13 Feb 2008 17:31:44 +0000 (UTC)
Received: from dl2.hq2.avtrex.com ([192.168.7.26]) by avtrex.com with Microsoft SMTPSVC(6.0.3790.1830);
	 Wed, 13 Feb 2008 09:31:30 -0800
Message-ID: <47B32971.1000509@avtrex.com>
Date:	Wed, 13 Feb 2008 09:31:29 -0800
From:	David Daney <ddaney@avtrex.com>
User-Agent: Thunderbird 2.0.0.9 (X11/20071115)
MIME-Version: 1.0
To:	Matteo Croce <technoboy85@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: Can't execute any MIPS  binary
References: <200802130034.25052.rootkit85@yahoo.it> <47B231AD.5050809@avtrex.com> <200802131721.11392.technoboy85@gmail.com>
In-Reply-To: <200802131721.11392.technoboy85@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Feb 2008 17:31:30.0759 (UTC) FILETIME=[453FD570:01C86E66]
Return-Path: <ddaney@avtrex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@avtrex.com
Precedence: bulk
X-list: linux-mips

Matteo Croce wrote:
> Il Wednesday 13 February 2008 00:54:21 hai scritto:
>> You should be able to run the binary if run a binary editor on it and 
>> clear the mips32 flag (i.e. change the flags from 0x50001007 to just 
>> 0x1007).
> 
> Solved by changing flags from 0x50001007 to 0x5, thanks :)

I think that you only want to clear the mips32 part (that is the part 
keeping the elf exec from working).  I would leave all the other bits as 
they were.

In other words, probably the flags should be 0x1007, instead of 0x5.

Although it may not really matter.  It has been several years since I 
studied the code.

David Daney
