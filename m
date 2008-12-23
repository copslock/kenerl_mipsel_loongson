Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Dec 2008 14:48:28 +0000 (GMT)
Received: from yw-out-1718.google.com ([74.125.46.154]:31062 "EHLO
	yw-out-1718.google.com") by ftp.linux-mips.org with ESMTP
	id S24207990AbYLWOsZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 23 Dec 2008 14:48:25 +0000
Received: by yw-out-1718.google.com with SMTP id 9so864264ywk.24
        for <linux-mips@linux-mips.org>; Tue, 23 Dec 2008 06:48:23 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to
         :subject:mime-version:content-type:content-transfer-encoding
         :content-disposition;
        bh=Ao1JkekF52YNF6/P4rjvooYYfjQACztCdME/7PRhV50=;
        b=b/EV6dDmlhIXnBe1IvkeLGXqzPpmG82GkbSS0fWlE4knL7tavHI44f261qnfonhc1q
         6nUxEIXEmGjxKaFD9CLvOG8NUA0vGSmnXL1AvRCY6jUc/AIvL/wwiL8RkECZzWqp+Kkj
         Nsyx/DbLgDa8LYbVGcpLEtkPQ7k7CS6hp+Pu4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type
         :content-transfer-encoding:content-disposition;
        b=DZyWg4LNNzL4GfkQ5CzjIRzJLapizThBpPB8+kT4ix0JwjhBhFZRbupAw+n+m8fCCp
         8cQzpzqhLtKCM5UxNOXBpDeJ2ScbKR02KFe7jm8GXAP4RBAggF21pYOWk4m8vlpnC7Qz
         jv5tDTuqpUWWGR4QolLPleK9DVXgOD/athvZ0=
Received: by 10.150.92.10 with SMTP id p10mr14137919ybb.45.1230043703496;
        Tue, 23 Dec 2008 06:48:23 -0800 (PST)
Received: by 10.150.139.3 with HTTP; Tue, 23 Dec 2008 06:48:23 -0800 (PST)
Message-ID: <fce2a370812230648s798ebbf6y1387a237ae640e39@mail.gmail.com>
Date:	Tue, 23 Dec 2008 16:48:23 +0200
From:	"Ihar Hrachyshka" <ihar.hrachyshka@gmail.com>
To:	linux-mips@linux-mips.org
Subject: NXP STB225 board support
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Return-Path: <ihar.hrachyshka@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ihar.hrachyshka@gmail.com
Precedence: bulk
X-list: linux-mips

Hello!
I try to start vanilla linux kernel on pnx-8335-stb225 board. What I did:
1. ARCH=mips make pnx-8335-stb225_defconfig
2. ARCH=mips make
3. Prepared U-Boot image with mkimage.

After booting it up I get the following output on my UART:

Linux version 2.6.28-rc9.netflix.PR12_RC2 (booxter@EPBYMINW0568) (gcc
version 4.2.1) #3 PREEMPT Tue Dec 23 15:52:10 EET 2008
CPU revision is: 00019068 (MIPS 4KEc)
Determined physical RAM map:
 memory: 10000000 @ 00000000 (usable)
Zone PFN ranges:
  Normal   0x00000000 -> 0x00010000
Movable zone start PFN for each node
early_node_map[1] active PFN ranges
    0: 0x00000000 -> 0x00010000
Built 1 zonelists in Zone order, mobility grouping on.  Total pages: 65024
Kernel command line:
mtdparts=gen_nand:128k(Boot0),1M(Boot1),512k(Env),4M(Kernel),16M(Filesystem)
ip3902.mac_address=00:60:37:03:00:00 ip=10.6.2.53:10.6.27.3
Unknown boot option `ip3902.mac_address=00:60:37:03:00:00': ignoring
Primary instruction cache 16kB, VIPT, 2-way, linesize 16 bytes.
Primary data cache 8kB, 4-way, VIPT, no aliases, linesize 16 bytes
PID hash table entries: 1024 (order: 10, 4096 bytes)
CPU clock is 320 MHz
Console: colour dummy device 80x25
console [ttyS0] enabled

After this last message there is no any activity. It seems that kernel
hanged. What can I do to see what's going on (maybe stack trace)? Any
suggestions?
Has anyone started the board successfully with vanilla kernel?

Thanks in advance,
Ihar Hrachyshka
