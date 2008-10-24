Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 23:23:18 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:9298 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22319257AbYJXWXG (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 23:23:06 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49024aba0000>; Fri, 24 Oct 2008 18:22:50 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 15:22:48 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 24 Oct 2008 15:22:48 -0700
Message-ID: <49024AB8.4090301@caviumnetworks.com>
Date:	Fri, 24 Oct 2008 15:22:48 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: Question about rdhwr emulation.
References: <48FE7BEB.80906@caviumnetworks.com> <alpine.LFD.1.10.0810220218310.29554@ftp.linux-mips.org> <20081024215904.GM25297@linux-mips.org>
In-Reply-To: <20081024215904.GM25297@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 24 Oct 2008 22:22:48.0448 (UTC) FILETIME=[0BB00800:01C93627]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20962
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Oct 22, 2008 at 02:35:21AM +0100, Maciej W. Rozycki wrote:
> 
>>  This probe is necessary, because for a VIVT I-cache, code from there may 
>> be executed even if there is no mapping stored for the virtual address of 
>> the instruction in the TLB anymore.  However this trap handler wants to 
>> read the instruction word from the memory and obviously this goes through 
>> the D-cache which is not virtually tagged.  As such a TLB refill exception 
>> would happen if the mapping was indeed absent.
>>
>>  However, please note that this piece of code runs at the exception level 
>> and therefore such a scenario would qualify as a nested exception.  Which 
>> means the general exception vector would be used and the TLBL or TLBS 
>> handler invoked as appropriate.  Neither of which are currently prepared 
>> to do a refill.  Changing that would be rather trivial as it boils down to 
>> checking the value of cp0.index.p and executiong TLBWR rather than TLBWI 
>> as usual, but that is in the fast path, so we do not want to waste cycles 
>> for such a corner case as RDHWR emulation.
> 
> To clarify, this behaviour of hitting in an VIVT I-cache even though there
> is no address translation in the TLB is allowed but not required by the
> the MIPS architecture spec.  From a software perspective it's a bit
> quirky but it allows faster pipeline implementations.  The currently
> supported VIVT I-cache processors are the SB1, 20K and 25K.  The SB1
> has this behaviour; of the 20K and 25K I don't know.

And to perhaps clarify even more, the octeon too has this property, so 
the probe of the TLB is needed there.

David Daney
