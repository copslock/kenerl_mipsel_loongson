Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Oct 2004 09:56:23 +0100 (BST)
Received: from adsl-68-124-224-226.dsl.snfc21.pacbell.net ([IPv6:::ffff:68.124.224.226]:36111
	"EHLO goobz.com") by linux-mips.org with ESMTP id <S8224924AbUJKI4T>;
	Mon, 11 Oct 2004 09:56:19 +0100
Received: from [10.2.2.70] (adsl-63-194-214-47.dsl.snfc21.pacbell.net [63.194.214.47])
	by goobz.com (8.10.1/8.10.1) with ESMTP id i9B8uGu23695
	for <linux-mips@linux-mips.org>; Mon, 11 Oct 2004 01:56:16 -0700
Message-ID: <416A4AA7.4010002@embeddedalley.com>
Date: Mon, 11 Oct 2004 01:56:07 -0700
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla Thunderbird 0.7.3 (X11/20040803)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Au1x 2.6 updates
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


I've pushed in a large number of 2.6 patches for the Au1x. The Db1500 is 
now very usable and almost completely up to date, including pci, pcmcia, 
usb host, audio (oss), and mtd. The rest of the Db1x boards will follow. 
There are a few patches in my directory that are needed, until Ralf 
approves them and applies them. The directory is 
ftp.linux-mips.org:/pub/linux/mips/people/ppopov/2.6. The 36 bit patch 
is mandatory; the ide patch is nice but not mandatory; the zImage is 
also optional; the pcmcia patch is mandatory if you're going to use pcmcia.

I'll apply the pcmcia patch after some additional testing and then get 
rid of the patch. The driver now does not require the 64bit pcmcia patch 
that was hard to get accepted in the community tree. The patch uses the 
current fixup_bigphys_addr() mechanism, which was already in place 
anyway. Thanks to Matt Porter for the simple but brilliant suggestion :)

Let me know if you find any problems.

Thanks,

Pete Popov
Embedded Alley Solutions, Inc
ppopov@embeddedalley.com
