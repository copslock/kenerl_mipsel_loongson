Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 21:00:53 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.71]:48038
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225198AbTBTVAw>; Thu, 20 Feb 2003 21:00:52 +0000
Received: from bogon.sigxcpu.org (kons-d9bb544b.pool.mediaWays.net [217.187.84.75])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 500B52BC2D
	for <linux-mips@linux-mips.org>; Thu, 20 Feb 2003 22:00:50 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id C4374176DB; Thu, 20 Feb 2003 21:59:11 +0100 (CET)
Date: Thu, 20 Feb 2003 21:59:11 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: Ramdisk image on flash.
Message-ID: <20030220205911.GB27240@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <200302201135.09154.krishnakumar@naturesoft.net> <1045765647.30379.262.camel@zeus.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1045765647.30379.262.camel@zeus.mvista.com>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1488
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Thu, Feb 20, 2003 at 10:27:27AM -0800, Pete Popov wrote:
> Yes, and other architectures have support for passing arguments to the
> kernel that tell it where the ramdisk is. I don't know that we've done
We're using a patch for the debian kernels that allows to pass the
initrd's loadaddress and size on the kernel's command line. If this is of
some use I can send a patch.
 -- Guido
