Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2007 03:08:30 +0100 (BST)
Received: from topsns2.toshiba-tops.co.jp ([202.230.225.126]:15788 "EHLO
	topsns2.toshiba-tops.co.jp") by ftp.linux-mips.org with ESMTP
	id S20029209AbXIZCIW (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 26 Sep 2007 03:08:22 +0100
Received: from topsms.toshiba-tops.co.jp by topsns2.toshiba-tops.co.jp
          via smtpd (for ftp.linux-mips.org [194.74.144.162]) with ESMTP; Wed, 26 Sep 2007 11:08:20 +0900
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 3704942A90;
	Wed, 26 Sep 2007 11:08:15 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 2A92142A60;
	Wed, 26 Sep 2007 11:08:15 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id l8Q28EAF053834;
	Wed, 26 Sep 2007 11:08:14 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Wed, 26 Sep 2007 11:08:14 +0900 (JST)
Message-Id: <20070926.110814.41629599.nemoto@toshiba-tops.co.jp>
To:	tbm@cyrius.com
Cc:	linux-mips@linux-mips.org, fbuihuu@gmail.com
Subject: Re: CONFIG_BUILD_ELF64 broken on IP32 since 2.6.20
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070925181353.GA15412@deprecation.cyrius.com>
	<20070330.150912.11964158.nemoto@toshiba-tops.co.jp>
References: <20070925181353.GA15412@deprecation.cyrius.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16680
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 25 Sep 2007 20:13:53 +0200, Martin Michlmayr <tbm@cyrius.com> wrote:
> IP32 kernels that are built with CONFIG_BUILD_ELF64=y only produce an
> exception when booted.  This worked with 2.6.19 and before.  I haven't
> had a chance to dig deep yet but it seems both Franck Bui-Huu and
> Atsushi Nemoto had patches in 2.6.20 that might have caused this.
> This still happens with 2.6.22.  I cannot boot current git for other
> reasons.

I think this is solved on current git a few weeks ago by this commit
(not mainlined yet):

> Subject: [MIPS] Fix CONFIG_BUILD_ELF64 kernels with symbols in CKSEG0.
> Date: 	Tue, 11 Sep 2007 11:12:03 +0100
> Author: Ralf Baechle <ralf@linux-mips.org> Tue Sep 11 08:50:40 2007 +0100
> Commit: db423f6e86c3c4c70edf3eaf504e22c467b9f97c
> Gitweb: http://www.linux-mips.org/g/linux/db423f6e
> Branch: master

It is just one liner and can be backported easily.

> If anyone has an idea which specific patch might have caused this,
> please let me know.  Otherwise I'll try to find time in the next few
> days to revert various patches.

Well, It might be a bit hard to revert specific patch in patchset with
dependencies.

For background, there were fairly lengthy discussion on this topic.
My thought was abstracted in this:

(http://www.linux-mips.org/archives/linux-mips/2007-03/msg00484.html)
On Fri, 30 Mar 2007 15:09:12 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> And I think the answer is
> 
> 1) Disable CONFIG_BUILD_ELF64 in short term.
> 
> 2) Apply Franck's patchset with a slight change (enclose -msym32 by
>    $(call cc-option)).
> 
> And _if_ this did not work on IP32, something needs to be fixed, but I
> can not see why for now.

I still think CONFIG_BUILD_ELF64=n is best choice.  You can get
smaller and faster kernel with this.  Are there any reason to use
CONFIG_BUILD_ELF64=y for IP32?  (Note that CONFIG_BUILD_ELF64 and
CONFIG_BOOT_ELF64 is separate thing.)

And The Franck's patchset is already in linux-queue tree of lmo so
should be in 2.6.24.

And finally I can remember the report from Kumba:

http://www.linux-mips.org/archives/linux-mips/2007-03/msg00485.html

I do not know this RM52xx thing is fixed or not. ;)

---
Atsushi Nemoto
