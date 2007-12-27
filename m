Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2007 05:45:17 +0000 (GMT)
Received: from mail.zeugmasystems.com ([192.139.122.66]:12135 "EHLO
	zeugmasystems.com") by ftp.linux-mips.org with ESMTP
	id S20023067AbXL0FpJ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Dec 2007 05:45:09 +0000
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Subject: RE: question about oprofile support 
Date:	Wed, 26 Dec 2007 21:44:41 -0800
Message-ID: <DDFD17CC94A9BD49A82147DDF7D545C55DDD38@exchange.ZeugmaSystems.local>
In-Reply-To: <DDFD17CC94A9BD49A82147DDF7D545C55DDD32@exchange.ZeugmaSystems.local>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: question about oprofile support 
Thread-Index: AchIMDwwQspU45gHS3mmRD2rNDCO/QAGrc6A
References: <DDFD17CC94A9BD49A82147DDF7D545C55DDD32@exchange.ZeugmaSystems.local>
From:	"Anirban Sinha" <ASinha@zeugmasystems.com>
To:	<linux-mips@linux-mips.org>
Return-Path: <ASinha@zeugmasystems.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ASinha@zeugmasystems.com
Precedence: bulk
X-list: linux-mips

If I am not too wrong, I think this is what the picture is like as far as the mips support for oprfile goes:

Oprofile 0.9.2 release version supports mips architecture partially. Their release notes says:

"Support for MIPS 5K, 20K, 25K, and 34K added."

However, support for R10000, R12000, R12000, RM7000, RM9000, SB1 / SB1A, VR5432, VR5500 processors are only available through the CVS checkout:

"The R10000, R12000, R12000, RM7000, RM9000, SB1 / SB1A, VR5432, VR5500 processors are supported by the CVS version of the userspace tools; support for further is in the queue."


If I am wrong in understanding this, please correct me.

Cheers,

Ani


From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Anirban Sinha
Sent: Wednesday, December 26, 2007 6:29 PM
To: linux-mips@linux-mips.org
Subject: question about oprofile support 

Hi:

Linux-mips.org states: (http://www.linux-mips.org/wiki/Oprofile) 

"Oprofile support is available at the time of this writing only in the Sourceforge Oprofile CVS repository; released versions are either lacking support for MIPS or are unusable due to bugs"

I am wondering if this is still true. If we want to have oprofile support on mips hardware, do we have to checkout the HEAD revision from oprofile cvs repository or is it already available from the standard 0.9.3 release? 

Thanks in advance to anyone who can throw any lights on this.

Cheers,

Ani
 
