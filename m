Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB5GVGV10598
	for linux-mips-outgoing; Wed, 5 Dec 2001 08:31:16 -0800
Received: from deneb.localdomain (ga-cmng-u1-c3b-97.cmngga.adelphia.net [24.53.98.97])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB5GV9o10594
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 08:31:09 -0800
Received: (from msalter@localhost)
	by deneb.localdomain (8.11.6/8.11.6) id fB5FV6N22409;
	Wed, 5 Dec 2001 10:31:06 -0500
Date: Wed, 5 Dec 2001 10:31:06 -0500
Message-Id: <200112051531.fB5FV6N22409@deneb.localdomain>
X-Authentication-Warning: deneb.localdomain: msalter set sender to msalter@redhat.com using -f
From: Mark Salter <msalter@redhat.com>
To: hartvige@mips.com
CC: dant@mips.com, nitin.borle@broadcom.com, linux-mips@oss.sgi.com
In-reply-to: <200112051510.QAA12575@copsun18.mips.com> (message from Hartvig
	Ekner on Wed, 5 Dec 2001 16:10:33 +0100 (MET))
Subject: Re: Booting from IDE
References:  <200112051510.QAA12575@copsun18.mips.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Another possibility is to replace YAMON with RedBoot. 

http://sources.redhat.com/redboot/

RedBoot can load the kernel image directly from an ext2 filesystem
on an IDE drive. You can also use it to put the kernel image and
JFFS filesystem in flash for a diskless boot.

--Mark


>>>>> Hartvig Ekner writes:

> If you feel lucky, you can also reserve space on your disk for the kernel - 
> either in a separate partition, or outside the area used by your current
> partitions. The YAMON 02.02 or later can read the kernel directly from disk
> and execute it.

> I do this on my Malta board with one disk.

> /Hartvig


> Dan Temple writes:
>> 
>> I guess you're installing as per:
>> 
>> ftp://ftp/pub/linux/mips/installation/redhat7.1/INSTALL
>> 
>> (If not, you might want to upgrade to that version).
>> 
>> YAMON can't read the disk file system, so you have to TFTP the kernel to memory from a remote filesystem, and then run it. The instructions are in the above file under "Booting linux on the target".
>> 
>> The latest version (2.02) of YAMON can read and write blocks from an IDE device (not a filesystem) so you could install a CompactFlash card and use that to store the kernel if you don't want to TFTP each time. 
>> 
>> There is also a $start environment variable if you want to auto-boot.
>> 
>> /Dan
>> 
>> Nitin wrote:
>> > 
>> > Hi,
>> > I have a very basic query. I have a MIPS Malta board. I attached a IDE
>> > hard disk to it and installed linux as per the instructions. At the end
>> > of the installation, system rebooted and control gone to the board
>> > monitor program(Yamon). How can I get the linux prompt? Do I need to
>> > write an application program which will read boot sector from hard disk,
>> > 
>> > store it in memory and pass on control to that particular location?(If
>> > yes, is such application already available?) Or is there a other way of
>> > doing it.
>> > 
>> > Thanks,
>> > Nitin
