Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 May 2009 03:12:35 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:50396 "EHLO lemote.com"
	rhost-flags-FAIL-FAIL-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20023811AbZEZCMa (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 May 2009 03:12:30 +0100
Received: from localhost (localhost [127.0.0.1])
	by lemote.com (Postfix) with ESMTP id E3C87340AE;
	Tue, 26 May 2009 10:07:04 +0800 (CST)
X-Virus-Scanned: Debian amavisd-new at lemote.com
Received: from lemote.com ([127.0.0.1])
	by localhost (www.lemote.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id alA50NUjt1Vn; Tue, 26 May 2009 10:06:48 +0800 (CST)
Received: from [172.16.2.17] (unknown [222.92.8.142])
	by lemote.com (Postfix) with ESMTP id 2E82F340AD;
	Tue, 26 May 2009 10:06:48 +0800 (CST)
Subject: Re: [loongson-support 00/27] linux PATCHes of loongson-based
 machines
From:	yanh <yanh@lemote.com>
Reply-To: yanh@lemote.com
To:	Daniel Clark <dclark@pobox.com>
Cc:	wuzhangjin@gmail.com, linux-mips@linux-mips.org,
	Ralf Baechle <ralf@linux-mips.org>,
	Philippe Vachon <philippe@cowpig.ca>,
	Zhang Le <r0bertz@gentoo.org>,
	Zhang Fuxin <zhangfx@lemote.com>,
	Arnaud Patard <apatard@mandriva.com>,
	loongson-dev@googlegroups.com, gnewsense-dev@nongnu.org,
	Nicholas Mc Guire <hofrat@hofr.at>,
	Liu Junliang <liujl@lemote.com>,
	Erwan Lerale <erwan@thiscow.com>, rms@gnu.org
In-Reply-To: <4A14846A.3080006@pobox.com>
References: <cover.1242851584.git.wuzhangjin@gmail.com>
	 <4A14846A.3080006@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Date:	Tue, 26 May 2009 10:11:40 +0800
Message-Id: <1243303900.9819.68.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.24.1 (2.24.1-2.fc10) 
Content-Transfer-Encoding: 8bit
Return-Path: <yanh@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22965
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yanh@lemote.com
Precedence: bulk
X-list: linux-mips

在 2009-05-20三的 18:30 -0400，Daniel Clark写道：
> wuzhangjin@gmail.com wrote:
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> > 
> > Dear all,
> > 
> > I have cleaned up the source code of loongson-based machines support and
> > updated it to linux-2.6.29.3, the latest result is put to the following git
> > repository:
> > 
> >    git://dev.lemote.com/rt4ls.git  to-ralf
> > 	or
> >    http://dev.lemote.com/cgit/rt4ls.git/log/?h=to-ralf
> > 
> > this job is based on the to-mips branch of Yanhua's
> > git://dev.lemote.com/linux_loongson.git and the lm2e-fixes branch of Philippe's
> > git://git.linux-cisco.org/linux-mips.git. thanks goes to them.
> > 
> > and also, thanks goes to Erwen and heihaier for testing the latest branch, and
> > thanks ralf, zhangLe, john and the other guyes for reviewing the old branch and
> > giving good suggestions.
> > 
> > the most differences between this branch and the old branch include:
> > 
> >    * all of these patches are checked by script/checkpatch.pl, only a few
> >    warnings left.
> > 
> >    * the cs5536 part have been cleaned up deeply. the old pcireg.h is removed
> >    via using the include/linux/pci_regs.h instead. and the old cs5536_vsm.c is
> >    divided to several modules, one file one module.
> > 
> >    * the source code in driver/video/smi in cleaned up a lot, two trashy header
> >    files are removed, and several trashy functions are removed, lots of coding
> >    style errors and warnings are cleaned up.
> > 
> >    * gcc 4.4 support, including 32bit and 64bit, and also it is gcc 4.3
> >    compatiable
> > 
> > I have tested it in 32bit and 64bit with gcc 4.3 on fuloong(2e), fuloong(2f),
> > yeeloong(2f), all of them work well, and also test it in 32bit and 64bit with
> > gcc 4.4 on fuloong(2f), works normally. Erwen and heihaier have tested it in
> > 64bit with gcc 4.4 on a yeeloong laptop.
> 
> Wow this is great. Does this branch also include the suspend-to-disk /
> resume-from-disk code from the lemote 2.6.27 STD branch?
> 
> From a user's perspective, what are the loongson-oriented improvements
> of this branch over the existing 2.6.27 branch?
> 
> I'd also like to know if:
> 
> (a) the ec-modules and
> 
> (b) the rtl8187b code
> 
> that is currently separate from the main lemote linux 2.6.27 git (the
> former in a git repository, the later only in a .tar.gz file as far as I
> know) is included in the 2.6.29.3 branch now.
The ec-modules is firmware related. We think it would be more difficult
to enter into mainline.
The rtl8187b is included in 2.6.27 kernel, however, there are many
issues in it(even in the 2.6.29 or 2.6.30). Some known isuses are below:
1. very hard to connect, and very poor performance.
2. may cause system crash(now this can be fixed)
 issue 1 is the main reason that we stick to use the realtek providing
driver.
> 
> I can of course check this via git when I have internet access next, but
> I'm guessing you would be able to provide context beyond just the code
> changes to the answers of these questions  :-)
> 
> Oh, and one last thing - is compilation with the lemote-patched binutils
> / "-mfix-gs2f-kernel" "-mfix-ls2f-kernel" (I'm told these did the same
> things, the name just changed for some reason - currently I'm using a
> binutils / as that understands the "-mfix-ls2f-kernel" option) still
> needed? Without this in the 2.6.27 branch, and esp. with the ec-modules,
> there were very frequent hard linux crashes (sysrq keys not working).
this patch add a option into 'as'. Previously, it's named
-mfix-gs2f-kernel, later it is named as -mfix-ls2f-kernel

Any way this patch is not formal, and I prefer it not enter into
mainline kernel.
> 
> BTW for me, this is interesting in the context of
> http://config.fsf.org/trac/public/wiki/RmsLinuxForYou , which I have
> several people helping me test at the moment - currently the biggest
> issue is hard crashes every day or other day, or more frequently if
> there is a lot of disk or usb I/O.

This issue is caused by the CPU host bridge and CS5536 co-work.
currently, we need this patch to work around this issue. Later CPUs
design will handle it properly. 
> 
> Thanks,
