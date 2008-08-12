Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 15:14:51 +0100 (BST)
Received: from alpha-bit.de ([217.160.213.225]:53949 "EHLO
	p15137410.pureserver.info") by ftp.linux-mips.org with ESMTP
	id S20035157AbYHLOOs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 15:14:48 +0100
Received: from Porsche (DSL01.83.171.162.173.ip-pool.NEFkom.net [83.171.162.173])
	by p15137410.pureserver.info (Postfix) with ESMTP id C9E0C80DA19;
	Tue, 12 Aug 2008 16:14:26 +0200 (CEST)
X-KENId: 00004772KEN3F896519
X-KENRelayed: 00004772KEN3F896519@Porsche
Received: from [192.168.0.160]
   by KEN (4.00.93-v070725) with SMTP
   ; Tue, 12 Aug 2008 16:14:27 +0200
Date:	Tue, 12 Aug 2008 16:14:22 +0200
From:	Martin Gebert <martin.gebert@alpha-bit.de>
Subject: Re: Debugging the MIPS processor using GDB
To:	TriKri <kristoferkrus@hotmail.com>
Cc:	linux-mips@linux-mips.org
Message-Id: <48A19ABE.5060104@alpha-bit.de>
In-Reply-To: <18944199.post@talk.nabble.com>
References: <18944199.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
X-KENRecTime: 1218550467
Content-Transfer-Encoding: 7bit
User-Agent: Thunderbird 2.0.0.16 (X11/20080730)
Return-Path: <martin.gebert@alpha-bit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20177
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: martin.gebert@alpha-bit.de
Precedence: bulk
X-list: linux-mips


> Finally, there's a program called gdbserver, which comes with GDB. If I
> write a remote stub, do I need this program? Where should it be run? Where
> should my program be run? Since the stub is a c file, but lacks of a main
> function, how do I compile it?
>   

At least this I can answer. In short, you need to call gdbserver on your 
target machine in order to do remote debugging from your workstation. 
The first Google match for "using gdbserver" reveals this:

http://www.redhat.com/docs/manuals/enterprise/RHEL-4-Manual/gdb/server.html

HTH

Martin
