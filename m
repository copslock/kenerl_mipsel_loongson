Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Oct 2005 11:49:10 +0100 (BST)
Received: from imsantv21.netvigator.com ([210.87.250.86]:37780 "EHLO
	imsantv21.netvigator.com") by ftp.linux-mips.org with ESMTP
	id S8133606AbVJ1Ksx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Oct 2005 11:48:53 +0100
Received: from imsantv44.netvigator.com (imsantv21 [127.0.0.1])
	by imsantv21.netvigator.com (8.13.1/8.13.1) with ESMTP id j9SAmtW6004319
	for <linux-mips@linux-mips.org>; Fri, 28 Oct 2005 18:48:59 +0800
Received: from LOUISLAI (ipvpn008225.netvigator.com [203.198.58.225])
	by imsantv44.netvigator.com (8.13.1/8.13.1) with SMTP id j9SAmraf011883;
	Fri, 28 Oct 2005 18:48:53 +0800
From:	"Louis Lai" <louis.lai@entone.com>
To:	"Yoann Allain" <yallain@avilinks.com>
Cc:	<linuxconsole-dev@lists.sourceforge.net>,
	<linux-mips@linux-mips.org>
Subject: RE: missing /dev/tty0
Date:	Fri, 28 Oct 2005 18:43:31 +0800
Message-ID: <HAENJFHIMADGCOMALOKKIEEMCBAA.louis.lai@entone.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
In-Reply-To: <4361FCEF.30707@avilinks.com>
Return-Path: <louis.lai@entone.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: louis.lai@entone.com
Precedence: bulk
X-list: linux-mips

Hi Yoann,

Thanks for your reply!!
i can create the device file but i still not able to open it.
When i open /dev/tty0, i got "No such device".
Any ideas??

Thanks again,
Louis

-----Original Message-----
From: Yoann Allain [mailto:yallain@avilinks.com]
Sent: Friday, October 28, 2005 6:27 PM
To: Louis Lai
Cc: linuxconsole-dev@lists.sourceforge.net; linux-mips@linux-mips.org
Subject: Re: missing /dev/tty0


Louis Lai a écrit :

>Hi all,
>
>I am using a 2.4.30 kernel for my MIPS embedded processor. The kernel can
>start up properly but the tty0 doesn't exist under /dev. I have already
>enable the virtual console during kernel configuration. is it something
>configure not properly for the kernel?? Anyone can help??
>
>Thanks in advance,
>Louis
>
>
>
Hi Louis,

The problem is that you didn't create the special file /dev/tty0. Create
it with the mknod command :
# mknod /dev/tty0 c 4 0
Then put the good rights, for example:
# chmod 640 /dev/tty0
That should do it...

    Yoann
