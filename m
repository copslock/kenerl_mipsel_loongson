Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Feb 2007 05:58:32 +0000 (GMT)
Received: from www.pc-net.at ([193.238.157.29]:30411 "EHLO MrWeb01.pc-net.at")
	by ftp.linux-mips.org with ESMTP id S20037475AbXBCF60 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 3 Feb 2007 05:58:26 +0000
Received: from localhost (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id 19B2F215ECC
	for <linux-mips@linux-mips.org>; Sat,  3 Feb 2007 06:57:51 +0100 (CET)
Received: from MrWeb01.pc-net.at ([127.0.0.1])
	by localhost (MrWeb01 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00413-06 for <linux-mips@linux-mips.org>;
	Sat, 3 Feb 2007 06:57:48 +0100 (CET)
Received: from www.amilda.org (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id 74793215EC8
	for <linux-mips@linux-mips.org>; Sat,  3 Feb 2007 06:57:38 +0100 (CET)
Received: from 201.230.45.190
        (SquirrelMail authenticated user amilda0001)
        by www.amilda.org with HTTP;
        Sat, 3 Feb 2007 00:57:48 -0500 (PET)
Message-ID: <50812.201.230.45.190.1170482268.squirrel@www.amilda.org>
In-Reply-To: <45C3BB23.2070309@wp.pl>
References: <45C0C956.2050009@wp.pl>      
    <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>      
    <200701312302.05473.florian.fainelli@int-evry.fr>      
    <45C11812.9050808@wp.pl>   
    <10879.201.240.249.124.1170335347.squirrel@www.amilda.org>   
    <45C1FE3D.8080304@wp.pl>
    <16445.201.240.249.124.1170423826.squirrel@www.amilda.org>
    <45C3BB23.2070309@wp.pl>
Date:	Sat, 3 Feb 2007 00:57:48 -0500 (PET)
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
X-archive-position: 13910
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergio@amilda.org
Precedence: bulk
X-list: linux-mips

> <cut>
>
>>check this: http://www.linux-mips.org/wiki/Adm5120
>>
>>
>>
> Nice ;)
>
> Sergio,
> 1). I am trying now to port the flash utility to BR-6204Wg (different
> data structure), as of now i have succeded to read part of
> hardware-related settings -> nic0, nic1, wlan-mac. As I finish I'll send
> you a copy of related changes needed.

Are you talking about the configuration structure? If so, it varies
between model to model. AMiLDA itself uses a totally different
configuration which may very from version to version.


> 2). I have compiled webs server as-is from Amilda, it compiles, but when
> started just returns with no output. I will investigate this.
>

That means that webs encountered an error starting up. Usually it is due
to another webs instance already running or another process that has port
80 opened.

Sergio
