Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Feb 2003 04:18:57 +0000 (GMT)
Received: from air-2.osdl.org ([IPv6:::ffff:65.172.181.6]:47061 "EHLO
	mail.osdl.org") by linux-mips.org with ESMTP id <S8224939AbTBXES4>;
	Mon, 24 Feb 2003 04:18:56 +0000
Received: from fire-2.osdl.org (air2.pdx.osdl.net [172.20.0.6])
	by mail.osdl.org (8.11.6/8.11.6) with ESMTP id h1O4Iow15415;
	Sun, 23 Feb 2003 20:18:50 -0800
Received: from osdl.org (fire.osdl.org [65.172.181.4])
	by fire-2.osdl.org (8.11.6/8.11.6) with SMTP id h1O4IoQ29515;
	Sun, 23 Feb 2003 20:18:50 -0800
Received: from 4.64.238.61
        (SquirrelMail authenticated user rddunlap)
        by www.osdl.org with HTTP;
        Sun, 23 Feb 2003 20:18:50 -0800 (PST)
Message-ID: <32869.4.64.238.61.1046060330.squirrel@www.osdl.org>
Date: Sun, 23 Feb 2003 20:18:50 -0800 (PST)
Subject: Re: Re: (no subject)
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: <ipv6_san@rediffmail.com>
In-Reply-To: <20030224040647.611.qmail@webmail17.rediffmail.com>
References: <20030224040647.611.qmail@webmail17.rediffmail.com>
X-Priority: 3
Importance: Normal
Cc: <macro@ds2.pg.gda.pl>, <netdev@oss.sgi.com>,
	<linux-mips@linux-mips.org>
X-Mailer: SquirrelMail (version 1.2.8)
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <rddunlap@osdl.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1529
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rddunlap@osdl.org
Precedence: bulk
X-list: linux-mips

>
>
> On Sat, 22 Feb 2003 Maciej W. Rozycki wrote :
>>On 21 Feb 2003, santosh kumar gowda wrote:
>>
>> > Following message is produced at the IAD terminal.....
>> >
>> > # Unable to handle kernel paging request at virtual address
>> > 00000000, epc == 802
>> > 4ce74, ra == 802592a8
>> > Oops in fault.c:do_page_fault, line 172:
>>[...]
>> > Suggestions/Tips are welcome.
>>
>>  Decode the oops first or nobody will be able to give any
>>help.
>
> how do i decode the oops ??? help pls.

Please see linux/REPORTING-BUGS and
linux/Documentation/oops-tracing.txt .
The latter will tell you how to use use 'ksymoops'
to decode an oops message.

~Randy
