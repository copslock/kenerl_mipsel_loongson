Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Mar 2004 20:43:32 +0000 (GMT)
Received: from law10-f94.law10.hotmail.com ([IPv6:::ffff:64.4.15.94]:45834
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8225206AbUCHUnb>; Mon, 8 Mar 2004 20:43:31 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 8 Mar 2004 12:43:20 -0800
Received: from 24.75.124.5 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 08 Mar 2004 20:43:20 GMT
X-Originating-IP: [24.75.124.5]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: linux-mips@linux-mips.org
Subject: readdir() problems revisted
Date: Mon, 08 Mar 2004 20:43:20 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <LAW10-F94qQzpEThVg400051b84@hotmail.com>
X-OriginalArrivalTime: 08 Mar 2004 20:43:20.0460 (UTC) FILETIME=[FDF614C0:01C4054D]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips

Hi folks

Back in January, I whined about a signal 11 I'm getting:

>I'm running on a Helio pda, r3912 chip, little endian. I've used crosstool 
>to create a cross compiler >with
>
>gcc 3.2.3
>glibc 2.2.3
>
>
>When I run the following code (linked static or dynamic):
>

(snip)

>       entry=readdir(dir);
>       fprintf(stderr,"after readdir\n");

(snip)

Could this have anything to do with the fact I've got a read only files 
system in my pda?

Does anyone know if there's a glibc mailing list that discusses this kind of 
thing.  I found their bug tracker, but I'd like to talk to some glibc 
maintainers before I file any bug reports.

Thanks

Mark

_________________________________________________________________
Get business advice and resources to improve your work life, from bCentral. 
http://special.msn.com/bcentral/loudclear.armx
