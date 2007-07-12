Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2007 03:31:39 +0100 (BST)
Received: from nic.NetDirect.CA ([216.16.235.2]:48816 "EHLO
	rubicon.netdirect.ca") by ftp.linux-mips.org with ESMTP
	id S20022122AbXGLCbh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jul 2007 03:31:37 +0100
X-Originating-Ip: 72.143.66.27
Received: from [192.168.1.102] (CPE0018396a01fc-CM001225dbafb6.cpe.net.cable.rogers.com [72.143.66.27])
	(authenticated bits=0)
	by rubicon.netdirect.ca (8.13.1/8.13.1) with ESMTP id l6C2VDTY000349
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 11 Jul 2007 22:31:21 -0400
Date:	Wed, 11 Jul 2007 22:29:29 -0400 (EDT)
From:	"Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To:	Shane McDonald <mcdonald.shane@gmail.com>
cc:	linux-mips@linux-mips.org
Subject: Re: latest list of apparently "dead" CONFIG variables under arch/mips
In-Reply-To: <b2b2f2320707111914t5ac80d24ie374999e35db4c8f@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0707112228270.8874@localhost.localdomain>
References: <Pine.LNX.4.64.0707111437480.12345@localhost.localdomain> 
 <b2b2f2320707111546p5b7e1c6dv60a8d600a28634e7@mail.gmail.com> 
 <Pine.LNX.4.64.0707111901110.28156@localhost.localdomain>
 <b2b2f2320707111914t5ac80d24ie374999e35db4c8f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Net-Direct-Inc-MailScanner-Information: Please contact the ISP for more information
X-Net-Direct-Inc-MailScanner: Found to be clean
X-Net-Direct-Inc-MailScanner-SpamCheck:	not spam, SpamAssassin (not cached,
	score=-36.8, required 5, autolearn=not spam, ALL_TRUSTED -1.80,
	BAYES_00 -15.00, INIT_RECVD_OUR_AUTH -20.00)
X-Net-Direct-Inc-MailScanner-From: rpjday@mindspring.com
Return-Path: <rpjday@mindspring.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15720
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@mindspring.com
Precedence: bulk
X-list: linux-mips

On Wed, 11 Jul 2007, Shane McDonald wrote:

> Hi Robert:
>
>  Maybe I should have gone into more detail in my initial response.
>
>  There's a patch posted to the i2c mailing list that adds
> CONFIG_PMCTWILED into drivers/i2c/chips/Kconfig.  It probably hasn't
> been accepted yet, so that's why it's not showing up in any Kconfig
> on l-m.o.  The patch shows up here:
> http://lists.lm-sensors.org/pipermail/i2c/2007-March/001003.html.

yes, i've seen that before -- the code to check a CONFIG option shows
up before the actual Kconfig entry for it.  it would, of course, be
nice if those two things arrived simultaneously.  oh, well.

>  I don't know why they have defined CONFIG_SQUASHFS in their
> defconfig, although I believe their distribution includes squashfs
> patches.  Their patch to define the defconfig seems to include
> it--the reason why is probably a question for the original patch:
> http://www.linux-mips.org/archives/linux-mips/2007-06/msg00197.html.

i'm singularly unenthusiastic about the idea of hardcoding CONFIG_
variables into defconfig files if they're not defined in Kconfig
files in the main kernel tree itself.  that way lies bad design and
confusion.

if their distro is going to add squashfs patches, then it should also
add the CONFIG-related code for it as well, and not dump that stuff
into the main tree where it makes no sense.

rday
-- 
========================================================================
Robert P. J. Day
Linux Consulting, Training and Annoying Kernel Pedantry
Waterloo, Ontario, CANADA

http://fsdev.net/wiki/index.php?title=Main_Page
========================================================================
