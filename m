Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 May 2008 12:49:32 +0100 (BST)
Received: from vs166246.vserver.de ([62.75.166.246]:52651 "EHLO
	vs166246.vserver.de") by ftp.linux-mips.org with ESMTP
	id S20039831AbYEYLt0 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 25 May 2008 12:49:26 +0100
Received: from t274f.t.pppool.de ([89.55.39.79] helo=powermac.local)
	by vs166246.vserver.de with esmtpa (Exim 4.63)
	(envelope-from <mb@bu3sch.de>)
	id 1K0Eiv-0002RL-C0; Sun, 25 May 2008 11:49:13 +0000
From:	Michael Buesch <mb@bu3sch.de>
To:	Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: mips BCM47XX compile error
Date:	Sun, 25 May 2008 13:48:51 +0200
User-Agent: KMail/1.9.6 (enterprise 0.20070907.709405)
Cc:	Adrian Bunk <bunk@kernel.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
References: <20080420100347.GH1595@cs181133002.pp.htv.fi> <200805251153.47325.mb@bu3sch.de> <20080525113634.GB20502@hall.aurel32.net>
In-Reply-To: <20080525113634.GB20502@hall.aurel32.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200805251348.52010.mb@bu3sch.de>
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Sunday 25 May 2008 13:36:34 Aurelien Jarno wrote:
> On Sun, May 25, 2008 at 11:53:46AM +0200, Michael Buesch wrote:
> > On Monday 21 April 2008 09:28:51 Aurelien Jarno wrote:
> > > On Mon, Apr 21, 2008 at 12:49:42AM +0200, Aurelien Jarno wrote:
> > > > Michael Buesch a écrit :
> > > > > On Sunday 20 April 2008 12:03:47 Adrian Bunk wrote:
> > > > >> Commit aab547ce0d1493d400b6468c521a0137cd8c1edf
> > > > >> (ssb: Add Gigabit Ethernet driver) causes the following
> > > > >> build error with bcm47xx_defconfig:
> > > > >>
> > > > >> <--  snip  -->
> > > > >>
> > > > >> ...
> > > > >>   LD      .tmp_vmlinux1
> > > > >> arch/mips/pci/built-in.o: In function `pcibios_enable_device':
> > > > >> (.text+0x1f8): undefined reference to `pcibios_plat_dev_init'
> > > > >> arch/mips/pci/built-in.o: In function `pcibios_enable_device':
> > > > >> (.text+0x1f8): relocation truncated to fit: R_MIPS_26 against `pcibios_plat_dev_init'
> > > > >> arch/mips/pci/built-in.o: In function `pcibios_init':
> > > > >> pci.c:(.init.text+0x14c): undefined reference to `pcibios_map_irq'
> > > > >> pci.c:(.init.text+0x158): undefined reference to `pcibios_map_irq'
> > > > >> make[1]: *** [.tmp_vmlinux1] Error 1
> > > > > 
> > > > > Some parts of the new 47xx arch code are not ported, yet.
> > > > 
> > > > It would have been nice at least to warn before breaking a platform.
> > > > 
> > > > > Somebody should port all the new code from openwrt SVN over to mainline.
> > > > > I don't really have time for that, at the moment, though.
> > > > 
> > > > I gave a quick look at openwrt SVN, and only find 2.6.23 patches. I
> > > > can't find a possible fix among them. Do you have a better pointer?
> > > > 
> > > 
> > > I have finally found it, the code was not in a form of a patch, but in
> > > form of a C code file.
> > > 
> > > I am working on a fix.
> > > 
> > 
> > What is the status of the fix?
> > We have a bugzilla entry
> > http://bugzilla.kernel.org/show_bug.cgi?id=10493
> > So if it's not ready, yet, I will have to fix it by myself.
> > 
> 
> A patch [1] has been sent 1 month ago, it waits with the other BCM47xx
> patches.
> 
> Aurelien
> 
> [1] http://marc.info/?l=linux-kernel&m=120876451216558&w=2
> 

Thanks a lot, Aurelien :)


-- 
Greetings Michael.
