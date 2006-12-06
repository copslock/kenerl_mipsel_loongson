Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Dec 2006 15:11:13 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:45409 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038415AbWLFPLJ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Dec 2006 15:11:09 +0000
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 4EE933EC9; Wed,  6 Dec 2006 07:11:06 -0800 (PST)
Message-ID: <4576DDEC.1050105@ru.mvista.com>
Date:	Wed, 06 Dec 2006 18:12:44 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Ingo Molnar <mingo@redhat.com>, anemo@mba.sphere.ne.jp,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Import updates from i386's i8259.c
References: <20061206.103923.71086192.nemoto@toshiba-tops.co.jp> <20061206015818.GB27985@linux-mips.org> <20061206.115602.63741871.nemoto@toshiba-tops.co.jp> <20061206.133836.89067271.nemoto@toshiba-tops.co.jp> <4576C2E9.4060900@ru.mvista.com> <Pine.LNX.4.64N.0612061337220.29000@blysk.ds.pg.gda.pl> <4576CB64.2060705@ru.mvista.com> <Pine.LNX.4.64N.0612061438440.29000@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0612061438440.29000@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Maciej W. Rozycki wrote:

>>>And with the "IO-APIC-edge" and "IO-APIC-level" alternatives back when the
>>>concept of IRQ controllers was introduced, "XT-PIC" rather than "8259A"
>>>sounded quite right.

>>   I don't follow you here.

>  These were the three first names of interrupt controllers introduced back 
> in 2.1 and the names chosen looked consistent.

    I'd say they *only* looked consistent then. :-)
    In fact, i8259.c is driving two coupled together 8259 chips, so using the 
word "XT" in this context was absolutely wrong.
    As for the I/O APIC, I think i82903AA was "the reference design" for it...

>   Maciej

WBR, Sergei
