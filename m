Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Sep 2004 05:55:23 +0100 (BST)
Received: from ip-66-80-10-146.dsl.sca.megapath.net ([IPv6:::ffff:66.80.10.146]:52843
	"EHLO brahma.intotoind.com") by linux-mips.org with ESMTP
	id <S8224827AbUIOEzT>; Wed, 15 Sep 2004 05:55:19 +0100
Received: from rajeshbv.intoto.com (3mc130.intotoind.com [172.16.3.130])
	by brahma.intotoind.com (8.12.11/8.12.8) with ESMTP id i8F4t58F027015;
	Wed, 15 Sep 2004 10:25:07 +0530
Message-Id: <5.1.0.14.0.20040915103551.03b2ec90@172.16.1.10>
X-Sender: rajeshbv@172.16.1.10
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Wed, 15 Sep 2004 10:45:06 +0530
To: linux-mips@linux-mips.org
From: "Rajesh B. V." <rajeshbv@intoto.com>
Subject: Problem with ARP response
Cc: rajeshbv@intoto.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
X-Scanned-By: MIMEDefang 2.41
Return-Path: <rajeshbv@intoto.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5836
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rajeshbv@intoto.com
Precedence: bulk
X-list: linux-mips

Hi All,

I have a network setup where both the LAN interface (eth0) and WAN 
interface (eth1) of a Router running Linux will be put into same Switch.
The setup is :
LAN network is : 192.168.1.0/24  ( Router LAN interface IP is 
192.168.1.1/24 with xx:01 as MAC)
Router WAN interface IP is a static public IP with xx:02 as MAC.

Now when a PC from the LAN networks tries to reach (ping) LAN interface 
(eth0) of Router i observe vague ARP entry in the PC for the IP.
I see some times WAN interface (eth1) MAC as the ARP entry in PC and some 
times LAN interface (eth0) MAC as the ARP entry in the PC.
For every ARP request i see two responses one with WAN interface MAC and 
one with LAN interface MAC.

I observed this is happening because, both the interfaces are receiving the 
ARP broadcast request from the PC and sending up the stack to ARP module 
and which responds with the corresponding interface MAC upon which it 
received the packet.

My requirement is to make ARP module not to respond for the packet received 
on WAN interface (eth1) with requested IP as LAN interface (eth0) IP.

Will the arp_filter () in net/ipv4/arp.c can do this ?
Also is there any draw back by doing so ?

Regards,
--Rajesh
