Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Feb 2004 21:48:36 +0000 (GMT)
Received: from mo02.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:23020 "EHLO
	mo02.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225515AbUBIVsf>;
	Mon, 9 Feb 2004 21:48:35 +0000
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo02.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id GAA28692;
	Tue, 10 Feb 2004 06:48:28 +0900 (JST)
Received: 4UMDO01 id i19LmSX06940; Tue, 10 Feb 2004 06:48:28 +0900 (JST)
Received: 4UMRO01 id i19LmQr04198; Tue, 10 Feb 2004 06:48:27 +0900 (JST)
	from stratos.frog (64.43.138.210.xn.2iij.net [210.138.43.64]) (authenticated)
Date: Tue, 10 Feb 2004 06:48:21 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Tahoma Toelkes <tahoma@nshore.com>
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: Re: difficulties with NFSROOT and DHCP
Message-Id: <20040210064821.7ef6a72f.yuasa@hh.iij4u.or.jp>
In-Reply-To: <4027F08D.5030601@nshore.com>
References: <4027F08D.5030601@nshore.com>
X-Mailer: Sylpheed version 0.9.9 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi,

On Mon, 09 Feb 2004 14:41:49 -0600
Tahoma Toelkes <tahoma@nshore.com> wrote:

> The context is that I am in the process of bringing up a 2.4.24 kernel 
> (pulled from linux-mips CVS using the linux_2_4_24 tag) on a DBAu1500 
> board (Zinfandel).
> 
> I'm having trouble mounting my root filesystem over NFS.  After the 
> ethernet ports have been enumerated, the kernel attempts to contact the 
> DHCP server to obtain its IP configuration information.  At this point 
> the boot sequence hangs, perpetually retrying the DHCP server.  Here are 
> the last several lines from the log of the boot messages, prefixed with 
> a vertical bar to set them apart:
> 
> | Sending DHCP requests .<6>eth0: link up
> | eth0: going to full duplex
> | ..... timed out!
> | IP-Config: Retrying forever (NFS root)...
> | Sending DHCP requests ...... timed out!
> | IP-Config: Retrying forever (NFS root)...
> | Sending DHCP requests ..
> 
> I've verified that the exported root filesystem can be mounted by 
> another Linux workstation.  I've also verified on the DHCP server that 
> it is seeing the board initiate a DHCP discovery and that the DHCP 
> server is replying with offer for the correct address.  Here is an 
> excerpt from '/var/log/messages' on the DHCP server:
> 
> | Feb  9 13:25:33 kapala dhcpd: DHCPDISCOVER from 00:50:c2:0c:38:8a via eth0
> | Feb  9 13:25:33 kapala dhcpd: DHCPOFFER on 172.16.108.42 to 
> 00:50:c2:0c:38:8a via eth0

Please try the following option.

YAMON> go . root=/dev/nfs nfsroot=172.16.108.11:/export/root ip=dhcp


> For completeness sake, I've attached the full log of the boot sequence 
> until it hangs as well as my current kernel configuration.  If any of 
> you have seen this particular problem and know how to get around it, 
> please respond.  Further, if you simply have suggestions for avenues I 
> could explore, I would appreciate any advice you might have to offer.

Yoichi
