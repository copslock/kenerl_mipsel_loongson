Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Jan 2003 17:16:36 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:46316 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8224939AbTANRQg>;
	Tue, 14 Jan 2003 17:16:36 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.10.2/8.10.2) with ESMTP id h0EHIb908894
	for <linux-mips@linux-mips.org>; Tue, 14 Jan 2003 09:18:37 -0800 (PST)
Received: from NOMAD (vpn016.ghs.com [10.239.157.16])
	by blaze.ghs.com (8.10.2+Sun/8.10.2+Sun) with ESMTP id h0EHIaX14841
	for <linux-mips@linux-mips.org>; Tue, 14 Jan 2003 09:18:36 -0800 (PST)
From: "Mike Connors" <mike.connors@ghs.com>
To: "'mips-linux'" <linux-mips@linux-mips.org>
Subject: RE: malta-5kc
Date: Tue, 14 Jan 2003 09:15:30 -0800
Organization: Green Hills Software
Message-ID: <001e01c2bbf0$8a5f9420$6401a8c0@NOMAD>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
In-reply-to: <20030114132824.75177.qmail@web14805.mail.yahoo.com>
Return-Path: <mike.connors@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1151
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mike.connors@ghs.com
Precedence: bulk
X-list: linux-mips

The easiest thing to do is have YAMON load the image, 
connect with your debugger and set a breakpoint at 
some starting point of the linux kernel, then enter 
the go command with the program arguments on the 
YAMON command line.  

The rest is debugger specific.  If you are using Green 
Hills Software's MULTI debugger, I can help you with 
the details.  If you are using MULTI and you give me a 
little time to figure it out, I could even give you a 
way to do it without YAMON. 

-- Mike 
--- 
Mike Connors			Green Hills Software, San Clemente 
Field Applications Engineer	131 Avenida Victoria 
mailto:mikec@ghs.com		San Clemente, CA  92672 
phone: 1-949-369-3950		
cell:  1-949-412-3951		fax: 1-949-369-3959 

Green Hills in the News: 

INTEGRITYR RTOS Flies In F-16 Fighter Jet 
	http://www.ghs.com/news/221213b.html 
Boeing Selects INTEGRITYR RTOS for B-1B Avionics Upgrade 
	http://www.ghs.com/news/221213b.html 
INTEGRITYR RTOS selected by Boeing's C-17 Globemaster III 
	http://www.ghs.com/news/221104b.html 

Green Hills Software Inc.	phone: 	1-805-965-6044 
30 West Sola Street		toll-free: 1-800-765-GREEN (4733) 
Santa Barbara, CA 93101		Tech-Support: 1-877-GHS-TECH (447-8324) 
http://www.ghs.com		Email Support: mailto:support@ghs.com 

> -----Original Message-----
> From: linux-mips-bounce@linux-mips.org 
> [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of amit lubovsky
> Sent: Tuesday, January 14, 2003 5:28 AM
> To: mips-linux
> Subject: malta-5kc
> 
> 
> Hi,
> I try to load a linux image to a malta-5kc board with
> a hw debugger.
> 
> Before I load the image I load YAMON in order to
> initialize the board.
> 
> This doesn't work and I have understood that I have to
> set up some of the cpu registers to certain values
> (like for command line parameters, etc.)
> 
> Could anyone help me with that?, which registers and
> to what values?
> 
> Thanks,
> Amit.
> 
> 
> __________________________________________________
> Do you Yahoo!?
> Yahoo! Mail Plus - Powerful. Affordable. Sign up now.
> http://mailplus.yahoo.com
> 
> 
