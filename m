Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2008 16:42:23 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:27512 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S28605406AbYCRQmV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 18 Mar 2008 16:42:21 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id 1D01F3ECA; Tue, 18 Mar 2008 09:42:19 -0700 (PDT)
Message-ID: <47DFF13B.5060108@ru.mvista.com>
Date:	Tue, 18 Mar 2008 19:43:39 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Nico Coesel <ncoesel@DEALogic.nl>
Cc:	linux-mips@linux-mips.org
Subject: Serial console on Au1100 
References: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF85B@dealogicserver.DEALogic.nl>
In-Reply-To: <19CA9E279FDA5246B7D7A1C91A4AF7F40EF85B@dealogicserver.DEALogic.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Nico Coesel wrote:

> Hello all,
> I didn't follow the entire discussion, but I might have similar problems
> on the AU1100 SoC. The AU1100 also has 16550 style serial ports. The
> serial console doesn't work even though I specify console=/dev/ttyS0 on
> the kernel command line. Once a getty is started, the serial port is
> active and working fine.

    This is not at all related to the discussed issue, so I've changed the 
subject. The console works like charm (seemingly for everybody, which kernel 
version are you using?

> Nico

WBR, Sergei
