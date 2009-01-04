Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 04 Jan 2009 14:54:06 +0000 (GMT)
Received: from main.gmane.org ([80.91.229.2]:19842 "EHLO ciao.gmane.org")
	by ftp.linux-mips.org with ESMTP id S24207815AbZADOyE (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 4 Jan 2009 14:54:04 +0000
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1LJUMd-00017h-6K
	for linux-mips@linux-mips.org; Sun, 04 Jan 2009 14:54:03 +0000
Received: from vpn40.rz.tu-ilmenau.de ([141.24.172.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 04 Jan 2009 14:54:03 +0000
Received: from opencode by vpn40.rz.tu-ilmenau.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <linux-mips@linux-mips.org>; Sun, 04 Jan 2009 14:54:03 +0000
X-Injected-Via-Gmane: http://gmane.org/
To:	linux-mips@linux-mips.org
From:	Andi <opencode@gmx.net>
Subject:  SMP8634 Linux boot
Date:	Sun, 04 Jan 2009 15:53:50 +0100
Message-ID: <gjqihv$h6m$1@ger.gmane.org>
Mime-Version:  1.0
Content-Type:  text/plain; charset=ISO-8859-1
Content-Transfer-Encoding:  7bit
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: vpn40.rz.tu-ilmenau.de
User-Agent: Thunderbird 2.0.0.18 (X11/20081125)
Return-Path: <sgi-linux-mips@m.gmane.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: opencode@gmx.net
Precedence: bulk
X-list: linux-mips

Hi List,

First of all, sorry for asking a slightly off topic question on that
list but it has something to do with MIPS and Linux though.
As I don't have a working zboot image, I am trying to load zboot or
yamon via JTAG to a SMP8634 board in order to boot Linux afterwards. I
followed the instructions described in smp8634-documentation and was
able to build a yamon and reboot image which successfully loads on a
plain smp8634. Unfortunately, this is not the case when building yamon
with XENV support or when trying to load a zboot image instead. On the
other hand I can't load Linux on a yamon without XENV support, yet.
After loading xboot which fails to load zboot now, do I have to
initialize the memory mapping or other registers prior loading any other
code like yamon or zboot? If so, which one?

Any help to load Linux is very appreciated.

Best regards,
	Andi
