Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Dec 2003 10:01:11 +0000 (GMT)
Received: from gwa11.fe.bosch.de ([IPv6:::ffff:194.39.219.249]:31640 "EHLO
	gwa11.fe.bosch.de") by linux-mips.org with ESMTP
	id <S8225341AbTLIKBL>; Tue, 9 Dec 2003 10:01:11 +0000
Received: by gwa11.fe.bosch.de (Postfix, from userid 5)
	id 6600F25B36B; Tue,  9 Dec 2003 11:00:57 +0100 (MET)
Received: from fez8121.de.bosch.com(unknown 10.4.4.20) by gwa11.fe.bosch.de via smap (V2.1)
	id xma010013; Tue, 9 Dec 03 10:59:47 +0100
Received: from 10.4.102.43 by fez8121.de.bosch.com (InterScan E-Mail VirusWall NT); Tue, 09 Dec 2003 10:59:45 +0100
Received: from hi-mail02.de.bosch.com ([10.34.16.71]) by fe-imc02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Tue, 9 Dec 2003 10:59:46 +0100
Received: from de.bosch.com ([10.34.211.138]) by hi-mail02.de.bosch.com with Microsoft SMTPSVC(5.0.2195.5329);
	 Tue, 9 Dec 2003 10:59:44 +0100
Message-ID: <3FD59CC1.7030907@de.bosch.com>
Date: Tue, 09 Dec 2003 10:58:25 +0100
From: Dirk Behme <dirk.behme@de.bosch.com>
Organization: Blaupunkt GmbH
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: GCC 3.3.2 and Alchemy AU1100
References: <8EAC52A94CD8D411A01000805FBB37760615AF16@gbrwgcms02.wgc.gbr.xerox.com>
In-Reply-To: <8EAC52A94CD8D411A01000805FBB37760615AF16@gbrwgcms02.wgc.gbr.xerox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 09 Dec 2003 09:59:44.0745 (UTC) FILETIME=[2C061590:01C3BE3B]
Return-Path: <Dirk.Behme@de.bosch.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3714
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dirk.behme@de.bosch.com
Precedence: bulk
X-list: linux-mips

Hamilton, Ian wrote:

> Hi there.
> 
> I'm trying to build software for the AMD AU1100 processor using version
> 3.3.2 of the gnu compiler, and I'm having trouble figuring out the -march,
> -mtune, etc settings.
> 
> Version 2.95 of gcc uses something like -mcpu=r4600, but this doesn't work
> with 3.3.2.
> 
> I've tried other likely-looking options (e.g. -mips32), but the compiler
> fails to assembler instructions like mtc0 and cache.
> 
> Has anyone built for the AU1100 using gcc 3.3.2? If so, could you tell me
> the cpu options you used please?

For a VR41xx CPU with GCC 3.3.1 I have used

-march=r4600 -mips3 -Wa,--trap

instead of the old

-mcpu=r4600 -mips2 -Wa,--trap

Not sure whether this is correct (no test of the output on a target
yet), but it compiles.
