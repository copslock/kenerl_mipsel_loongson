Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jan 2004 17:52:28 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:24532 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225496AbUA1Rw2>;
	Wed, 28 Jan 2004 17:52:28 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.10) with ESMTP id i0SHqP4u013740;
	Wed, 28 Jan 2004 09:52:25 -0800 (PST)
Received: from zcar.ghs.com (zcar.ghs.com [192.67.158.60])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id i0SHqMBe028064;
	Wed, 28 Jan 2004 09:52:22 -0800 (PST)
Date: Wed, 28 Jan 2004 09:52:22 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: Ralf Baechle <ralf@linux-mips.org>
cc: linux-mips@linux-mips.org
Subject: Re: linux_2_4 and Malta
In-Reply-To: <20040128151429.GA17242@linux-mips.org>
Message-ID: <Pine.LNX.4.44.0401280929210.31973-100000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ndf@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndf@ghs.com
Precedence: bulk
X-list: linux-mips

> > The prom_print stuff outputs to the serial port fine, but printk's
> > never get out. Looking at the kernel under a debugger it also seems
> > that the kernel is crashing randomly and ending up in an infinite loop
> > branching to self.
> 
> What processor are you using on the Malta?
	It's a 4kc. I've now got 2 of them so I can debug them side by 
side, one running 2.6 and one running 2.4. Any suggestions on where I 
should look for problems? The codebases seem similar in some areas, but 
their structure is quite different.

	nathan

-- 
Nathan Field (ndf@ghs.com)			          All gone.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)
