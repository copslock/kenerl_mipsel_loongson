Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 May 2004 16:07:48 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:13696
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225474AbUEQPHp>; Mon, 17 May 2004 16:07:45 +0100
Received: (qmail 31959 invoked by uid 204); 18 May 2004 01:07:33 +1000
Received: from stuartl@longlandclan.hopto.org by www by uid 201 with qmail-scanner-1.16 
 (spamassassin: 2.63.  Clear:. 
 Processed in 0.035041 secs); 17 May 2004 15:07:33 -0000
Received: from unknown (HELO longlandclan.hopto.org) (10.0.0.251)
  by 192.168.5.1 with SMTP; 18 May 2004 01:07:32 +1000
Message-ID: <40A8D534.6010706@longlandclan.hopto.org>
Date: Tue, 18 May 2004 01:07:32 +1000
From: Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 0.5 (Windows/20040207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kieran Fulke <kieran@pawsoff.org>
CC: linux-mips@linux-mips.org
Subject: Re: IRQ problem on cobalt / 2.6.6
References: <20040513183059.GA25743@getyour.pawsoff.org>
In-Reply-To: <20040513183059.GA25743@getyour.pawsoff.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

Kieran Fulke wrote:
> hi folks, 
> 
> getting the below when loading the dvb budget_ci module. it disables IRQ 
> #23 which is attached to the card, rendering it useless. i asked the 
> same question over there and none of them suspect it to be a DVB 
> problem. some esoteric pci bug perhaps?
> 

If it's any help... I've had similar issues trying to use an Adaptec 
AHA-2940AU PCI SCSI card in a Gateway Microserver running Linux 2.6.[56] 
(not sure which one exactly...).  I'm now running Linux 2.4.26 quite 
happily (the box is being used as a fileserver for LANs), but I can put 
2.6.6 back on if the debugging info would be of any use.

-- 
+-------------------------------------------------------------+
| Stuart Longland           stuartl at longlandclan.hopto.org |
| Brisbane Mesh Node: 719             http://stuartl.cjb.net/ |
| I haven't lost my mind - it's backed up on a tape somewhere |
| Atomic Linux Project    <--->    http://atomicl.berlios.de/ |
+-------------------------------------------------------------+
