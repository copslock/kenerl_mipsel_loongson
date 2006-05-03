Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 May 2006 17:11:40 +0100 (BST)
Received: from smtp135.iad.emailsrvr.com ([207.97.245.135]:5834 "HELO
	smtp135.iad.emailsrvr.com") by ftp.linux-mips.org with SMTP
	id S8133465AbWECQLa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 3 May 2006 17:11:30 +0100
Received: from ratin (adsl-69-233-145-110.dsl.sndg02.pacbell.net [69.233.145.110])
	(Authenticated sender: mrahman@sypixx.com)
	by relay3.r3.iad.emailsrvr.com (SMTP Server) with ESMTP id 625B744C6F8;
	Wed,  3 May 2006 12:11:21 -0400 (EDT)
Message-ID: <005501c66ecc$4b2ef470$2300a8c0@ratin>
Reply-To: "Ratin" <mrahman@sypixx.com>
From:	"Ratin" <mrahman@sypixx.com>
To:	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
Cc:	<linux-mips@linux-mips.org>
References: <4456960D.70403@telus.net> <20060502193838.GA3474@linux-mips.org> <007e01c66e2e$8008f720$2300a8c0@ratin> <20060503071103.GC11097@dusktilldawn.nl>
Subject: Re: changing IP address on mipsel-linux
Date:	Wed, 3 May 2006 09:11:53 -0700
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
X-archive-position: 11291
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mrahman@sypixx.com
Precedence: bulk
X-list: linux-mips

Hi Freddy, Thanks for your response, I appreciate your help. I am kind of 
new to this version of Linux.
The uname -a gives me this:

Linux 192.168.0.62 2.6.10-idt20050328 #1 Tue Dec 13 10:36:55 PST 2005 mips 
unknown

But it is referred as Mipsel-Linux. It is running busybox.  I guess I have 
to dig more into kernel code to see how the
kernel sets the IP address during init. I was hoping somebody here would 
know the Mipsel-Linux IP address assignment
process. Thanks,

 Ratin

----- Original Message ----- 
From: "Freddy Spierenburg" <freddy@dusktilldawn.nl>
To: "Ratin" <mrahman@sypixx.com>
Cc: <linux-mips@linux-mips.org>
Sent: Wednesday, May 03, 2006 12:11 AM
Subject: Re: changing IP address on mipsel-linux
