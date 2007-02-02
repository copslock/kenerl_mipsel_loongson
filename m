Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Feb 2007 13:44:32 +0000 (GMT)
Received: from www.pc-net.at ([193.238.157.29]:63430 "EHLO MrWeb01.pc-net.at")
	by ftp.linux-mips.org with ESMTP id S20039131AbXBBNo2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 2 Feb 2007 13:44:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id A8087215ED2
	for <linux-mips@linux-mips.org>; Fri,  2 Feb 2007 14:43:52 +0100 (CET)
Received: from MrWeb01.pc-net.at ([127.0.0.1])
	by localhost (MrWeb01 [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 10781-03 for <linux-mips@linux-mips.org>;
	Fri, 2 Feb 2007 14:43:46 +0100 (CET)
Received: from www.amilda.org (localhost [127.0.0.1])
	by MrWeb01.pc-net.at (Postfix) with ESMTP id 8D776215EC8
	for <linux-mips@linux-mips.org>; Fri,  2 Feb 2007 14:43:36 +0100 (CET)
Received: from 201.240.249.124
        (SquirrelMail authenticated user amilda0001)
        by www.amilda.org with HTTP;
        Fri, 2 Feb 2007 08:43:46 -0500 (PET)
Message-ID: <16445.201.240.249.124.1170423826.squirrel@www.amilda.org>
In-Reply-To: <45C1FE3D.8080304@wp.pl>
References: <45C0C956.2050009@wp.pl>   
    <20916.201.240.249.124.1170279547.squirrel@www.amilda.org>   
    <200701312302.05473.florian.fainelli@int-evry.fr>   
    <45C11812.9050808@wp.pl>
    <10879.201.240.249.124.1170335347.squirrel@www.amilda.org>
    <45C1FE3D.8080304@wp.pl>
Date:	Fri, 2 Feb 2007 08:43:46 -0500 (PET)
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
X-archive-position: 13896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergio@amilda.org
Precedence: bulk
X-list: linux-mips


> Thanks, i'll look at this (just finished downloading source). But my
> question was NOT concerning GENERATING image (that part
> of toolchain works, so let it be), but FLasing it. Normally done by webs
> app. And as i see in Amilda, it uses the same scheme -> webs-buried C
> function. And I would have an alternative, because of: first -> have no
> source for webs-buried functions supplied by Edimax, so I have only
> choice of using built binary no chance to simply add some functionality,
> second -> webs is quite heavyweight, approx 450kb -> it is a lot on
> system with 2M Flash expanded to 5M Ramdisk.
>

The flash memory is represented under Linux as a block device driven by
the mtd driver. Therefore it behaves as a normal block device that can be
read or written to. Basically, webs does a write to that block device.
Earlier versions of the source code released by Edimax included the webs
functions. I think the source download is getting more and more useless on
every revision.

Remember that the whole ramdisk (which has data of less than 3MB) is BZIP2
compressed, and it is concatenated with the kernel and then compressed in
GZIP. That makes 450KB not-so-big in 2MB.


> BTW maybe someone reading this knows what Edimax devices have 4M flash?
>

check this: http://www.linux-mips.org/wiki/Adm5120

Sergio
