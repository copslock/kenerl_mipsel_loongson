Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5UNXNk27809
	for linux-mips-outgoing; Sat, 30 Jun 2001 16:33:23 -0700
Received: from web13903.mail.yahoo.com (web13903.mail.yahoo.com [216.136.175.29])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5UNXNV27806
	for <linux-mips@oss.sgi.com>; Sat, 30 Jun 2001 16:33:23 -0700
Message-ID: <20010630233322.81749.qmail@web13903.mail.yahoo.com>
Received: from [61.187.63.244] by web13903.mail.yahoo.com; Sat, 30 Jun 2001 16:33:22 PDT
Date: Sat, 30 Jun 2001 16:33:22 -0700 (PDT)
From: Barry Wu <wqb123@yahoo.com>
Subject: about IDE0 interrupt
To: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Hi, all,

I am porting linux to our mipsel system. 
I make a ext2fs system on my intel system, then
copy root file system to this hard disk. Finally
I attach this disk to our mipsel system. Our
system use Acer Lab Ali1535D south bridge. When
linux kernel start, it can report disk volume
information and partition information, and root
file system is mounted. But the time is very long,
and I could not get any ide0 interrupt. The time
is wasted on schedule(), but if I use ramdisk, the
system is running fast. I think the problem is my
IDE controller driver or hardware problem. Does some
one know the reason? If so, please help me.
Thanks!

Barry

__________________________________________________
Do You Yahoo!?
Get personalized email addresses from Yahoo! Mail
http://personal.mail.yahoo.com/
