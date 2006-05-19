Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 17:04:26 +0200 (CEST)
Received: from amdext4.amd.com ([163.181.251.6]:48309 "EHLO amdext4.amd.com")
	by ftp.linux-mips.org with ESMTP id S8133951AbWESPER (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 19 May 2006 17:04:17 +0200
Received: from SAUSGW01.amd.com (sausgw01.amd.com [163.181.250.21])
	by amdext4.amd.com (8.12.11/8.12.11/AMD) with ESMTP id k4JF4Wx9026733;
	Fri, 19 May 2006 10:05:03 -0500
Received: from 163.181.22.101 by SAUSGW01.amd.com with ESMTP (AMD SMTP
 Relay (Email Firewall v6.1.0)); Fri, 19 May 2006 10:05:11 -0500
X-Server-Uuid: 8C3DB987-180B-4465-9446-45C15473FD3E
Received: from ldcmail.amd.com ([147.5.200.40]) by sausexbh1.amd.com
 with Microsoft SMTPSVC(6.0.3790.2499); Fri, 19 May 2006 10:04:00 -0500
Received: from cosmic.amd.com (cosmic.amd.com [147.5.201.206]) by
 ldcmail.amd.com (Postfix) with ESMTP id 3B0BD2028; Fri, 19 May 2006
 09:03:58 -0600 (MDT)
Received: from cosmic.amd.com (localhost [127.0.0.1]) by cosmic.amd.com
 (8.13.4/8.13.4) with ESMTP id k4JF8qVw024025; Fri, 19 May 2006 09:08:52
 -0600
Received: (from jcrouse@localhost) by cosmic.amd.com (
 8.13.4/8.13.4/Submit) id k4JF8pFY024024; Fri, 19 May 2006 09:08:51
 -0600
Date:	Fri, 19 May 2006 09:08:51 -0600
From:	"Jordan Crouse" <jordan.crouse@amd.com>
To:	"Sergei Shtylyov" <sshtylyov@ru.mvista.com>
cc:	"Clem Taylor" <clem.taylor@gmail.com>, linux-mips@linux-mips.org,
	"Ralf Baechle" <ralf@linux-mips.org>
Subject: Re: I2C troubles with Au1550
Message-ID: <20060519150851.GD9596@cosmic.amd.com>
References: <ecb4efd10605181454v34ef19degf2cdd2535b37fc30@mail.gmail.com>
 <20060519143247.GC9596@cosmic.amd.com> <446DDABE.2040105@ru.mvista.com>
MIME-Version: 1.0
In-Reply-To: <446DDABE.2040105@ru.mvista.com>
User-Agent: Mutt/1.5.11
X-OriginalArrivalTime: 19 May 2006 15:04:01.0011 (UTC)
 FILETIME=[76143430:01C67B55]
X-WSS-ID: 6873012D40W401761-01-01
Content-Type: text/plain;
 charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Return-Path: <jcrouse@cosmic.amd.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11498
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jordan.crouse@amd.com
Precedence: bulk
X-list: linux-mips

On 19/05/06 18:48 +0400, Sergei Shtylyov wrote:
 
>    Alas, I have to NAK this. DBAu1200 code should be in 
> arch/mips/au1000/pb1200/...

if this was DB1200 code only, I would be inclined to agree, but its
not - so this code is well placed.

>    Thou wait... that hunk won't even aplly to the current git tree... 

Well, it does apply - latest GIT tree, right from l-m.o

> Looks like this patch is trying to redeclare PSC base addresses for Au1200 

Yeah, it does a redundant declaration - I'll pull that part of it.  The
rest of the patch is still valid though - I see no reason why you should NAK
it, especially when this was posted by popular request.

Jordan
