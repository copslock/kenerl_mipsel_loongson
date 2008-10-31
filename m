Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Nov 2008 08:24:43 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:55981 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S22826604AbYJaM4I (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2008 12:56:08 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 3D703C80E6;
	Fri, 31 Oct 2008 14:56:01 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id wtfSJXCIIBMq; Fri, 31 Oct 2008 14:56:01 +0200 (EET)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 1FFA2C80D7;
	Fri, 31 Oct 2008 14:56:01 +0200 (EET)
Message-ID: <490B0060.3030709@movial.fi>
Date:	Fri, 31 Oct 2008 14:56:00 +0200
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080724)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	David Daney <ddaney@avtrex.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix include paths in malta-amon.c
References: <48D52FF4.2000905@avtrex.com> <20081015143804.GA18506@linux-mips.org>
In-Reply-To: <20081015143804.GA18506@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21140
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sat, Sep 20, 2008 at 10:16:36AM -0700, David Daney wrote:
> 
>> On linux-queue, malta doesn't build after the include file relocation.
>> This should fix it.
>>
>> There some occurrences of 'asm-mips' in the comments of quite a few
>> files, but this is the only place I found it in any code.
>>
>> Signed-off-by: David Daney <ddaney@avtrex.com>
> 
> Thanks, applied.

Hi,

The fix is still not in Linus' tree.

Dmitri

> 
>   Ralf
> 
