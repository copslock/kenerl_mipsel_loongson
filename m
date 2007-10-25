Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Oct 2007 15:11:46 +0100 (BST)
Received: from pasmtpa.tele.dk ([80.160.77.114]:42631 "EHLO pasmtpA.tele.dk")
	by ftp.linux-mips.org with ESMTP id S20022622AbXJYOLh (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 25 Oct 2007 15:11:37 +0100
Received: from ravnborg.org (0x535d98d8.vgnxx8.adsl-dhcp.tele.dk [83.93.152.216])
	by pasmtpA.tele.dk (Postfix) with ESMTP id 453C3800640;
	Thu, 25 Oct 2007 16:11:29 +0200 (CEST)
Received: by ravnborg.org (Postfix, from userid 500)
	id A4CEA580D2; Thu, 25 Oct 2007 16:13:05 +0200 (CEST)
Date:	Thu, 25 Oct 2007 16:13:05 +0200
From:	Sam Ravnborg <sam@ravnborg.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: [IDE] Fix build bug
Message-ID: <20071025141305.GA11698@uranus.ravnborg.org>
References: <20071025135334.GA23272@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071025135334.GA23272@linux-mips.org>
User-Agent: Mutt/1.4.2.1i
Return-Path: <sam@ravnborg.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17213
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sam@ravnborg.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 25, 2007 at 02:53:34PM +0100, Ralf Baechle wrote:
>   CC      drivers/ide/pci/generic.o
> drivers/ide/pci/generic.c:52: error: __setup_str_ide_generic_all_on causes a
> +section type conflict
> 
> This sort of build error is becoming a regular issue.  Either all or non
> of the elements that go into a particular section of a compilation unit
> need to be const.  Or an error may result such as in this case if
> CONFIG_HOTPLUG is unset.
So we can avoid this if we invent a __constinitdata tag that uses
a new section?
I ask mainly to understand this error - not that I am that found
of the idea.

	Sam
