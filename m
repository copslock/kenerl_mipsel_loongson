Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 May 2003 11:41:06 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:38789
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8224861AbTENKlE>; Wed, 14 May 2003 11:41:04 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 046942BC34
	for <linux-mips@linux-mips.org>; Wed, 14 May 2003 12:41:03 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 21271-07
 for <linux-mips@linux-mips.org>; Wed, 14 May 2003 12:41:02 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 236B12BC33
	for <linux-mips@linux-mips.org>; Wed, 14 May 2003 12:41:02 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id CDAFB1737F; Wed, 14 May 2003 12:40:40 +0200 (CEST)
Date: Wed, 14 May 2003 12:40:40 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: Branch relocation fixing at Kernel-compiling with Debian-toolchain
Message-ID: <20030514104040.GZ3889@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <20030514123144.52da1d81.achim.hensel@ruhr-uni-bochum.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030514123144.52da1d81.achim.hensel@ruhr-uni-bochum.de>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2369
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Wed, May 14, 2003 at 12:31:44PM +0200, Achim Hensel wrote:
> [I try to build Linux for a R4k Indigo1. I'm using as and ld of the
> debian-toolchain with mips-linux-as/mips-linux-ld 2.13.90.0.18
> 20030121. At the moment, the kernel just compiles, but is not bootable
> due to further adaption.]
The simplest fix probably is to use 2.14.90.0.1. I have debs for mips
here if this is of any use.
 -- Guido
