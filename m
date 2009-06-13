Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jun 2009 17:51:13 +0200 (CEST)
Received: from eagle.jhcloos.com ([207.210.242.212]:4823 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492365AbZFMPvH (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Jun 2009 17:51:07 +0200
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id A31F740086; Sat, 13 Jun 2009 15:50:27 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1244908251;
	bh=SAYlnAqUZVE1ixT0RiZ9eWYNhEDGrKhlSzqxA3mPBhA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=bnHCEuLxWOAh601C57WkuzAky5hoFxpDwGd3ipJHRt7M50J+QkGKKfhpD++8PuS3P
	 co1pvWgGrLD4DDdeWWJnLMYzhUqsSgSYprsRXy00gV9zzLe72U0rDQoWNaEhuJjJp6
	 8EGiZX78Vf1rn/kaiOrL6Ik6vRCaMxDwSPdk6KbY=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 6E1A46539E; Sat, 13 Jun 2009 15:50:40 +0000 (UTC)
From:	James Cloos <cloos@jhcloos.com>
To:	Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc:	linux-kernel@vger.kernel.org,
	"Linux-MIPS" <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/8] add lib/gcd.c
In-Reply-To: <20090613162802.6c212505@lxorguk.ukuu.org.uk> (Alan Cox's message
	of "Sat, 13 Jun 2009 16:28:02 +0100")
References: <200906041615.10467.florian@openwrt.org>
	<m38wjwz5ur.fsf@lugabout.jhcloos.org>
	<20090613162802.6c212505@lxorguk.ukuu.org.uk>
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face:	iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
Date:	Sat, 13 Jun 2009 11:50:15 -0400
Message-ID: <m3ocssw2sw.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <cloos@jhcloos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23395
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cloos@jhcloos.com
Precedence: bulk
X-list: linux-mips

>>>>> "Alan" == Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

>> Would the binary gcd algorithm not be a better fit for the kernel?

Alan> Could well be the shift based one is better for some processors only.

Very likely, I suspect.

And the version of the euclid algo in that patch is better than most
references that I've seen.  (q=a/b;r=a%b; is common, probably because
the texts use the same algo for computing the continued fraction.)

In any case, I do not have the hardware to do any statistically
significant testing; the closest I could do would be a speed test
on hera, which I expect would be discouraged.

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
