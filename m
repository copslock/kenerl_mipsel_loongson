Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jan 2004 18:35:10 +0000 (GMT)
Received: from eta.ghs.com ([IPv6:::ffff:63.102.70.66]:50938 "EHLO eta.ghs.com")
	by linux-mips.org with ESMTP id <S8225232AbUAMSfI>;
	Tue, 13 Jan 2004 18:35:08 +0000
Received: from blaze.ghs.com (blaze.ghs.com [192.67.158.233])
	by eta.ghs.com (8.12.10/8.12.10) with ESMTP id i0DIZ4kp002096;
	Tue, 13 Jan 2004 10:35:04 -0800 (PST)
Received: from zcar.ghs.com (zcar.ghs.com [192.67.158.60])
	by blaze.ghs.com (8.12.9/8.12.9) with ESMTP id i0DIZ39w007460;
	Tue, 13 Jan 2004 10:35:03 -0800 (PST)
Date: Tue, 13 Jan 2004 10:35:04 -0800 (PST)
From: Nathan Field <ndf@ghs.com>
To: Daniel Jacobowitz <dan@debian.org>
cc: linux-mips@linux-mips.org
Subject: Re: ptrace induced instruction cache bug?
In-Reply-To: <20040113150108.GA7144@nevyn.them.org>
Message-ID: <Pine.LNX.4.44.0401131029410.1969-100000@zcar.ghs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <ndf@ghs.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ndf@ghs.com
Precedence: bulk
X-list: linux-mips

> It sounds reasonable.  I've encountered this problem in the past also,
> but never with the Pro 2.1 / MIPS release which is what you're using.  
> I don't see anything obviously wrong with your test code, either.
	So... is there a fix for this?

> Yes, you will need a newer toolchain.  Honestly, I'm baffled as to why a
> Pro 2.1 toolchain was available from our web site at all, unless you got
> it via an old product subscription... it should have been Pro 3.0, which
> uses GCC 3.2 and a more recent binutils.  But I don't have any control
> over these things :)
	I downloaded it about 5 days ago from:
http://www.mvista.com/previewkit/index.html

Could I get a preview kit of your 3.0 release for a Malta 4Kc board?

	nathan

-- 
Nathan Field (ndf@ghs.com)			          All gone.

But the trouble with analogies is that analogies are like goldfish:
sometimes they have nothing to do with the topic at hand.
        -- Crispin (from a posting to the Bugtraq mailing list)
