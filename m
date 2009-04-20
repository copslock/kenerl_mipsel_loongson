Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Apr 2009 16:00:45 +0100 (BST)
Received: from bsdimp.com ([199.45.160.85]:15088 "EHLO harmony.bsdimp.com")
	by ftp.linux-mips.org with ESMTP id S20031645AbZDTPAc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 20 Apr 2009 16:00:32 +0100
Received: from localhost (localhost [127.0.0.1])
	by harmony.bsdimp.com (8.14.2/8.14.1) with ESMTP id n3KEwSwg018213;
	Mon, 20 Apr 2009 08:58:28 -0600 (MDT)
	(envelope-from imp@bsdimp.com)
Date:	Mon, 20 Apr 2009 08:59:29 -0600 (MDT)
Message-Id: <20090420.085929.-1089997132.imp@bsdimp.com>
To:	florian@openwrt.org
Cc:	lucky.veeramallu@gmail.com, linux-mips@linux-mips.org
Subject: Re: in mips how to change the start address to the new second boot
 loader ?
From:	"M. Warner Losh" <imp@bsdimp.com>
In-Reply-To: <200904201100.39164.florian@openwrt.org>
References: <d77cedf30904142309na4355e6w63ecea63b0966c92@mail.gmail.com>
	<200904201100.39164.florian@openwrt.org>
X-Mailer: Mew version 5.2 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <imp@bsdimp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imp@bsdimp.com
Precedence: bulk
X-list: linux-mips

In message: <200904201100.39164.florian@openwrt.org>
            Florian Fainelli <florian@openwrt.org> writes:
: Hi,
: 
: Le Wednesday 15 April 2009 08:09:01 nagalakshmi veeramallu, vous avez écrit :
: > Hi ,
: >  I have a KMC board with mips VR4131 processor. The target board already
: >  having cmon boot loader on flash. Now I need to put my yamon boot loader
: >  which I modified according to the requirement on the flash. As we know
: > MIPS have fixed starting address 0xbfc00000, how to change this address to
: > other address so that after power on it can enter to the new address (boot
: > loader).
: 
: You cannot indeed change the boot address, but you can place a routine, or 
: even a bootloader at 0x1fc00000 which jumps to an arbitrary address.

I tried to tell him that in the FreeBSD/mips list, but he wouldn't
listen to me there either...  The simple fact is that the Vr41xx
processors cannot move their boot address at all....

Warner
