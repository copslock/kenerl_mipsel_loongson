Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2002 20:09:38 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:46788 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225953AbSLaUJh>;
	Tue, 31 Dec 2002 20:09:37 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.10.2/8.10.2) with ESMTP id gBVKBbS19806;
	Tue, 31 Dec 2002 12:11:37 -0800 (PST)
Received: from NOMAD (vpn019.ghs.com [10.239.157.19])
	by blaze.ghs.com (8.10.2+Sun/8.10.2+Sun) with ESMTP id gBVKBZF08524;
	Tue, 31 Dec 2002 12:11:35 -0800 (PST)
From: "Mike Connors" <mike.connors@ghs.com>
To: "'amit lubovsky'" <amit_lubovsky@yahoo.com>,
	<linux-mips@linux-mips.org>
Subject: RE: need help - malta board mips5kc
Date: Tue, 31 Dec 2002 12:08:40 -0800
Organization: Green Hills Software
Message-ID: <001301c2b108$699bad20$6401a8c0@NOMAD>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
In-Reply-To: <20021231074733.52293.qmail@web14804.mail.yahoo.com>
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Return-Path: <mike.connors@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mike.connors@ghs.com
Precedence: bulk
X-list: linux-mips

I've been doing some relative work with the Green 
Hills probe and a Malta 4kc.  The configuration of 
the kernel I am using requires parameters to be 
passed in to the kernel to tell it were to find 
the root device (ie root=/dev/hda1).  To make things 
simple, I would load using YAMON, connect with the 
debugger, then set a breakpoint in a section of 
the kernel I was interested in, then run using the 
YAMON command go . root=/dev/hda1.  I plan to eventually 
figure out where it is being written to memory and just 
write it myself after downloading the image through 
the probe. 

There are many other issues you might run into when 
using Linux with a probe.  We have updated the GHS 
probe firmware to behave nicely with Linux.  This 
helps when debugging loadable device drivers, etc. 
I will forward your email to our Linux integration 
engineers to see what other issues you might run into. 
They have more experience with the Malta 5kc. 

Regards, 
Mike 
--- 
Mike Connors			Green Hills Software, San Clemente 
Field Applications Engineer	131 Avenida Victoria 
mailto:mikec@ghs.com		San Clemente, CA  92672 
phone: 1-949-369-3950		
cell:  1-949-412-3951		fax: 1-949-369-3959 

Latest GHS news: 
Green Hills Software's INTEGRITYR RTOS Flies In F-16 Fighter Jet
http://www.ghs.com/news/221220f.html 

Green Hills Software Inc.	phone: 	1-805-965-6044 
30 West Sola Street		toll-free: 1-800-765-GREEN (4733) 
Santa Barbara, CA 93101		Tech-Support: 1-877-GHS-TECH (447-8324) 
http://www.ghs.com		Email Support: mailto:support@ghs.com 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of amit lubovsky
> Sent: Monday, December 30, 2002 11:48 PM
> To: linux-mips@linux-mips.org
> Subject: need help - malta board mips5kc
> 
> 
> Hi,
> I try to load a Linux image with HW debuger
> (Lauterbach) to a malta board with mips5kc with no
> success.
> With vxWorks image it loads and run with no problem,
> Any idea what is wrong?, the load address? the 'go'
> address?
> Thanks,
> Amit.
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> 
> 
