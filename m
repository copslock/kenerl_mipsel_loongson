Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2006 14:22:34 +0100 (BST)
Received: from webmail.ict.ac.cn ([159.226.39.7]:43699 "HELO ict.ac.cn")
	by ftp.linux-mips.org with SMTP id S8133455AbWD1NWY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2006 14:22:24 +0100
Received: (qmail 12813 invoked by uid 507); 28 Apr 2006 12:27:24 -0000
Received: from unknown (HELO ?192.168.2.202?) (fxzhang@222.92.8.142)
  by ict.ac.cn with SMTP; 28 Apr 2006 12:27:24 -0000
Message-ID: <445216D0.3000807@ict.ac.cn>
Date:	Fri, 28 Apr 2006 21:21:20 +0800
From:	Fuxin Zhang <fxzhang@ict.ac.cn>
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	"Kevin D. Kissell" <kevink@mips.com>, gowri@bitel.co.kr,
	linux-mips@linux-mips.org
Subject: Re: Java virtual machine on linux MIPS
References: <1146188366.3034.6.camel@localhost.localdomain> <000d01c66a9c$c6686290$10eca8c0@grendel> <Pine.LNX.4.64N.0604281120510.32041@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0604281120510.32041@blysk.ds.pg.gda.pl>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <fxzhang@ict.ac.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11237
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fxzhang@ict.ac.cn
Precedence: bulk
X-list: linux-mips

we have ported sun jdk 1.5 as a research work, both interpreted & jit
works, many programs run well but still with some bugs left.

Not sure whether we can redistribute it(license, agreement of our
institute etc.)

Maciej W. Rozycki 写道:
> On Fri, 28 Apr 2006, Kevin D. Kissell wrote:
> 
>> It's been several years, but at one point I successfully tested
>> and benchmarked commercail JVMs from Insignia (now part
>> of Esmertec, www.esmertec.com) and Skelmir (www.skelmir.com),
>> and managed to get the open source Kaffe VM (www.kaffe.org) 
>> running on MIPS Linux as well.  Kaffe has a JIT that has, alas,
>> been broken for MIPS and most other RISC architectures for
>> the last couple of years, but the JVM still works OK in interpreted 
>> mode. I'm sure that there are other options - those are just the ones
>> I've had hands-on experience with.
> 
>  And there is of course GIJ -- a part of GCC (which is also able to 
> compile Java source code to native machine code and link it with Java 
> bytecode if necessary).  I'm not sure how capable it is these days though.
> 
>   Maciej
> 
> 
> 
