Received:  by oss.sgi.com id <S553783AbQLOSZP>;
	Fri, 15 Dec 2000 10:25:15 -0800
Received: from mx.mips.com ([206.31.31.226]:8924 "EHLO mx.mips.com")
	by oss.sgi.com with ESMTP id <S553770AbQLOSZE>;
	Fri, 15 Dec 2000 10:25:04 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id KAA23981;
	Fri, 15 Dec 2000 10:24:48 -0800 (PST)
Received: from Ulysses (ulysses [192.168.236.13])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id KAA20755;
	Fri, 15 Dec 2000 10:24:54 -0800 (PST)
Message-ID: <001301c066c4$d2b9f7c0$0deca8c0@Ulysses>
From:   "Kevin D. Kissell" <kevink@mips.com>
To:     "Nicu Popovici" <octavp@isratech.ro>, <linux-mips@oss.sgi.com>
References: <3A3ABFA9.8608799D@isratech.ro>
Subject: Re: Little endian.
Date:   Fri, 15 Dec 2000 19:28:15 +0100
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
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

If you want to run little-endian, you need to install
the little-endian binaries and libraries.  Since I needed
to "swing both ways", I put both a big-endian root and
a little-endian root partition on my Atlas disk, with user/data 
partitions that can be mounted on either one - fortunately, 
the Ext2FS metadata seems to be consistent regardless 
of endianness.

            Kevin K.

----- Original Message ----- 
From: "Nicu Popovici" <octavp@isratech.ro>
To: <linux-mips@oss.sgi.com>
Sent: Saturday, December 16, 2000 2:04 AM
Subject: Little endian.


> Hello ,
> 
> I have the follwing problem. I setup a HardHat distribution on a mips
> machine ( an ATLAS board) and everithing runs fine in big-endian mode.
> Now I want to run the board inlittle endian mode so I took the
> linux/mipsel distribution , I did the same steps as with big-endian
> distribution. I run load tftp:/linux/mipsel/vmlinux-el.srec and it works
> fine . Then I issue the command go . root=/dev/sda1 ( I do not install
> the HardHat again ???? maybe here it is the problem ) I get the
> following error.
> ==========================================================
> VFS: Mounted root (ext2 filesystem) readonly.
> Freeing prom memory: 1020k freed
> Freeing unused kernel memory: 68k freed
> Kernel panic: No init found.  Try passing init= option to kernel.
> ==========================================================
> So please tell me where did I go wrong ?
> 
> Nicu
> 
