Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 May 2003 23:25:57 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:54656
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225197AbTEMWZq>; Tue, 13 May 2003 23:25:46 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 0967B2BC35
	for <linux-mips@linux-mips.org>; Wed, 14 May 2003 00:25:46 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 17580-01
 for <linux-mips@linux-mips.org>; Wed, 14 May 2003 00:25:37 +0200 (CEST)
Received: from bogon.sigxcpu.org (kons-d9bb542e.pool.mediaWays.net [217.187.84.46])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id B8AAD2BC33
	for <linux-mips@linux-mips.org>; Wed, 14 May 2003 00:25:36 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id DE8891737F; Wed, 14 May 2003 00:22:15 +0200 (CEST)
Date: Wed, 14 May 2003 00:22:15 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030513222215.GA440@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de> <20030513113316.GU3889@bogon.ms20.nix> <20030513192735.GA16497@rembrandt.csv.ica.uni-stuttgart.de> <20030513201144.GY3889@bogon.ms20.nix> <20030513205021.GC16497@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030513205021.GC16497@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2366
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Tue, May 13, 2003 at 10:50:21PM +0200, Thiemo Seufer wrote:
> I just had a look at the gcc sources, the mips*-linux config doesn't
> support o64 at all.
It seems I was wrong (I got confused by the way the kernel calls gcc).
Looking at gcc-3.3:

#define ABI_32  0
#define ABI_N32 1
#define ABI_64  2
#define ABI_EABI 3
#define ABI_O64  4

The naming is very "unfortunate", though. We have (n32,64) and (32,o64).
Wouldn't it help to at least allow for n64 and o32 commandline options?
-mabi=32 and -mabi=64 will have to be kept for Irix compatibility
though, I think.
 -- Guido
