Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 12:58:55 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:41932 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037642AbWH3L6x (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2006 12:58:53 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 8F6943EE1; Wed, 30 Aug 2006 04:58:49 -0700 (PDT)
Message-ID: <44F57DBD.9020700@ru.mvista.com>
Date:	Wed, 30 Aug 2006 15:59:57 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Thomas Koeller <thomas.koeller@baslerweb.com>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	rmk+serial@arm.linux.org.uk, linux-serial@vger.kernel.org,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	=?ISO-8859-1?Q?Thomas_?= =?ISO-8859-1?Q?K=F6ller?= 
	<thomas@koeller.dyndns.org>
Subject: Re: [PATCH] RM9000 serial driver
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608222227.20181.thomas.koeller@baslerweb.com> <44F459DD.8060902@ru.mvista.com> <200608300105.26921.thomas.koeller@baslerweb.com>
In-Reply-To: <200608300105.26921.thomas.koeller@baslerweb.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Thomas Koeller wrote:

>>>Also, it seems to me that the whole register-mapping stuff conflicts with
>>>autodetection, because autoconfig() uses serial_inp() and serial_outp()
>>>before the port types, and hence the mapping requirements, are known.

>>    Port types have nothing to do with this. Or at least they hadn't until
>>your recent patch. :-)
>>    iotype was used to identify the addressing scheme, and it's alsready
>>known beforehand.

> How so? If I do not yet know which hardware I am dealing with, how can I know
> the iotype?

    The iotype is passed to driver when registering the platform device or 
calling early_serial_setup().
There's absolutely no way for 8250.c to figure it out yourself. Please, review 
the driver's code more carefully. It was not at all that complex task to copy 
from the existing Alchemy code...

> Thomas 

WBR, Sergei
