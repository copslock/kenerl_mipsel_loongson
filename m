Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Dec 2003 20:34:23 +0000 (GMT)
Received: from mail.bandspeed.com ([IPv6:::ffff:64.132.226.131]:34230 "EHLO
	mars.bandspeed.com") by linux-mips.org with ESMTP
	id <S8225551AbTLAUeU> convert rfc822-to-8bit; Mon, 1 Dec 2003 20:34:20 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: RE: backtrace issues on GDB 5.3
Date: Mon, 1 Dec 2003 14:34:13 -0600
Message-ID: <F2DE90354F0ED94EB7061060D9396547B98C58@mars.bandspeed.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: backtrace issues on GDB 5.3
Thread-Index: AcO1xSYxzC0J+fJuT9ek328zeMIppAChSr3w
From: "Vince Bridgers" <vbridgers@bandspeed.com>
To: "Daniel Jacobowitz" <dan@debian.org>
Cc: <linux-mips@linux-mips.org>
Return-Path: <vbridgers@bandspeed.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vbridgers@bandspeed.com
Precedence: bulk
X-list: linux-mips

Tried it. It does work "better", but not "much better".

Thanks for the tip


-----Original Message-----
From: Daniel Jacobowitz [mailto:dan@debian.org] 
Sent: Friday, November 28, 2003 9:35 AM
To: Vince Bridgers
Cc: linux-mips@linux-mips.org
Subject: Re: backtrace issues on GDB 5.3

On Thu, Nov 27, 2003 at 07:26:59AM -0600, Vince Bridgers wrote:
> I'm using GDB 5.3 for mipsel cross-compiled on an x86 box running
RedHat
> 7.3. When I try to use the backtrace capability from GDB most of the
> time I do not get a full stack context - I usually just get the
function
> I'm in at the time. I'm using GCC 3.2 to compile the kernel,
> cross-compiled the same way. I've tried making sure the
> omit-frame-pointer option and the "no instruction schedule" options
are
> on for when we do source level debugging with no joy.  
> 
> Does backtrace work for GCC and GDB cross compiled for mipsel? If so,
> can someone briefly outline the "known good" configuration (GCC/GDB
> versions, + relevant configuration options)?

Not excellently, but definitely better - try the most recent GDB
release.

I have a number of ugly local patches that I hope to clean up for 6.1,
if I have time.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
