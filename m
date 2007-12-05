Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Dec 2007 03:50:57 +0000 (GMT)
Received: from mail.zeugmasystems.com ([70.79.96.174]:6708 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20032592AbXLEDut (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Dec 2007 03:50:49 +0000
Received: from rocktron ([10.18.28.223]) by zeugmasystems.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 4 Dec 2007 19:50:42 -0800
Message-ID: <802BA59F5D0A495BAB9A037527BB76BB@rocktron>
From:	"Kaz Kylheku" <kaz@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
References: <20071203181658.GA26631@onstor.com> <20071203230828.GA17960@linux-mips.org>
In-Reply-To: <20071203230828.GA17960@linux-mips.org>
Subject: Re: [PATCH] Add support for SB1 hardware watchdog.
Date:	Tue, 4 Dec 2007 19:41:08 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Windows Mail 6.0.6000.16480
X-MimeOLE: Produced By Microsoft MimeOLE V6.0.6000.16545
X-OriginalArrivalTime: 05 Dec 2007 03:50:42.0559 (UTC) FILETIME=[021E60F0:01C836F2]
Return-Path: <kaz@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kaz@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

On Mon, Dec 03, 2007, Ralf Baechle wrote:
> On Mon, Dec 03, 2007 at 10:17:04AM -0800, Andrew Sharp wrote:
>
>> +   Watchdog driver for the built in watchdog hardware in Sibyte
>> +   SoC processors.  There are apparently two watchdog timers
>> +   on such processors; this driver supports only the first one,
>> +   because currently Linux only supports exporting one watchdog
>> +   to userspace.
>
> And even four watchdogs in the BCM1480.
>
> You'd think they'd trust their hardware more than that ;-)

Maybe the dogs can be daisy-chained together. After all, who watches the 
watcher? And who watches him?

Did I ever tell you how lucky you are?

http://www.drseussart.com/beewatcher.html

http://www.webpages.ttu.edu/sbaugues/fin4323/dr.seuss.pdf
