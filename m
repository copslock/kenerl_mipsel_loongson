Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Dec 2002 10:00:48 +0000 (GMT)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:34207 "EHLO
	mx.mips.com") by linux-mips.org with ESMTP id <S8225942AbSLaKAs>;
	Tue, 31 Dec 2002 10:00:48 +0000
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.5/8.12.5) with ESMTP id gBVA0emo000397;
	Tue, 31 Dec 2002 02:00:40 -0800 (PST)
Received: from grendel (grendel [192.168.236.16])
	by newman.mips.com (8.9.3/8.9.0) with SMTP id BAA24587;
	Tue, 31 Dec 2002 01:57:16 -0800 (PST)
Message-ID: <006401c2b0b3$af277b30$10eca8c0@grendel>
From: "Kevin D. Kissell" <kevink@mips.com>
To: "amit lubovsky" <amit_lubovsky@yahoo.com>,
	<linux-mips@linux-mips.org>
References: <20021231074733.52293.qmail@web14804.mail.yahoo.com>
Subject: Re: need help - malta board mips5kc
Date: Tue, 31 Dec 2002 11:01:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4807.1700
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

I don't know the Lauterback tool at all, so I can
only suggest two possible things to worry about.
One would be that the debugger is making use of
memory in a way that conflicts with the download
of the Linux image.  The other would be that the
Malta drivers very likely still assume that some
set up has been done by the on-board ROM
monitor (YAMON), and that perhaps your
setup isn't allowing that to happen.  But if you
really want some help diagnosing stuff, you need
to provide more information (like *which* Linux
image, whether YAMON is still booting up on
the board before you start your session, some
description of the failure mode more detailed than
"no success", etc, etc).

----- Original Message ----- 
From: "amit lubovsky" <amit_lubovsky@yahoo.com>
To: <linux-mips@linux-mips.org>
Sent: Tuesday, December 31, 2002 8:47 AM
Subject: need help - malta board mips5kc


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
