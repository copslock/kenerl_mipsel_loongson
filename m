Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 14:17:42 +0000 (GMT)
Received: from mx5.Informatik.Uni-Tuebingen.De ([IPv6:::ffff:134.2.12.32]:403
	"EHLO mx5.informatik.uni-tuebingen.de") by linux-mips.org with ESMTP
	id <S8225474AbUATORm>; Tue, 20 Jan 2004 14:17:42 +0000
Received: from localhost (loopback [127.0.0.1])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id C7AEE123; Tue, 20 Jan 2004 15:17:33 +0100 (NFT)
Received: from mx5.informatik.uni-tuebingen.de ([127.0.0.1])
 by localhost (mx5 [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22818-05; Tue, 20 Jan 2004 15:17:32 +0100 (NFT)
Received: from dual (semeai.Informatik.Uni-Tuebingen.De [134.2.15.66])
	by mx5.informatik.uni-tuebingen.de (Postfix) with ESMTP
	id D941B113; Tue, 20 Jan 2004 15:17:31 +0100 (NFT)
Received: from mrvn by dual with local (Exim 3.36 #1 (Debian))
	id 1Aiwh8-00014B-00; Tue, 20 Jan 2004 15:17:30 +0100
To: linux-mips@linux-mips.org
Cc: debian-mips@lists.debian.org
Subject: Need .config files for Debians kernel-image-2.4.24-mips(el)
From: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Date: 20 Jan 2004 15:17:30 +0100
Message-ID: <878yk21z7p.fsf@mrvn.homelinux.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Reasonable Discussion)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Virus-Scanned: by amavisd-new (McAfee AntiVirus) at informatik.uni-tuebingen.de
Return-Path: <brederlo@informatik.uni-tuebingen.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brederlo@informatik.uni-tuebingen.de
Precedence: bulk
X-list: linux-mips

Hi,

I'm putting together a kernel image package for debian mips and
mipsel.

To build actual usefull images I need to know what hardware the
different subarchitectures have by default and which they can have.

Example:

My XXS1500 has onboard ethernet, sound, usb, flash card, smart card.
The usualy boot method would be from flash or nfs-root. My .config has
support for the flash, ethernet, initrd and nfs-root buildin but the
sound and usb as modules.

The .config should have only boot devices buildin and everything
supported for the subarch as modules. That way everyone can boot but
the memory footprint is kept reasonably low.



If you are unsure about what all is supported on your subarch or if
you only have a .config specialised to your needs send me that anyway
with a little note saying so. I can compare different .configs and
merge them or fix things when another user complains.

MfG
        Goswin
