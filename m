Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fB5G4Lq09469
	for linux-mips-outgoing; Wed, 5 Dec 2001 08:04:21 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fB5G4Ho09466
	for <linux-mips@oss.sgi.com>; Wed, 5 Dec 2001 08:04:17 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id HAA14313;
	Wed, 5 Dec 2001 07:04:09 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id HAA02642;
	Wed, 5 Dec 2001 07:04:09 -0800 (PST)
Received: from mips.com (copsun14 [192.168.205.24])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fB5F44A16400;
	Wed, 5 Dec 2001 16:04:04 +0100 (MET)
Message-ID: <3C0E3764.4EC8FE58@mips.com>
Date: Wed, 05 Dec 2001 16:04:04 +0100
From: Dan Temple <dant@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Nitin <nitin.borle@broadcom.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Booting from IDE
References: <3C0E3628.9096FFF6@broadcom.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I guess you're installing as per:

ftp://ftp/pub/linux/mips/installation/redhat7.1/INSTALL

(If not, you might want to upgrade to that version).

YAMON can't read the disk file system, so you have to TFTP the kernel to memory from a remote filesystem, and then run it. The instructions are in the above file under "Booting linux on the target".

The latest version (2.02) of YAMON can read and write blocks from an IDE device (not a filesystem) so you could install a CompactFlash card and use that to store the kernel if you don't want to TFTP each time. 

There is also a $start environment variable if you want to auto-boot.

/Dan

Nitin wrote:
> 
> Hi,
> I have a very basic query. I have a MIPS Malta board. I attached a IDE
> hard disk to it and installed linux as per the instructions. At the end
> of the installation, system rebooted and control gone to the board
> monitor program(Yamon). How can I get the linux prompt? Do I need to
> write an application program which will read boot sector from hard disk,
> 
> store it in memory and pass on control to that particular location?(If
> yes, is such application already available?) Or is there a other way of
> doing it.
> 
> Thanks,
> Nitin

-- 
  Dan Temple, Eng. Mgr.     Tel: +45-44865512     
  MIPS Denmark              Fax: +45-44865556     
  Lautrupvang 4B            mailto:dant@mips.com  
  DK-2750 Ballerup          http://www.mips.com
  Denmark
