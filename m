Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Nov 2008 21:05:43 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:5334 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23797432AbYKTVFa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 20 Nov 2008 21:05:30 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4925d0f10004>; Thu, 20 Nov 2008 16:04:49 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Nov 2008 13:00:47 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 20 Nov 2008 13:00:47 -0800
Message-ID: <4925CFFF.9010502@caviumnetworks.com>
Date:	Thu, 20 Nov 2008 13:00:47 -0800
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-mips <linux-mips@linux-mips.org>,
	linux-serial@vger.kernel.org
Subject: Re: [PATCH 21/26] Serial: Allow port type to be specified when calling
 serial8250_register_port.
References: <49233FDE.3010404@caviumnetworks.com>	<1227047057-4911-3-git-send-email-ddaney@caviumnetworks.com> <20081120200256.73f98e09@lxorguk.ukuu.org.uk>
In-Reply-To: <20081120200256.73f98e09@lxorguk.ukuu.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 20 Nov 2008 21:00:47.0560 (UTC) FILETIME=[0FC35C80:01C94B53]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21349
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Alan Cox wrote:
> On Tue, 18 Nov 2008 14:24:15 -0800
> David Daney <ddaney@caviumnetworks.com> wrote:
> 
>> Add flag value UPF_FIXED_TYPE which specifies that the UART type is
>> known and should not be probed.  For this case the UARTs properties
>> are just copied out of the uart_config entry.
> 
> Looks fine to me

Re-adding the lists...

Does that mean I an add Acked-by you to this patch?

David Daney
