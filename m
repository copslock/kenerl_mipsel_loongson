Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Feb 2003 09:25:58 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:1239
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225223AbTBDJZ5>; Tue, 4 Feb 2003 09:25:57 +0000
Received: from bogon.sigxcpu.org (unknown [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 9BD9C2BC2D
	for <linux-mips@linux-mips.org>; Tue,  4 Feb 2003 10:25:54 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 781844AF4C; Tue,  4 Feb 2003 10:24:17 +0100 (CET)
Date: Tue, 4 Feb 2003 10:24:17 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [patch] cmdline.c rewrite
Message-ID: <20030204092417.GR16674@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Linux-MIPS <linux-mips@linux-mips.org>
References: <20030204061323.GA27302@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030204061323.GA27302@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1304
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 04, 2003 at 05:13:23PM +1100, Andrew Clausen wrote:
> Some kernel parameters are auto-generated.   eg: root= (always has been
> broken).  Anyway, the old version of cmdline.c added these auto-generated
Can you explain in what way root= was broken?
 -- Guido
