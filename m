Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2003 15:43:35 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:55190
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225260AbTDDOnd>; Fri, 4 Apr 2003 15:43:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 75BE72BC30; Fri,  4 Apr 2003 16:43:28 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 19790-01;
 Fri,  4 Apr 2003 16:43:27 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id BFC562BC2D; Fri,  4 Apr 2003 16:43:27 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 78F6B1735C; Fri,  4 Apr 2003 16:40:55 +0200 (CEST)
Date: Fri, 4 Apr 2003 16:40:55 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: "Erik J. Green" <erik@greendragon.org>
Cc: linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: Unknown ARCS message/hang
Message-ID: <20030404144055.GH11906@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	"Erik J. Green" <erik@greendragon.org>, linux-mips@linux-mips.org,
	"Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
References: <20030404131935.GF11906@bogon.ms20.nix> <Pine.GSO.3.96.1030404161724.7307D-100000@delta.ds2.pg.gda.pl> <20030404143534.GG11906@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030404143534.GG11906@bogon.ms20.nix>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Fri, Apr 04, 2003 at 04:35:34PM +0200, Guido Guenther wrote:
> So either the PROM or (more likely) the start address in the kernel is
> bogus. What does
Forget that. Looking at the disassembly in the first mail it's clearly
the code that's wrong.
Regards,
 -- Guido
