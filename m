Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 10:38:27 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:38324
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225235AbTEHJiZ>; Thu, 8 May 2003 10:38:25 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 0CA232BC31; Thu,  8 May 2003 11:38:23 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 09245-01;
 Thu,  8 May 2003 11:38:21 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id DA2C72BC38; Thu,  8 May 2003 11:38:15 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id BBB9E1735D; Thu,  8 May 2003 10:50:04 +0200 (CEST)
Date: Thu, 8 May 2003 10:50:04 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: Ladislav Michl <ladis@linux-mips.org>
Cc: Keith M Wesolowski <wesolows@foobazco.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH] Highmem detection for Indigo2
Message-ID: <20030508085004.GI13672@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Ladislav Michl <ladis@linux-mips.org>,
	Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@linux-mips.org
References: <20030428071639.GA7578@simek> <20030508061117.GA30191@foobazco.org> <20030508073200.GA837@kopretinka>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508073200.GA837@kopretinka>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2293
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Thu, May 08, 2003 at 09:32:00AM +0200, Ladislav Michl wrote:
> Guido told me he is working device detection based on ARCS calls. I'm
> not sure is this way will be acceptale for him...
Having what the ARC spec calls "System Configuration Data" in a tree
like structure would be a nice thing, I think. I have some code for this
around here but wanted to check sysfs in 2.5 to see if it eases up the
representation - we could finally properly detect the primary graphics
board with that.
 -- Guido
