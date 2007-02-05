Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Feb 2007 14:35:26 +0000 (GMT)
Received: from www.pc-net.at ([193.238.157.29]:35547 "EHLO MrWeb01.pc-net.at")
	by ftp.linux-mips.org with ESMTP id S20037701AbXBEOfW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 5 Feb 2007 14:35:22 +0000
Received: from localhost (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id 4D825215ECD
	for <linux-mips@linux-mips.org>; Mon,  5 Feb 2007 15:34:45 +0100 (CET)
Received: from MrWeb01.pc-net.at ([127.0.0.1])
	by localhost (MrWeb01 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 06389-06 for <linux-mips@linux-mips.org>;
	Mon, 5 Feb 2007 15:34:43 +0100 (CET)
Received: from www.amilda.org (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id C8C5A215ECA
	for <linux-mips@linux-mips.org>; Mon,  5 Feb 2007 15:34:32 +0100 (CET)
Received: from 201.240.249.124
        (SquirrelMail authenticated user amilda0001)
        by www.amilda.org with HTTP;
        Mon, 5 Feb 2007 09:34:43 -0500 (PET)
Message-ID: <24895.201.240.249.124.1170686083.squirrel@www.amilda.org>
In-Reply-To: <45C45DDA.1000805@wp.pl>
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
Date:	Mon, 5 Feb 2007 09:34:43 -0500 (PET)
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
X-archive-position: 13937
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergio@amilda.org
Precedence: bulk
X-list: linux-mips



> <cut>
>
>>Are you talking about the configuration structure? If so, it varies
>>between model to model. AMiLDA itself uses a totally different
>>configuration which may very from version to version.
>>
>>
>>
> Yes.

The configuration structure is difficult to understand (even if you have
the C header containing the struct) because of many conditional compiling
macros (if this model, and not that one or this but not the other, etc).
Just use the "flash" program.

>
>>That means that webs encountered an error starting up. Usually it is due
>>to another webs instance already running or another process that has port
>>80 opened.
>>
>>
> That is not the case, sure.
>

When webs does that, it means that it encountered an error during startup.
If i remember correctly, webs does the following during startup:

- Allocate some memory for its own use.
- Figure out the document root.
- Register asp and cgi functions.
- Bind to port 80 (or whatever it is told to use)

If any of these fail, then you will experience that simpton.

Sergio
