Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Jun 2009 15:17:06 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:34202 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1492850AbZFYNQ7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 25 Jun 2009 15:16:59 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n5PDD1MN002147;
	Thu, 25 Jun 2009 14:13:01 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n5PDD0M8002145;
	Thu, 25 Jun 2009 14:13:00 +0100
Date:	Thu, 25 Jun 2009 14:13:00 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Kevin D. Kissell" <kevink@paralogos.com>
Cc:	Kaz Kylheku <KKylheku@zeugmasystems.com>, linux-mips@linux-mips.org
Subject: Re: Silly 100% CPU behavior on a SIG_IGN-ored SIGBUS.
Message-ID: <20090625131300.GB10661@linux-mips.org>
References: <DDFD17CC94A9BD49A82147DDF7D545C501C35128@exchange.ZeugmaSystems.local> <4A415ACD.8010102@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A415ACD.8010102@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23500
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 23, 2009 at 03:44:29PM -0700, Kevin D. Kissell wrote:

>> int main(void)
>> {
>>   int *deadbeef = (int *) 0xdeadbeef;
>>   signal(SIGBUS, SIG_IGN);
>>   printf("*deadbeef == %d\n", *deadbeef);
>>   return 0;
>> }
>>
>> If any fatal exception is ignored, the program should be killed
>> if that exception happens. 100% CPU is not a useful response.
>>   
> It's not a useful program, so what did you expect?   One might argue  
> that it would be more useful or correct to have the kernel advance the  
> PC to not endlessly repeat the doomed load, but ignoring SIG_IGN and  
> silently killing the thread violates the signal API as I've always  
> understood it.

It's not a useful program but valid as a test case.  However I agree with
your interpretation of signal semantics but I'll have to round up a copy
of the relevant standard documents; I have vague memories about some small
print for cases like this.

  Ralf
