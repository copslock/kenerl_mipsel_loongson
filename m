Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Jun 2005 00:11:40 +0100 (BST)
Received: from straum.hexapodia.org ([IPv6:::ffff:64.81.70.185]:55965 "EHLO
	straum.hexapodia.org") by linux-mips.org with ESMTP
	id <S8225526AbVFXXLX>; Sat, 25 Jun 2005 00:11:23 +0100
Received: by straum.hexapodia.org (Postfix, from userid 22448)
	id 869D8283; Fri, 24 Jun 2005 16:10:23 -0700 (PDT)
Date:	Fri, 24 Jun 2005 16:10:23 -0700
From:	Andy Isaacson <adi@hexapodia.org>
To:	rolf liu <rolfliu@gmail.com>
Cc:	Prashant Viswanathan <vprashant@echelon.com>,
	linux-mips@linux-mips.org
Subject: Re: glibc based toolchain for mips
Message-ID: <20050624231023.GA5428@hexapodia.org>
References: <5375D9FB1CC3994D9DCBC47C344EEB5905FA4350@miles.echelon.echcorp.com> <20050624223915.GB4295@hexapodia.org> <2db32b7205062415471d0fe4c0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2db32b7205062415471d0fe4c0@mail.gmail.com>
User-Agent: Mutt/1.4.2i
X-PGP-Fingerprint: 48 01 21 E2 D4 E4 68 D1  B8 DF 39 B2 AF A3 16 B9
X-PGP-Key-URL: http://web.hexapodia.org/~adi/pgp.txt
X-Domestic-Surveillance: money launder bomb tax evasion
Return-Path: <adi@hexapodia.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8185
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: adi@hexapodia.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 24, 2005 at 03:47:30PM -0700, rolf liu wrote:
> That one Debian provides is for big endian. Is there one tool chain
> for mips little endian and also gcc 3.*.* ?

Debian has a BE "mips" port and a LE "mipsel" port.  They should both
work (though I've only used the BE version myself) and are routinely
tested...  in fact AFAIK the package build machines are self-hosting.

-andy
