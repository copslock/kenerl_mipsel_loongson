Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 17 Nov 2004 17:01:47 +0000 (GMT)
Received: from 209-232-97-206.ded.pacbell.net ([IPv6:::ffff:209.232.97.206]:5043
	"EHLO dns0.mips.com") by linux-mips.org with ESMTP
	id <S8224901AbUKQRBn>; Wed, 17 Nov 2004 17:01:43 +0000
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id iAHH1YjQ002030;
	Wed, 17 Nov 2004 09:01:35 -0800 (PST)
Received: from [192.168.236.16] (grendel [192.168.236.16])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id iAHH1Ytw019987;
	Wed, 17 Nov 2004 09:01:35 -0800 (PST)
Message-ID: <419B855B.1050304@mips.com>
Date: Wed, 17 Nov 2004 18:07:39 +0100
From: "Kevin D. Kissell" <kevink@mips.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Linux-MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Dubious MIPS kernel SMP Structures
References: <006d01c4ccba$36a43110$10eca8c0@grendel> <20041117164629.GA10920@linux-mips.org>
In-Reply-To: <20041117164629.GA10920@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.39
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

[snip of lots of cool historical explanations]

 > As you found the IP27 code doesn't properly setup these mappings anymore;
 > partly because it's SMP initialization code is twisted to the point
 > where nobody understands it anymore.  Partly also because the systems
 > we used as SGI were too large to leave CPU numbers unused :)
 >
 > Honestly no idea why the Sibyte code is using that mapping stuff.  The
 > Sibyte firmware is always launching the kernel on CPU 0 anyway so we have
 > the case of either only CPU 0 or both CPU 0 and CPU 1 which means the
 > mapping would always be a 1:1 mapping.
 >
 > For most simple SMP or ccNUMA configurations assuming a 1:1 mapping is
 > reasonable.  For some uniprocessor configurations where a uniprocessor
 > kernel is running on a single processor other than processor number 0 on
 > a multiprocessor platform this also may be useful.

But my question is really one of why it is that the platform-independent
MIPS kernel code needs/needed to know anything about physical CPU numbers?
Naively, I would have thought that any such mapping would be burried
in the platform code, and that the architectural kernel code would
simply invoke (possibly null) platform-level functions that do whatever
mapping of logical 0...N CPU numbers to bizarre mesh node numbers might
be necessary. As it stands, people who have no need to do mapping (SiByte,
PMC-Sierra, and stuff we're doing at MIPS around MIPS MT) are mindlessly
replicating code to set up 1:1 mappings that will never (in the PMC-Sierra
and MIPS cases) be referenced.

		Regards,

		Kevin K.
