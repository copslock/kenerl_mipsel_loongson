Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f57EfEv12539
	for linux-mips-outgoing; Thu, 7 Jun 2001 07:41:14 -0700
Received: from mail.iside.net (ns2.iside.net [212.73.214.202])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f57EfCh12535
	for <linux-mips@oss.sgi.com>; Thu, 7 Jun 2001 07:41:12 -0700
X-Virus-Protected-by-iSide: McAfee virus scanning engine
Received: from [193.251.60.11] (HELO yoshi)
  by mail.iside.net (CommuniGate Pro SMTP 3.4.7)
  with SMTP id 3563232 for linux-mips@oss.sgi.com; Thu, 07 Jun 2001 16:35:27 +0200
Message-ID: <00c501c0ef60$ceb4d3f0$662d44c3@yoshi>
From: "julien" <julien@iside.net>
To: <linux-mips@oss.sgi.com>
Subject: new comer question
Date: Thu, 7 Jun 2001 16:47:42 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4133.2400
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

First of all, I apologize for asking this kind of questions here, as
there is not many ressources for sgi/linux.

I'm following this list's discussions since many months, and I decided
to get linux running on my Indy box (R4400, Newport gfx)... To do so, I
followed standard installation instructions and used the hardhat5.1
archive located at ftp://oss.sgi.com/pub/linux/mips/redhat ...  I set up
the tftp / bootp / nfs root  on a FreeBSD box as we don't have any Linux
here, but this shouldn't be a problem, should it ?
At this point, the kernel seems to boot without any problems up to the
mount root stage, and after it crashes. Here is the last part of the
kernel outpout, transcribed by hand (hope there is all informations
needed) :

...
VFS: Mounted root (nfs filesystem)
Freeing unused kernel memory : 44k freed
page fault from irq handler : 0000
$0 : <some hexdump>                        <-- do you need these dumps
to understand what's happening ?
$4 : <some hexdump>
...
$28 : <some hexdump>
epc : 880e3e74
Status : 1004fc02
Cause : 00000008
Aiee, killing interrupt handler
Kernel panic : Attempted to kill the idle task
In swapper task - not syncing

I would appreciate any help, as you have many other better things to do
than helping newbies.

Thanx in advance

--
-------------------------------
--> julien@iside.net
-------------------------------
