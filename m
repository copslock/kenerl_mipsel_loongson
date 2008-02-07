Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 07 Feb 2008 20:33:38 +0000 (GMT)
Received: from host.infinivid.com ([64.119.179.76]:41187 "EHLO
	host.infinivid.com") by ftp.linux-mips.org with ESMTP
	id S20038975AbYBGUda (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 7 Feb 2008 20:33:30 +0000
Received: (qmail 32425 invoked from network); 7 Feb 2008 20:33:28 -0000
Received: from unknown (HELO ?10.41.13.129?) (38.101.235.133)
  by host.infinivid.com with (RC4-MD5 encrypted) SMTP; 7 Feb 2008 13:33:28 -0700
Subject: Re: iomemory causing a data bus error
From:	Jon Dufresne <jon.dufresne@infinitevideocorporation.com>
To:	linux-mips@linux-mips.org
In-Reply-To: <1202397602.3298.25.camel@localhost>
References: <1202397602.3298.25.camel@localhost>
Content-Type: text/plain
Date:	Thu, 07 Feb 2008 15:32:56 -0500
Message-Id: <1202416377.3298.44.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.3 (2.8.3-2.fc6) 
Content-Transfer-Encoding: 7bit
Return-Path: <jon.dufresne@infinitevideocorporation.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18197
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jon.dufresne@infinitevideocorporation.com
Precedence: bulk
X-list: linux-mips

I took some time and wrote a VERY simplified driver. The driver is now
doing only the required steps to test this error. I figured this would
localize the problem as much as possible. When I run this new driver. I
now see the following error:

ohci_hcd 0000:00:09.0: OHCI Unrecoverable Error, disabled
ohci_hcd 0000:00:09.0: HC died; cleaning up
irq 55: nobody cared (try booting with the "irqpoll" option)
Call
Trace:[<8006926c>][<8006926c>][<800ab1cc>][<800ab434>][<800aa27c>][<800aa27c>][<800aa3b8>][<8007faac>][<80085e9c>][<80085e70>][<8006386c>][<80061310>][<8009e3c4>][<8019d278>][<80062040>][<80062040>][<800]
handlers:
[<801dd630>]
[<801ecce8>]
[<801ecce8>]
[<801ecce8>]
[<801ae6c8>]
Disabling IRQ #55

It looks to me like there is a problem with the USB driver. An
interesting note is that my device's interrupt is also irq 55. I have
tried this simplified driver both requesting the interrupt, in which
case it is never triggered, and not requesting the interrupt. Both cases
end the same way. After I get that message the system is still running,
but extremely slowly.

Any ideas?

Thanks,
Jon
