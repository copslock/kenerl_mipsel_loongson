Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 12:23:57 +0100 (BST)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:56511
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225262AbTEILXy>; Fri, 9 May 2003 12:23:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 1EDCA2BC3A
	for <linux-mips@linux-mips.org>; Fri,  9 May 2003 13:23:52 +0200 (CEST)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 17626-06
 for <linux-mips@linux-mips.org>; Fri,  9 May 2003 13:23:51 +0200 (CEST)
Received: from bogon.sigxcpu.org (bogon.physik.uni-konstanz.de [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 082FB2BC39
	for <linux-mips@linux-mips.org>; Fri,  9 May 2003 13:23:51 +0200 (CEST)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id D446D1735D; Fri,  9 May 2003 13:20:14 +0200 (CEST)
Date: Fri, 9 May 2003 13:20:14 +0200
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: Re: Problem of cross-mipsel-compiler GLIBC-2.3.X
Message-ID: <20030509112014.GC30563@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
References: <3EB0B329.9030603@ict.ac.cn> <16048.55936.346808.522687@cuddles.redhat.com> <3EB0DDC6.5080108@ict.ac.cn> <16048.57054.224964.883062@cuddles.redhat.com> <20030501085018.GA1885@greglaptop.attbi.com> <000a01c315cf$8171ac70$d017a8c0@pc208> <1052464867.2485.3.camel@ghostwheel.sfbay.redhat.com> <3EBB58C6.3070604@gentoo.org> <001f01c31603$1ed7fbd0$d017a8c0@pc208> <3EBB670E.4020200@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3EBB670E.4020200@gentoo.org>
User-Agent: Mutt/1.5.3i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Fri, May 09, 2003 at 04:30:06AM -0400, Kumba wrote:
> will work, maybe it won't.  Although, 2.14.90.0.1 was just released as 
> well, you might try that, or even CVS Head, as I heard that includes 
> last-minute mips fixes.  I'm fairly new to the whole cross-compiler 
I needed 2.14.90.0.1 to get the glibc testcases build right. Without
them I had lot's of unresolded "__libc_global_ctors" among others which
looked like a symbol visibility problem. 
Regards,
 -- Guido
