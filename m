Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Nov 2008 19:10:36 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:56968 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23911832AbYKYTKc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Nov 2008 19:10:32 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492c4d7c0000>; Tue, 25 Nov 2008 14:09:53 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 11:09:46 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 25 Nov 2008 11:09:45 -0800
Message-ID: <492C4D79.4050300@caviumnetworks.com>
Date:	Tue, 25 Nov 2008 11:09:45 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
CC:	linux-ide@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/2] libata: Add three more columns to the ata_timing
 table.
References: <492B56B0.9030409@caviumnetworks.com> <1227577181-30206-1-git-send-email-ddaney@caviumnetworks.com> <492BDB28.8020103@ru.mvista.com> <492C2BCE.60409@caviumnetworks.com> <492C4936.2030305@ru.mvista.com>
In-Reply-To: <492C4936.2030305@ru.mvista.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 25 Nov 2008 19:09:45.0970 (UTC) FILETIME=[61362520:01C94F31]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Sergei Shtylyov wrote:
> David Daney wrote:
> 
>>>   Wrong, -DIOR hold time is 5 ns for MWDMA0 as well as for all other 
>>> modes.
> 
>> Point taken.
> 
>    Besides, I'm not sure how useful that timing could be for the host 
> controller since it's apparently not determined by the host side -- it's 
> for how long the device holds valid data after -DIOR is released IIRC.
> 

Yes, I think you are correct.  This is a property of the device and 
cannot be controlled by the driver, so I will just remove this column in 
the next version of the patch.

David Daney
