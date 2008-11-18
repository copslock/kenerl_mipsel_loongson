Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 16:57:15 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:27680 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23748001AbYKRQ5K (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 16:57:10 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4922f3ca0000>; Tue, 18 Nov 2008 11:56:42 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 08:56:40 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 08:56:40 -0800
Message-ID: <4922F3C7.8070408@caviumnetworks.com>
Date:	Tue, 18 Nov 2008 08:56:39 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Chris Rhodin <chris@notav8.com>
CC:	linux-mips@linux-mips.org
Subject: Re: gdb configuration
References: <49229165.80000@notav8.com>
In-Reply-To: <49229165.80000@notav8.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 18 Nov 2008 16:56:40.0118 (UTC) FILETIME=[A0619560:01C9499E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21301
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Chris Rhodin wrote:
> Hi,
> 
> I'm trying to debug 32-bit linux over a serial port with gdb.  I'm able 
> to connect to the target and everything looks good until I examine the 
> registers.  What's there is obviously wrong.  I've examined the stack 
> and found the register data structure.  Each register in this structure 
> is 32 bits.  When I compare the structure to the registers that gdb 
> displays I can see that gdb is expecting each register to occupy 64 
> bits.  I've tried setting "abi", "saved-gpreg-size", and 
> "stack-arg-size" to 32 bits without success.  Can someone point out my 
> obvious mistake?
> 

Please report the exact versions of all the tools you are using.  If you 
are not using gdb 6.8 upgrade to that version and see what happens.

If it still fails, try asking on gdb@sourceware.org

David Daney
