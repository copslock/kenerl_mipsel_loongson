Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2005 00:29:18 +0100 (BST)
Received: from wproxy.gmail.com ([IPv6:::ffff:64.233.184.207]:34844 "EHLO
	wproxy.gmail.com") by linux-mips.org with ESMTP id <S8225769AbVDIX3D>;
	Sun, 10 Apr 2005 00:29:03 +0100
Received: by wproxy.gmail.com with SMTP id 68so2279380wra
        for <linux-mips@linux-mips.org>; Sat, 09 Apr 2005 16:28:57 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=EZFh78IPnapODGNy5OgMIqyalsG4XuJofV7d7gh13mLHhsWTGpeMySzh0JzWUkC9n89RDbnjPT9g4hhMfeCekcSC9WvdrjQzOpkGddfVlisxf3PqnYp4FJO+7+qHyBVhMecJOw9SRyxndcgoa7ukogbS06XGimsDwJpONZwJnyA=
Received: by 10.54.53.38 with SMTP id b38mr841805wra;
        Sat, 09 Apr 2005 16:28:56 -0700 (PDT)
Received: by 10.54.53.56 with HTTP; Sat, 9 Apr 2005 16:28:56 -0700 (PDT)
Message-ID: <fda764b0504091628158f8f39@mail.gmail.com>
Date:	Sat, 9 Apr 2005 16:28:56 -0700
From:	Pratik Patel <pratikgpatel@gmail.com>
Reply-To: Pratik Patel <pratikgpatel@gmail.com>
To:	linux-mips@linux-mips.org
Subject: problems compiling prog. for mipsel platform
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <pratikgpatel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7668
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pratikgpatel@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I compiled libpcap for mipsel platform. Now I have the proper
libpcap.a file. I had to bring the ifaddrs.h file from /usr/bin/
folder.

When I compile a simple program (ldev.c) available at:
http://www.cet.nau.edu/~mc8/Socket/Tutorials/section1.html

Output of the program:
[pratik@Akshar libpcap_samples]$ mipsel-uclibc-gcc ldev.c -lpcap
/opt/brcm/hndtools-mipsel-uclibc-0.9.19/lib/libpcap.a(fad-getad.o): In
function `pcap_findalldevs':
fad-getad.c(.text+0xa4): undefined reference to `getifaddrs'
fad-getad.c(.text+0x2e0): undefined reference to `freeifaddrs'
/opt/brcm/hndtools-mipsel-uclibc-0.9.19/lib/libpcap.a(nametoaddr.o):
In function `pcap_ether_hostton':
nametoaddr.c(.text+0x764): undefined reference to `ether_hostton'
collect2: ld returned 1 exit status
[pratik@Akshar libpcap_samples]$

Are ther any patches for the ifaddrs.h file?

Cheers,
Pratik
