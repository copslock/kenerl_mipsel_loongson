Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2004 12:24:59 +0100 (BST)
Received: from mistral-243-146-ban.mistralsoftware.com ([IPv6:::ffff:203.196.146.243]:29927
	"EHLO Mistralsoftware.com") by linux-mips.org with ESMTP
	id <S8225806AbUFOLYz>; Tue, 15 Jun 2004 12:24:55 +0100
Received: from sarge ([192.168.13.230])
	by mistralsoftware.com (mistralsoftware.com [192.168.10.12])
	(MDaemon.PRO.v7.1.0.R)
	with ESMTP id md50000234653.msg
	for <linux-mips@linux-mips.org>; Tue, 15 Jun 2004 16:57:23 +0530
Subject: PCMCIA VR4131
From: "Suresh. R" <suresh@mistralsoftware.com>
Reply-To: suresh@mistralsoftware.com
To: linux-mips@linux-mips.org
Content-Type: text/plain
Organization: Mistral Software, Bangalore
Message-Id: <1087299491.2974.8.camel@sarge>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 15 Jun 2004 17:08:12 +0530
Content-Transfer-Encoding: 7bit
X-Spam-Processed: mistralsoftware.com, Tue, 15 Jun 2004 16:57:23 +0530
	(not processed: message from valid local sender)
X-MDRemoteIP: 192.168.13.230
X-Return-Path: suresh@mistralsoftware.com
X-MDaemon-Deliver-To: linux-mips@linux-mips.org
X-MDAV-Processed: mistralsoftware.com, Tue, 15 Jun 2004 16:57:32 +0530
Return-Path: <suresh@mistralsoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5313
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: suresh@mistralsoftware.com
Precedence: bulk
X-list: linux-mips

Hi,
  I am modifying the PCMCIA driver (linux 2.4.18 for mips) to make it
work it with the Richo controller(RF5C296). I made some hack and now the
driver is able to detect the type of controller and also the cardmgr is
detecting the type of the card plugged in properly(and properly
inserting the module for that card). But then (I am right now just
trying to make the CF storage card work with the kernel) when I load all
the modules and then run cardmgr and insert the card, I am getting the
following message. 

ide0: ports already in use, skipping probe

This messages keeps repeating for some time and then it stops saying the
resource is busy.

The pcmcia driver is right now working in the polling mode. Please help
me, if someone has done it before. I just modified the MEM base and IO
base and now outb and inb are reading from that location. So I think the
CIS is being read properly. What could be wrong ?.

Thanks in advance

Regards
Suresh



-- 
 .''`.     Suresh. R <suresh@mylug.org>
: :'  :    Proud Debian User
`. `'`
  `-  Debian - when you have better things to do than fixing a system
