Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Jun 2009 14:17:03 +0200 (CEST)
Received: from eagle.jhcloos.com ([207.210.242.212]:4283 "EHLO
	eagle.jhcloos.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1492318AbZFMMQ5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 13 Jun 2009 14:16:57 +0200
Received: by eagle.jhcloos.com (Postfix, from userid 10)
	id 8F33A401A2; Sat, 13 Jun 2009 12:16:16 +0000 (UTC)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed; d=jhcloos.com;
	s=eagle; t=1244895400;
	bh=NLT4aXezABQjRdsXnE4xz2bLu48geACnFL8WfrLXVxs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type;
	b=JWF42XA4kdsatabc7haOY8lNTAY/LO/NrraYKGdu4BPYu1DuBRjY4g+OC2iTEwxaR
	 2Ogrln5Zv7OjX3NPqIg+srQhhpr/+LBiaEYv+obbdtj/mNk8nZYyUL/I9b4+Eyc//O
	 5tcxmaWPC4yHtJqai7ppHzTuqsdIbrUWrqIxdCto=
Received: by lugabout.jhcloos.org (Postfix, from userid 500)
	id 41C7764A9E; Sat, 13 Jun 2009 12:16:29 +0000 (UTC)
From:	James Cloos <cloos@jhcloos.com>
To:	linux-kernel@vger.kernel.org
Cc:	"Linux-MIPS" <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Takashi Iwai <tiwai@suse.de>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/8] add lib/gcd.c
In-Reply-To: <200906041615.10467.florian@openwrt.org> (Florian Fainelli's
	message of "Thu, 4 Jun 2009 16:15:07 +0200")
References: <200906041615.10467.florian@openwrt.org>
User-Agent: Gnus/5.110011 (No Gnus v0.11) Emacs/23.0.92 (gnu/linux)
Face:	iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAABHNCSVQICAgIfAhkiAAAAI1J
 REFUOE+lU9ESgCAIg64P1y+ngUdxhl5H8wFbbM0OmUiEhKkCYaZThXCo6KE5sCbA1DDX3genvO4d
 eBQgEMaM5qy6uWk4SfBYfdu9jvBN9nSVDOKRtwb+I3epboOsOX5pZbJNsBJFvmQQ05YMfieIBnYX
 FK2N6dOawd97r/e8RjkTLzmMsiVgrAoEugtviCM3v2WzjgAAAABJRU5ErkJggg==
Copyright: Copyright 2009 James Cloos
OpenPGP: ED7DAEA6; url=http://jhcloos.com/public_key/0xED7DAEA6.asc
OpenPGP-Fingerprint: E9E9 F828 61A4 6EA9 0F2B  63E7 997A 9F17 ED7D AEA6
Date:	Sat, 13 Jun 2009 08:16:04 -0400
Message-ID: <m38wjwz5ur.fsf@lugabout.jhcloos.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <cloos@jhcloos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23391
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cloos@jhcloos.com
Precedence: bulk
X-list: linux-mips

>>>>> "Florian" == Florian Fainelli <florian@openwrt.org> writes:

Florian> This patch adds lib/gcd.c which contains a greatest
Florian> common divider implementation taken from
Florian> sound/core/pcm_timer.c

Would the binary gcd algorithm not be a better fit for the kernel?

It avoids division, using only shifts and subtraction:

unsigned long gcd (unsigned long a, unsigned long b) {
	unsigned int shift;
	unsigned long d;
    
	if (a == 0 || b == 0)
		return a | b;
    
	for (shift = 0; ((a | b) & 1) == 0; ++shift) {
		a >>= 1;
		b >>= 1;
	}
    
	while ((a & 1) == 0)
		a >>= 1;
    
	do {
		while ((b & 1) == 0)
			b >>= 1;
	
		if (a < b) {
			b -= a;
		} else {
			d = a - b;
			a = b; b = d;
		}
		b >>= 1;
	} while (b != 0);
    
	return a << shift;
}

-JimC
-- 
James Cloos <cloos@jhcloos.com>         OpenPGP: 1024D/ED7DAEA6
