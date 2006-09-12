Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Sep 2006 13:58:43 +0100 (BST)
Received: from [63.81.120.155] ([63.81.120.155]:55126 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S20038704AbWILM6k (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Sep 2006 13:58:40 +0100
Received: from [192.168.1.248] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id B8A4A3ED0; Tue, 12 Sep 2006 05:58:07 -0700 (PDT)
Message-ID: <4506AF69.30905@ru.mvista.com>
Date:	Tue, 12 Sep 2006 17:00:25 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Suzuki Takashi <setsu@emi.yamaha.co.jp>
Cc:	linuxppc-embedded@ozlabs.org,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: SM501 Kernel display driver for v2.6.17
References: <BDCC9646-9F98-4FFC-B0D8-A73E05B799A4@emi.yamaha.co.jp>
In-Reply-To: <BDCC9646-9F98-4FFC-B0D8-A73E05B799A4@emi.yamaha.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Suzuki Takashi wrote:
> I want to make Voyager GX PCI Demo Board Ver.A work on Yosemite board.

> I know Silicon Motion have Linux Kernel_v2.6 Display driver:
> http://www.siliconmotion.com.tw/en/en2/download2c.htm

> But it's for v2.6.4 and it cannot be compiled with v2.6.17 working on
> Yosemite board.

> Does anybody have succeeded in making the board work with v2.6.17?
> If there is a patch or source code available, let me know the location.

    I know that Linux/MIPS project maintains the framebuffer driver in 
drivers/video/smivgxfb.c. We used to backport it to 2.6.10 and it worked for 
us... Here's the link to the latest source:

http://www.linux-mips.org/git?p=linux.git;a=blob;h=c521069c905b4252109b8144478b4381c0ccdb7f;hb=db092db967ec0824db433c4adf3b58202fe610e2;f=drivers/video/smivgxfb.c

> Thanks in advance,

> -- T.Suzuki

WBR, Sergei
