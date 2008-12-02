Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Dec 2008 17:03:05 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:52614 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24056828AbYLBRC7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 Dec 2008 17:02:59 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B493569f20000>; Tue, 02 Dec 2008 12:01:38 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Dec 2008 09:01:14 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 2 Dec 2008 09:01:14 -0800
Message-ID: <493569D9.1030708@caviumnetworks.com>
Date:	Tue, 02 Dec 2008 09:01:13 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
CC:	linux-serial@vger.kernel.org, akpm@linux-foundation.org,
	linux-mips@linux-mips.org,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: Re: [PATCH 1/4] 8250: Don't clobber spinlocks.
References: <4934774E.6080805@caviumnetworks.com>	<1228175368-5536-1-git-send-email-ddaney@caviumnetworks.com> <20081202112010.6b25af1c@lxorguk.ukuu.org.uk>
In-Reply-To: <20081202112010.6b25af1c@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 02 Dec 2008 17:01:14.0125 (UTC) FILETIME=[957C3BD0:01C9549F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21487
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:
> On Mon,  1 Dec 2008 15:49:25 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
> 
>> In serial8250_isa_init_ports(), the port's lock is initialized.  We
>> should not overwrite it.  In early_serial_setup(), only copy in the
>> fields we need.  Since the early console code only uses a subset of
>> the fields, these are sufficient.
> 
>> -	serial8250_ports[port->line].port.ops	= &serial8250_pops;
> 
> You seem to drop the assignment of port.ops ?
> 

The port.ops are initialized in the preceding call to 
serial8250_isa_init_ports(), we don't have to set it again as we are no 
longer clobbering it with a full structure assignment.

Perhaps the patch commentary should be adjusted to mention this.

David Daney
