Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Apr 2008 23:49:56 +0100 (BST)
Received: from hall2.aurel32.net ([91.121.138.14]:44930 "EHLO
	hall2.aurel32.net") by ftp.linux-mips.org with ESMTP
	id S20037073AbYDTWty (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 20 Apr 2008 23:49:54 +0100
Received: from volta.aurel32.net ([2002:52e8:2fb:1:21e:8cff:feb0:693b])
	by hall2.aurel32.net with esmtpsa (TLS-1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <aurelien@aurel32.net>)
	id 1JniLv-000317-0o; Mon, 21 Apr 2008 00:49:43 +0200
Received: from aurel32 by volta.aurel32.net with local (Exim 4.69)
	(envelope-from <aurelien@aurel32.net>)
	id 1JniLu-0005TC-Jf; Mon, 21 Apr 2008 00:49:42 +0200
Date:	Mon, 21 Apr 2008 00:49:42 +0200
From:	Aurelien Jarno <aurelien@aurel32.net>
To:	Michael Buesch <mb@bu3sch.de>
Cc:	Adrian Bunk <bunk@kernel.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
Subject: Re: mips BCM47XX compile error
Message-ID: <20080420224942.GA21009@volta.aurel32.net>
Mail-Followup-To: Aurelien Jarno <aurelien@aurel32.net>,
	Michael Buesch <mb@bu3sch.de>, Adrian Bunk <bunk@kernel.org>,
	"John W. Linville" <linville@tuxdriver.com>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	linux-kernel@vger.kernel.org
References: <20080420100347.GH1595@cs181133002.pp.htv.fi> <200804201214.46936.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200804201214.46936.mb@bu3sch.de>
User-Agent: Mozilla-Thunderbird 2.0.0.12 (X11/20080405)
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18974
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

Michael Buesch a écrit :
> On Sunday 20 April 2008 12:03:47 Adrian Bunk wrote:
>> Commit aab547ce0d1493d400b6468c521a0137cd8c1edf
>> (ssb: Add Gigabit Ethernet driver) causes the following
>> build error with bcm47xx_defconfig:
>>
>> <--  snip  -->
>>
>> ...
>>   LD      .tmp_vmlinux1
>> arch/mips/pci/built-in.o: In function `pcibios_enable_device':
>> (.text+0x1f8): undefined reference to `pcibios_plat_dev_init'
>> arch/mips/pci/built-in.o: In function `pcibios_enable_device':
>> (.text+0x1f8): relocation truncated to fit: R_MIPS_26 against `pcibios_plat_dev_init'
>> arch/mips/pci/built-in.o: In function `pcibios_init':
>> pci.c:(.init.text+0x14c): undefined reference to `pcibios_map_irq'
>> pci.c:(.init.text+0x158): undefined reference to `pcibios_map_irq'
>> make[1]: *** [.tmp_vmlinux1] Error 1
> 
> Some parts of the new 47xx arch code are not ported, yet.

It would have been nice at least to warn before breaking a platform.

> Somebody should port all the new code from openwrt SVN over to mainline.
> I don't really have time for that, at the moment, though.

I gave a quick look at openwrt SVN, and only find 2.6.23 patches. I
can't find a possible fix among them. Do you have a better pointer?

-- 
  .''`.  Aurelien Jarno	            | GPG: 1024D/F1BCDB73
 : :' :  Debian developer           | Electrical Engineer
 `. `'   aurel32@debian.org         | aurelien@aurel32.net
   `-    people.debian.org/~aurel32 | www.aurel32.net
