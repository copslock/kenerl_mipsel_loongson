Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g7KFtKEC031426
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 20 Aug 2002 08:55:20 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g7KFtKhM031425
	for linux-mips-outgoing; Tue, 20 Aug 2002 08:55:20 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from postman.medtronic.com (postman.medtronic.COM [144.15.157.121])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g7KFtFEC031415
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 08:55:16 -0700
Received: from RADIUM (localhost [127.0.0.1])
	by postman.medtronic.com (8.10.1/8.10.1) with SMTP id g7KFwDL18844
	for <linux-mips@oss.sgi.com>; Tue, 20 Aug 2002 10:58:13 -0500 (CDT)
From: "Lyle Bainbridge" <lyle@zevion.com>
To: <linux-mips@oss.sgi.com>
Subject: Mips cross toolchain
Date: Tue, 20 Aug 2002 10:58:13 -0500
Message-ID: <NCBBKGDBOEEBDOELAFOFKEGGCPAA.lyle@zevion.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2910.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I'm a linux kernel newbie, and this is my first linux-mips posting.
I have built a big endian, elf, cross toolchain for mips32 (I'm using
an Alchemy Au1500 SOC) based on the GCC 3.0.4, Binutils 2.11.2 and
Newlib 1.9.0.  My intention is to now use it to compile the 2.4.19 kernel.

I am still figuring out how to cross compile the kernel, but I was
wondering if I had used the correct versions of GCC and Binutils to
succesfully build a stable kernel.  Also, are there any patches I would
need? So far I've used the stock distributions from gnu.org.

Any advice would be most appreciated.

Thanks,
Lyle Bainbridge
Minneapolis, MN
