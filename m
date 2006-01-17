Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2006 04:11:51 +0000 (GMT)
Received: from smtp106.biz.mail.re2.yahoo.com ([206.190.52.175]:23692 "HELO
	smtp106.biz.mail.re2.yahoo.com") by ftp.linux-mips.org with SMTP
	id S8133354AbWAQELc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 17 Jan 2006 04:11:32 +0000
Received: (qmail 14864 invoked from network); 17 Jan 2006 04:14:58 -0000
Received: from unknown (HELO ?192.168.2.27?) (dan@embeddedalley.com@69.21.252.132 with plain)
  by smtp106.biz.mail.re2.yahoo.com with SMTP; 17 Jan 2006 04:14:58 -0000
In-Reply-To: <38dc7fce0601161940s5e4375dci798f66dff58d882@mail.gmail.com>
References: <38dc7fce0601161940s5e4375dci798f66dff58d882@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <0879ce9aeb3034e5a7634c72e445fa6b@embeddedalley.com>
Content-Transfer-Encoding: 7bit
Cc:	linux-mips@linux-mips.org
From:	Dan Malek <dan@embeddedalley.com>
Subject: Re: using the 36bit physical address on AMD AU1200
Date:	Mon, 16 Jan 2006 23:14:57 -0500
To:	Youngduk Goo <ydgoo9@gmail.com>
X-Mailer: Apple Mail (2.623)
Return-Path: <dan@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9917
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@embeddedalley.com
Precedence: bulk
X-list: linux-mips


On Jan 16, 2006, at 10:40 PM, Youngduk Goo wrote:

> I guess I need to convert this address to virtual address for access 
> it.

You have to map it, yes.

> But I don't know exactly how to do it. Do I need to configure the TBL?
> I am using the YAMON as a bootloader. and try to access the DM9000.

You will have to modify the YAMON source code to map TLB entries
for the device.  Take a look at the sys_tlb_write() function along with
ensuring you update the CP0 wired register so they don't disappear.
Also, you will have to check what else may be doing this so you don't
mess up other mappings.

In Linux, all you need to do is call ioremap() and use the virtual
address returned to you.

	-- Dan
