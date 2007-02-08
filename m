Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 15:09:58 +0000 (GMT)
Received: from www.pc-net.at ([193.238.157.29]:5252 "EHLO MrWeb01.pc-net.at")
	by ftp.linux-mips.org with ESMTP id S20038614AbXBHPJy (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 8 Feb 2007 15:09:54 +0000
Received: from localhost (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id DF855215EDC
	for <linux-mips@linux-mips.org>; Thu,  8 Feb 2007 16:09:18 +0100 (CET)
Received: from MrWeb01.pc-net.at ([127.0.0.1])
	by localhost (MrWeb01 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 22290-08 for <linux-mips@linux-mips.org>;
	Thu, 8 Feb 2007 16:09:14 +0100 (CET)
Received: from www.amilda.org (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id 64C45215EDB
	for <linux-mips@linux-mips.org>; Thu,  8 Feb 2007 16:09:04 +0100 (CET)
Received: from 201.240.249.124
        (SquirrelMail authenticated user amilda0001)
        by www.amilda.org with HTTP;
        Thu, 8 Feb 2007 10:09:14 -0500 (PET)
Message-ID: <13931.201.240.249.124.1170947354.squirrel@www.amilda.org>
In-Reply-To: <45CA1552.3080100@wp.pl>
References: <45C0C956.2050009@wp.pl>            
    <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>            
    <200701312302.05473.florian.fainelli@int-evry.fr>            
    <45C11812.9050808@wp.pl>         
    <10879.201.240.249.124.1170335347.squirrel@www.amilda.org>         
    <45C1FE3D.8080304@wp.pl>      
    <16445.201.240.249.124.1170423826.squirrel@www.amilda.org>      
    <45C3BB23.2070309@wp.pl>   
    <50812.201.230.45.190.1170482268.squirrel@www.amilda.org>   
    <45C45DDA.1000805@wp.pl>
    <24895.201.240.249.124.1170686083.squirrel@www.amilda.org>
    <45CA1552.3080100@wp.pl>
Date:	Thu, 8 Feb 2007 10:09:14 -0500 (PET)
Subject: Re: Advice needed.
From:	"Sergio Aguayo" <sergio@amilda.org>
To:	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.6-rc1
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at pc-net.at
Return-Path: <sergio@amilda.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13988
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergio@amilda.org
Precedence: bulk
X-list: linux-mips



> <cut>
>
>>The configuration structure is difficult to understand (even if you have
>>the C header containing the struct)
>>
>>
> I don't have any header files for flash. Do you? In tarballs for BR,
> there is no source for utilities like flash.
> I'm trying to "decode" this structure, variable-by-variable. I have used
> your flash utility source
>

When Edimax was forced to release the sources, they released a different
source archive than the one currently available. That one contained some
more files than the current one does. I'll upload it today for you to
download it.

>>Just use the "flash" program.
>>
>>
> The one, that comes with original firmware? But what about webs, as i
> looked into, this needs too some knowledge of flash datastructures.?
>

webs and the flash program share some sources. Originally, flash's sources
are contained in the LINUX directory of webs.


>
> About webs -> will try to add some printf for debugging, and see.
>

Ok, let me know what your results are.


> BTW, maybe the JP3 connector (just 12 little holes) is the JTAG. Will
> upload photo i think tomorrow. I have checked this with ohmometer and
> pin-map of 8186, and it seems to be JTAG + RESET+ something(?). You have
> published schema of JTAG cable, but what software shall anyone use?
>

That's a JTAG. But AFAIK no software can drive it yet (except maybe some
commercial software?). See forum.amilda.org, forum MODs for some
information that may be useful for you to experiment with jtag.


Sergio
