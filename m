Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2005 13:26:13 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:6023
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8225257AbVHYMZ4>; Thu, 25 Aug 2005 13:25:56 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id j7PCVOkC001471;
	Thu, 25 Aug 2005 05:31:25 -0700 (PDT)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.9/8.12.11) with ESMTP id j7PCVOvU020259;
	Thu, 25 Aug 2005 05:31:24 -0700 (PDT)
Message-ID: <430DBB61.2020104@mips.com>
Date:	Thu, 25 Aug 2005 14:36:49 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	colin <colin@realtek.com.tw>
CC:	linux-mips@linux-mips.org
Subject: Re: Please suggest one PCI VGA card for Malta board
References: <008e01c5a96b$fce24810$106215ac@realtek.com.tw>
In-Reply-To: <008e01c5a96b$fce24810$106215ac@realtek.com.tw>
Content-Type: text/plain; charset=Big5
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8800
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

colin wrote:
> Hi there,
> We want to use frame buffer on Malta board to see the video display of our
> application.
> Therefore, we need one vga card that can be used on Malta board with Linux
> 2.6.11 "without modifying driver".
> Could you suggest us a "common" vga card that can easily do that?

I had some reasonable luck with a Matrox Millenium G450 PCI,
but only when running with a "real" CPU on the Malta.   It
seemed to have problems when working with a CoreFPGA2 module,
and since I didn't need it for the work I was doing with
the FPGA, I pulled it out instead of debugging the problem,
which might have been something really simple and stupid.

			Kevin K.
