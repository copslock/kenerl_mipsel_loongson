Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g76BXMRw014923
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 6 Aug 2002 04:33:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g76BXMG9014922
	for linux-mips-outgoing; Tue, 6 Aug 2002 04:33:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from pacrs180.mgmt.panalpina.ch (ns2.panalpina.ch [194.11.79.70])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g76BXDRw014909
	for <linux-mips@oss.sgi.com>; Tue, 6 Aug 2002 04:33:14 -0700
Received: from pac2k460.corp.panorg.com (pac2k460.corp.panorg.com [157.168.190.17])
	by pacrs180.mgmt.panalpina.ch (8.10.1/8.10.1) with ESMTP id g76BZ9p400126
	for <linux-mips@oss.sgi.com>; Tue, 6 Aug 2002 13:35:09 +0200
Received: from pac2k540.corp.panorg.com (unverified) by pac2k460.corp.panorg.com
 (Content Technologies SMTPRS 4.2.10) with ESMTP id <T5c8c2f6b509da8be11624@pac2k460.corp.panorg.com> for <linux-mips@oss.sgi.com>;
 Tue, 6 Aug 2002 13:35:09 +0200
Received: from ams2k020.europe.panorg.com ([194.11.64.156]) by pac2k540.corp.panorg.com with Microsoft SMTPSVC(5.0.2195.4905);
	 Tue, 6 Aug 2002 13:35:08 +0200
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: how to build a kernel for the Origin 200 ?
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
Date: Tue, 6 Aug 2002 13:34:47 +0200
Message-ID: <D6FDE23B67E2A34691BDFFC03C9D3E3B4CEBBD@ams2k020.europe.panorg.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: how to build a kernel for the Origin 200 ?
Thread-Index: AcI9PcpgncxC6KkIEdatmwAEdYa7pA==
From: "AMS Hoogland Yvar" <Yvar.Hoogland@panalpina.com>
To: <linux-mips@oss.sgi.com>
X-OriginalArrivalTime: 06 Aug 2002 11:35:08.0944 (UTC) FILETIME=[51800900:01C23D3D]
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id g76BXFRw014911
X-Spam-Status: No, hits=-0.1 required=5.0 tests=SUBJ_ENDS_IN_Q_MARK version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I'm pretty new to all this, but am planning on installing Debian on
an Origin 200 server I got from my IT dept.

However, when I got it it lacked a cd-rom and harddisk, I got both, 
a correct Toshiba CD-ROM and a 4.3 GB SCA harddisk in the bottom
(system disk) slot.

The hard disk is to my best knowledge empty ! So I do not have 
IRIX installed or available.

I hooked the server (which does not have a display connector) to
an Etherminal C thin client through a serial connection and its 
ANSI emulator

So know I can see the boot sequence and the prompt below the 5 options
looking like this:

+++++++++++++++
1) Start System
2) Install System Software
3) Run Diagnostics
4) Recover System
5) Enter Command Monitor

Option? 
+++++++++++++++

So where do I go from here ? I understand by now that I first need to build
a cross-compiler and binutils then crosscompile a kernel. I read the FAQ
at the linux-mips site.

My first concern is how to get the needed software onto the Origin's hdd, 
is it possible from cd-rom or are there other options ? And make it accessible.

Also I noticed that the Origin does not have fdisk ? Do I need to partition
anything ?

Lot of questions, I know, hope someone can spare some time to get me on
the road.

Appreciate it, Yvar
