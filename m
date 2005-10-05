Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Oct 2005 10:45:45 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:19706 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S3465565AbVJEJp0
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Oct 2005 10:45:26 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j959jFgs004784;
	Wed, 5 Oct 2005 02:45:15 -0700 (PDT)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j959jD17024114;
	Wed, 5 Oct 2005 02:45:14 -0700 (PDT)
Message-ID: <4343A0FE.9080808@mips.com>
Date:	Wed, 05 Oct 2005 11:46:38 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Franck <vagabon.xyz@gmail.com>
CC:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
References: <cda58cb80510040149p690397afo@mail.gmail.com>	 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl>	 <434277D5.1090603@mips.com> <cda58cb80510050000r1baea5c7k@mail.gmail.com>
In-Reply-To: <cda58cb80510050000r1baea5c7k@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9146
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Franck wrote:
> 2005/10/4, Kevin D. Kissell <kevink@mips.com>:
> 
>>They also have some physical security and cryptography accelleration
>>features, some of which use extended CPU state that would
>>require some kernel context management support if anyone wanted
>>to actually use them in Linux applications. The real point of
>>having a CPU_4KSC config flag would be to enable building-in
>>such support.
>>
> what is extended CPU state that you're talking about ?

That would be telling.  ;o)   Seriously, see below.

>>I'm being a teeny bit vague about this, because I'm not 100%
>>certain that all the details of "SmartMIPS" have been published.
>>
> 
> hmm, does that mean that smart mips extension couldn't be supported in
> Linux in case that this extension have not been published ?

I'm personally not a big believer in security-through-obscurity,
but there are those, both inside and outside MIPS, who felt that
the security of SmartMIPS cores would be enhanced if we didn't
give away all of the details.  As a consequence, we put off
publishing the nitty-gritty details of SmartMIPS for quite a while.
I note that we now have the programmers' manual on-line at www.mips.com,
so I guess I'm implicitly cleared to discuss it in at least that level
of detail.

A key element of SmartMIPS that allows for a ~2x speedup for
crypto codes that rely on extended precision math (RSA, ECC)
is the combination of an extension to the Hi/Lo accumulator
(called "ACX") with a special extract-and-reduce instruction
("MFLHXU").  If one wants to use that in Linux - or at least,
if one wants to allow more than one thread to be able to use
it at a time - one needs to save/restore ACX on the kernel
stackframe, along with Hi and Lo.

		Regards,

		Kevin K.
