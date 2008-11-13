Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2008 17:12:29 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:49859 "EHLO
	localhost.localdomain") by ftp.linux-mips.org with ESMTP
	id S23659082AbYKMRM0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 13 Nov 2008 17:12:26 +0000
Date:	Thu, 13 Nov 2008 17:12:26 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ken Hicks <hicks@nortel.com>
cc:	linux-mips@linux-mips.org
Subject: Re: MIPS Unaligned Access Question
In-Reply-To: <238C6E77EA42504DA038BAEE6D1C11ECADB661@zcarhxm0.corp.nortel.com>
Message-ID: <alpine.LFD.1.10.0811131703400.31013@ftp.linux-mips.org>
References: <238C6E77EA42504DA038BAEE6D1C11ECADB661@zcarhxm0.corp.nortel.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21278
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 13 Nov 2008, Ken Hicks wrote:

> I'm investigating why an Unaligned Access exception is generated on MIPS
> from an accesses which are not misaligned.
> 
> The issue is that a kernel access two different unmapped addresses
> results in different exceptions:
> Address                Exception
> 0x0001000000000000:    page fault
> 0x0010000000000000:    unaligned access
> 
> I'm using a Cavium CPU with a custom linux based on 2.6.14 but the code
> in question hasn't changed widly in more recent kernels.
> I have observed this several times, so I have manually recreated the
> behaviour by intentionally accessing known unmapped addresses.

 This is not an unaligned access, this is a generic address error 
resulting from accessing an address outside the defined segments.  Please 
see your CPU's datasheet for which data ranges are valid as the MIPS 
architecture leaves it up to the implementer.

 Our address error exception handler does not attempt to differentiate 
between the two cases, because it is not possible for all the CPUs out 
there to determine which addresses are valid and which are not 
automatically.  For all the legacy MIPS implementations the ranges would 
have to be hardcoded in the kernel.  For MIPS architecture processors it 
is actually possible to figure it out with some fiddling of the CP0 
registers.

 Improving the address error exception handler in this respect has been on 
my to-do list for a while now (for my own convenience I have had a local 
patch to check the ranges for the R4000/R4400 processors), but please 
don't hold your breath waiting for me to finish it as I do not expect it 
to happen anytime soon.  Feel free to make improvements in this area 
yourself.

 For further information please refer to your CPU's datasheet and the MIPS 
architecture manuals.

  Maciej
