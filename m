Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Jan 2008 13:06:36 +0000 (GMT)
Received: from mail.gmx.net ([213.165.64.20]:50822 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20031319AbYAHNG2 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 8 Jan 2008 13:06:28 +0000
Received: (qmail invoked by alias); 08 Jan 2008 13:06:22 -0000
Received: from vpn137.rz.tu-ilmenau.de (EHLO [192.168.1.100]) [141.24.172.137]
  by mail.gmx.net (mp010) with SMTP; 08 Jan 2008 14:06:22 +0100
X-Authenticated: #44099387
X-Provags-ID: V01U2FsdGVkX18x0KIQBWAxCI8SqiDNBoFUDFYrDn2HHYzD9B1MJU
	kIimWHf8n4IrLW
Message-ID: <4783754D.8010007@gmx.net>
Date:	Tue, 08 Jan 2008 14:06:21 +0100
From:	Andi <opencode@gmx.net>
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: memory dump on mips
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <opencode@gmx.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opencode@gmx.net
Precedence: bulk
X-list: linux-mips

Hi list,

we are working on an embedded Linux device with a Sigma SMP8634 (MIPS
4KEc 300MHz CPU) mounted on it. Unfortunately we don't have access to
the kernel running on the system.

We figured out, that the bootloader loads the kernel image to 0x90020000
(physical address). So it should be possible to read the image from that
address later on in Linux. We are not sure if our approach does not work
because of the memory protection that the SMP8634 offers, or if we do
something wrong.

This approach for a kernel module works on ARM9 (with MMU):
<code>
memory = ioremap_nocache(0x90020000, 20);
char byte = readb(memory);
</code>

Well, on mips this just throws 0x00.
Is this supposed to work on mips as well? Or do I have to deal with
"remap_pfn_range" or even VMA and "vm_ops->nopage"?


Thank you very much in advance

Regards,

andi
