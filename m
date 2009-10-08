Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Oct 2009 22:20:13 +0200 (CEST)
Received: from ogre.sisk.pl ([217.79.144.158]:44616 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S1493640AbZJHUUH (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Oct 2009 22:20:07 +0200
Received: from localhost (localhost.localdomain [127.0.0.1])
	by ogre.sisk.pl (Postfix) with ESMTP id A3D2715C5A3;
	Thu,  8 Oct 2009 22:18:38 +0200 (CEST)
Received: from ogre.sisk.pl ([127.0.0.1])
 by localhost (ogre.sisk.pl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28300-09; Thu,  8 Oct 2009 22:18:16 +0200 (CEST)
Received: from tosh.localnet (220-bem-13.acn.waw.pl [82.210.184.220])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by ogre.sisk.pl (Postfix) with ESMTP id 6941615C47A;
	Thu,  8 Oct 2009 22:18:16 +0200 (CEST)
From:	"Rafael J. Wysocki" <rjw@sisk.pl>
To:	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: Re: [PATCH -v1] MIPS: fix pfn_valid() for FLATMEM
Date:	Thu, 8 Oct 2009 22:21:12 +0200
User-Agent: KMail/1.12.1 (Linux/2.6.32-rc3-rjw; KDE/4.3.1; x86_64; ; )
Cc:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
	Sergei Shtylyov <sshtylyov@ru.mvista.com>,
	Pavel Machek <pavel@ucw.cz>
References: <1255001548-30567-1-git-send-email-wuzhangjin@gmail.com>
In-Reply-To: <1255001548-30567-1-git-send-email-wuzhangjin@gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Message-Id: <200910082221.12649.rjw@sisk.pl>
X-Virus-Scanned: amavisd-new at ogre.sisk.pl using MkS_Vir for Linux
Return-Path: <rjw@sisk.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24189
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rjw@sisk.pl
Precedence: bulk
X-list: linux-mips

On Thursday 08 October 2009, Wu Zhangjin wrote:
> When CONFIG_FLATMEM enabled, STD/Hiberation will fail on YeeLoong
> laptop, This patch fixes it:
> 
> if pfn is between min_low_pfn and max_mapnr, the old pfn_valid() will
> return TRUE, but in reality, if the memory is not continuous, it should
> be false. for example:
> 
> $ cat /proc/iomem | grep "System RAM"
> 00000000-0fffffff : System RAM
> 90000000-bfffffff : System RAM
> 
> as we can see, it is not continuous, so, some of the memory is not valid
> but regarded as valid by pfn_valid(), and at last make STD/Hibernate
> fail when shrinking a too large number of invalid memory.
> 
> Here, we fix it via checking pfn is in the "System RAM" or not. and
> Seems pfn_valid() is not called in assembly code, we move it to
> "!__ASSEMBLY__" to ensure we can simply declare it via "extern int
> pfn_valid(unsigned long)" without Compiling Error.
> 
> (This -v1 version incorporates feedback from Pavel Machek <pavel@ucw.cz>
>  and Sergei Shtylyov <sshtylyov@ru.mvista.com>)

Hmm.  What exactly would be wrong with using register_nosave_region() or
register_nosave_region_late() like x86 does?

Thanks,
Rafael
