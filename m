Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 11:52:55 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:4555 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224861AbTENKwx>; Wed, 14 May 2003 11:52:53 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA26330;
	Wed, 14 May 2003 12:53:33 +0200 (MET DST)
Date: Wed, 14 May 2003 12:53:32 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Guido Guenther <agx@sigxcpu.org>
cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
In-Reply-To: <20030513222215.GA440@bogon.ms20.nix>
Message-ID: <Pine.GSO.3.96.1030514124924.26213A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Wed, 14 May 2003, Guido Guenther wrote:

> Looking at gcc-3.3:
> 
> #define ABI_32  0
> #define ABI_N32 1
> #define ABI_64  2
> #define ABI_EABI 3
> #define ABI_O64  4
> 
> The naming is very "unfortunate", though. We have (n32,64) and (32,o64).
> Wouldn't it help to at least allow for n64 and o32 commandline options?
> -mabi=32 and -mabi=64 will have to be kept for Irix compatibility
> though, I think.

 Why unfortunate?  You use "32" and "64" for normal stuff, and the rest
for special cases ("n32" isn't really 32-bit and "o64" isn't really 64-bit
-- both lie in the middle).  Additional aliases of the "n64" and "o32"
form would make more confusion, IMHO. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
