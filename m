Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Feb 2008 01:09:58 +0000 (GMT)
Received: from smtpauth13.prod.mesa1.secureserver.net ([64.202.165.37]:12480
	"HELO smtpauth13.prod.mesa1.secureserver.net") by ftp.linux-mips.org
	with SMTP id S28577837AbYBLBJs (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 12 Feb 2008 01:09:48 +0000
Received: (qmail 17198 invoked from network); 12 Feb 2008 01:09:38 -0000
Received: from unknown (66.51.229.131)
  by smtpauth13.prod.mesa1.secureserver.net (64.202.165.37) with ESMTP; 12 Feb 2008 01:09:37 -0000
Message-ID: <47B0F164.8080401@hodgens.net>
Date:	Mon, 11 Feb 2008 18:07:48 -0700
From:	Ben Hodgens <ben@hodgens.net>
Reply-To:  ben@hodgens.net
User-Agent: Icedove 1.5.0.14pre (X11/20071018)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: General info on kernel status for vr4121/MobilePro 780
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ben@hodgens.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@hodgens.net
Precedence: bulk
X-list: linux-mips

I'm attempting build a system around an NEC MobilePro 780, and as there does not 
appear to be full support (ie, can't seem to get a kernel to boot) in either the 
current 2.4 or 2.6 kernel trees.

Here's what I've found and tried so far:

* The Linux VR project's "latest" kernel, circa 2001 or something like that - 
linux-vr-0.1.1.tar.bz2. This does not actually have an option for the MobilePro 
780 in the kernel config, though there is the 770.
* The kernel on http://www.handhelds.org/moin/moin.cgi/NecMobilePro780. This one 
-appears- to be the most complete I've found with regard to the 780; however, 
the tree is a 2.3 base (2.3.99 or something like that, I think), and not only 
pretty damn old, but I'm having a difficult time building it with the MIPS 
Technologies toolchain as a result. (Nothing I think I won't be able to figure 
out eventually - just makefile issues - but I don't want to persue it too much 
if there's a better alternative to start with). Additionally, this page has a 
binary kernel (and rootfs) which boots, but it doesn't boot with either a Debian 
sarge or etch bootstrap-installed rootfs (this is probably related to devfs, 
Ithink).
* Both the latest 2.4 and 2.6 kernels don't have explicit support for the MP. I 
don't know where to go from here to where I want to go, though if there's 
nothing current in the current trees, I figure I'll learn to port drivers 
(provided I can figure which is the current latest support for the MP).

So I'm asking: does anyone know where else I might look? If there is no current 
kernel tree which builds, does anyone know where the current/most up-to-date 
device support for the MobilePro is kept, or in which kernel it's in?

Any/all help would be appreciated. Thanks!

Ben Hodgens
ben@hodgens.net
