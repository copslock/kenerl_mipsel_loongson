Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jun 2003 17:36:09 +0100 (BST)
Received: from pop3.galileo.co.il ([IPv6:::ffff:199.203.130.130]:11470 "EHLO
	galileo5.galileo.co.il") by linux-mips.org with ESMTP
	id <S8225211AbTFIQgH>; Mon, 9 Jun 2003 17:36:07 +0100
Received: from galileo.co.il ([10.2.2.45])
	by galileo5.galileo.co.il (8.12.6/8.12.6) with ESMTP id h59HY559020309;
	Mon, 9 Jun 2003 19:34:05 +0200 (GMT-2)
Message-ID: <3EE4C5CF.3050607@galileo.co.il>
Date: Mon, 09 Jun 2003 19:37:19 +0200
From: Baruch Chaikin <bchaikin@il.marvell.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: linux-mips@linux-mips.org, Rabeeh Khoury <rabeeh@galileo.co.il>,
	Baruch Chaikin <bchaikin@galileo.co.il>
Subject: Building a stand-alone FS on a very limited flash (newbie  question)
References: <Pine.GSO.4.44.0306061234410.4045-100000@hydra.mmc.atmel.com> <Pine.GSO.3.96.1030609164009.2806n-100000@delta.ds2.pg.gda.pl> <20030609154408.GA1781@nevyn.them.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: unlisted-recipients:; (no To-header on input)
Return-Path: <bchaikin@galileo.co.il>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bchaikin@il.marvell.com
Precedence: bulk
X-list: linux-mips

Hi all,

I'm using MIPS kernel 2.4.18 with NFS file system mounted on a RedHat 
machine. This works fine, but is unsuitable for system deployment. Do 
you have hints for me where to start, in order to put the file system on 
flash? The platform I'm using is very limited - only one MTD block of 
2.5 MB is available for the file system, out of a 4 MB flash:
    0.5 MB is allocated for the firmware code
    1.0 MB for the compressed kernel image
    2.5 MB for the (compressed?) file system

For example, I've noticed LibC itself is ~5 MB !

Thanks for any tip,
-    Baruch.
