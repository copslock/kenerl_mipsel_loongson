Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jun 2009 00:08:32 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:47496 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492943AbZFWWI0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 24 Jun 2009 00:08:26 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a41512d0000>; Tue, 23 Jun 2009 18:03:30 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Jun 2009 15:03:15 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 23 Jun 2009 15:03:15 -0700
Message-ID: <4A415121.1040602@caviumnetworks.com>
Date:	Tue, 23 Jun 2009 15:03:13 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:	Kaz Kylheku <KKylheku@zeugmasystems.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Silly 100% CPU behavior on a SIG_IGN-ored SIGBUS.
References: <DDFD17CC94A9BD49A82147DDF7D545C501C35128@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C501C35128@exchange.ZeugmaSystems.local>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Jun 2009 22:03:15.0531 (UTC) FILETIME=[688A99B0:01C9F44E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23479
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Kaz Kylheku wrote:
> Hi all,
> 
> On kernel 2.6.26, glibc 2.5 (n32), SiByte SB-1 core, the following
> program goes into 100% CPU, chewing up about 80% kernel time and
> 20% user.
> 
> #include <stdio.h>
> #include <signal.h>
> 
> int main(void)
> {
>   int *deadbeef = (int *) 0xdeadbeef;
>   signal(SIGBUS, SIG_IGN);
>   printf("*deadbeef == %d\n", *deadbeef);
>   return 0;
> }
> 
> If any fatal exception is ignored, the program should be killed
> if that exception happens. 100% CPU is not a useful response.
> 
> (If there is a handler, and that handler returns without doing anything
> to
> prevent a recurrence of the exception when the instruction is re-tried,
> that's different).
> 
> 


I wonder if it is another instance of:

http://www.linux-mips.org/git?p=linux.git;a=commitdiff;h=49cf0e2d68dd98dbb28eaca0284e8460ab6ad86d

David Daney
