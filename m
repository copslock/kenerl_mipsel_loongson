Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 16:27:42 +0000 (GMT)
Received: from law10-f105.law10.hotmail.com ([IPv6:::ffff:64.4.15.105]:53007
	"EHLO hotmail.com") by linux-mips.org with ESMTP
	id <S8224934AbTL2Q1k>; Mon, 29 Dec 2003 16:27:40 +0000
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 29 Dec 2003 08:27:32 -0800
Received: from 63.121.54.5 by lw10fd.law10.hotmail.msn.com with HTTP;
	Mon, 29 Dec 2003 16:27:32 GMT
X-Originating-IP: [63.121.54.5]
X-Originating-Email: [juszczec@hotmail.com]
X-Sender: juszczec@hotmail.com
From: "Mark and Janice Juszczec" <juszczec@hotmail.com>
To: dan@debian.org
Cc: kevink@mips.com, linux-mips@linux-mips.org
Subject: Re: gdbserver and Re: hardware questions
Date: Mon, 29 Dec 2003 16:27:32 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <Law10-F10555qtVdTVv000632af@hotmail.com>
X-OriginalArrivalTime: 29 Dec 2003 16:27:32.0941 (UTC) FILETIME=[A93607D0:01C3CE28]
Return-Path: <juszczec@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juszczec@hotmail.com
Precedence: bulk
X-list: linux-mips


Daniel et al


>
>Try changing /etc/inittab to disable the getty, and starting gdbserver
>from the system startup scripts in /etc/rc*.

I'm using busybox since, at the time, it was easier than figuring out what 
goes on in /etc/rc*
I'll check if there's a way to disable the busybox init or at least tell it 
not to start a shell on the serial port.  I suppose I could hack busybox to 
start gdbserver.    Hmmmmm

>I'm assuming you have
>some other way than that shell on ttyS0 to modify the filesystem :)
>

Yes.  I flash a filesystem image to the pda.  I generate the image from 
files on my laptop.  The problem is squeezing everything into 2mb of flash.  
I wonder if I can shove stuff in the 8Mb of ram somehow.

Mark


>--
>Daniel Jacobowitz
>MontaVista Software                         Debian GNU/Linux Developer

_________________________________________________________________
Working moms: Find helpful tips here on managing kids, home, work —  and 
yourself.   http://special.msn.com/msnbc/workingmom.armx
