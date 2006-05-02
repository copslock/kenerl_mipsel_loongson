Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 May 2006 22:22:24 +0100 (BST)
Received: from smtp115.iad.emailsrvr.com ([207.97.245.115]:50335 "HELO
	smtp135.iad.emailsrvr.com") by ftp.linux-mips.org with SMTP
	id S8133953AbWEBVWO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 2 May 2006 22:22:14 +0100
Received: from ratin (adsl-69-233-145-110.dsl.sndg02.pacbell.net [69.233.145.110])
	(Authenticated sender: mrahman@sypixx.com)
	by relay1.r1.iad.emailsrvr.com (SMTP Server) with ESMTP id 99B88451674
	for <linux-mips@linux-mips.org>; Tue,  2 May 2006 17:22:06 -0400 (EDT)
Message-ID: <007e01c66e2e$8008f720$2300a8c0@ratin>
Reply-To: "Ratin" <mrahman@sypixx.com>
From:	"Ratin" <mrahman@sypixx.com>
To:	<linux-mips@linux-mips.org>
References: <4456960D.70403@telus.net> <20060502193838.GA3474@linux-mips.org>
Subject: changing IP address on mipsel-linux 
Date:	Tue, 2 May 2006 14:22:21 -0700
Organization: Sypixx Networks
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2869
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
X-Virus-Scanned: OK
Return-Path: <mrahman@sypixx.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11283
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrahman@sypixx.com
Precedence: bulk
X-list: linux-mips

I am not sure if this is the right mailing list (new here) but how would you 
change the IP address parmanently on
a box having IDT C32H434 CPU ? There seems to be no /etc/init.d/network on 
this box. I could
do it with ifconfig but I need to make parmanent change as well as effective 
right away.

The other question is when I change the IP address on the fly with ifconfig, 
is there a way to make the
inet listener apps (that are running in the background) to autometically 
listen on the new IP address?

Thanks,

Ratin
