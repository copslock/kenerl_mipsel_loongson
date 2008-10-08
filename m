Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Oct 2008 01:30:13 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:25260 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S20876071AbYJHAaH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Oct 2008 01:30:07 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48ebfee80000>; Tue, 07 Oct 2008 20:29:28 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 7 Oct 2008 17:29:26 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 7 Oct 2008 17:29:25 -0700
Message-ID: <48EBFEE5.7010401@caviumnetworks.com>
Date:	Tue, 07 Oct 2008 17:29:25 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	"H. Peter Anvin" <hpa@zytor.com>
CC:	linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH 1/4] serial: 8250 driver replaceable i/o functions.
References: <48EBF426.9080500@caviumnetworks.com> <48EBF56D.3030203@caviumnetworks.com> <48EBFAFC.3020501@zytor.com>
In-Reply-To: <48EBFAFC.3020501@zytor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Oct 2008 00:29:25.0944 (UTC) FILETIME=[EB202B80:01C928DC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20706
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

H. Peter Anvin wrote:
> David Daney wrote:
>> /* sane hardware needs no mapping */
>> -static inline int map_8250_in_reg(struct uart_8250_port *up, int offset)
>> +static inline int map_8250_in_reg(struct uart_port *p, int offset)
>> {
>> -    if (up->port.iotype != UPIO_AU)
>> +    if (p->iotype != UPIO_AU)
>>         return offset;
>>     return au_io_in_map[offset];
>> }
> 
> With your changes, these functions cannot be called with p->iotype != 
> UPIO_AU anymore, correct?  So there is no need for this test...
> 

I think you are probably correct.  However, with the patch it is 
possible to move all this target specific code out of the driver.  So if 
the patch is accepted, a better follow up would be to get rid of the 
UPIO_AU things altogether.

I gave an example of how that could be done with UPIO_TSI here:

http://marc.info/?l=linux-serial&m=122333633802691&w=2

David Daney
