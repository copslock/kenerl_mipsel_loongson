Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Mar 2005 12:12:26 +0000 (GMT)
Received: from moutng.kundenserver.de ([IPv6:::ffff:212.227.126.191]:13040
	"EHLO moutng.kundenserver.de") by linux-mips.org with ESMTP
	id <S8224941AbVCUMML>; Mon, 21 Mar 2005 12:12:11 +0000
Received: from [212.227.126.206] (helo=mrelayng.kundenserver.de)
	by moutng.kundenserver.de with esmtp (Exim 3.35 #1)
	id 1DDLlR-0002o8-00
	for linux-mips@linux-mips.org; Mon, 21 Mar 2005 13:12:09 +0100
Received: from [217.91.102.65] (helo=create.4g)
	by mrelayng.kundenserver.de with asmtp (TLSv1:RC4-MD5:128)
	(Exim 3.35 #1)
	id 1DDLlR-0000YN-00
	for linux-mips@linux-mips.org; Mon, 21 Mar 2005 13:12:09 +0100
From:	Michael Stickel <michael.stickel@4g-systems.biz>
To:	linux-mips@linux-mips.org
Subject: Re: Bitrotting serial drivers
Date:	Mon, 21 Mar 2005 13:12:08 +0100
User-Agent: KMail/1.7
References: <20050319172101.C23907@flint.arm.linux.org.uk> <423E7B9D.3040908@cubic.org> <423E91B3.4000302@embeddedalley.com>
In-Reply-To: <423E91B3.4000302@embeddedalley.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200503211312.08970.michael.stickel@4g-systems.biz>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:f72049c8971f462876d14eb8b3ccbbf1
Return-Path: <michael.stickel@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7483
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: michael.stickel@4g-systems.biz
Precedence: bulk
X-list: linux-mips

On Monday 21 March 2005 10:19, Pete Popov wrote:
> There were a bunch of differences including how you program the baud rate,

You mentioned the baudrate. There is one thing that had happend to me.
On the au1x00 the baud_base  is 0 by default. In the serial driver there is a 
division by baud_base, that ends up in a an exception. How could we handle 
that. For the moment I set it to a default before it is used:

if (baud_base == 0L)
  baud_base = 115200;

Which is also a hack. How can we get the correct baud_base for a pcmcia based 
serial-port.

> the addresses of the registers, and if I remember correctly,
> additional/different registers. To cleanly get the au1x support into the
> 8250 driver, some additional abstraction was necessary and I just never had
> the time to do it.

We should have a resource for the register access and the serial driver should 
not care about what it is (memory,io,au1x00,multiport,...). It should just 
use the resource to access the chip. The resource can be a "virtual resource" 
like the multiport cards that have an index register.

The serial port needs a second resource that is the interrupt.

Michael
