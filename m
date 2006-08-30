Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Aug 2006 17:49:03 +0100 (BST)
Received: from h155.mvista.com ([63.81.120.155]:2514 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20037700AbWH3QtB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 30 Aug 2006 17:49:01 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 640CF3EDB; Wed, 30 Aug 2006 09:48:56 -0700 (PDT)
Message-ID: <44F5C1BB.7010205@ru.mvista.com>
Date:	Wed, 30 Aug 2006 20:50:03 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Russell King <rmk@arm.linux.org.uk>
Cc:	Thomas Koeller <thomas.koeller@baslerweb.com>,
	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-serial@vger.kernel.org, ralf@linux-mips.org,
	linux-mips@linux-mips.org,
	Thomas K?ller <thomas@koeller.dyndns.org>
Subject: Re: [PATCH] RM9000 serial driver
References: <200608102318.52143.thomas.koeller@baslerweb.com> <200608260038.13662.thomas.koeller@baslerweb.com> <44F441F3.8050301@ru.mvista.com> <200608300100.32836.thomas.koeller@baslerweb.com> <20060830121216.GA25699@flint.arm.linux.org.uk>
In-Reply-To: <20060830121216.GA25699@flint.arm.linux.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Russell King wrote:

>>I would like to return to the port type vs. iotype  stuff once again.
>>From what you wrote I seem to understand that the iotype is not just
>>a method of accessing device registers, but also the primary means of
>>discrimination between different h/w implementations, and hence every
>>code to support a nonstandard device must define an iotype of its own,
>>even though one of the existing iotypes would work just fine?

> iotype is all about the access method used to access the registers of
> the device, be it by byte or word, and it also takes account of any
> variance in the addressing of the registers.

> It does not refer to features or bugs in any particular implementation.

    Well, the introduction of the UPIO_TSI case seems to contradict this --
it's exactly about the bugs in the particular UART implementation (otherwise
well described by UPIO_MEM). Its only function was to mask 2 hardware issues.
And the UUE bit workaround seems like an abuse to me. The driver could just 
skip the UUE test altogether based on iotype == UPIO_TSI (or at least not to 
ignore writes with UUE set completely like it does but just mask off UUE bit).
    With no provision to pass the implicit UART type for platform devices (and 
skip the autoconfiguation), the introduction of UPIO_TSI seems again the 
necessary evil. Otherwise, we could have this handled with a distinct TSI UART 
type...

WBR, Sergei
