Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2005 15:18:15 +0000 (GMT)
Received: from extgw-uk.mips.com ([62.254.210.129]:38673 "EHLO
	bacchus.net.dhis.org") by ftp.linux-mips.org with ESMTP
	id S8134058AbVKPPR5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 16 Nov 2005 15:17:57 +0000
Received: from dea.linux-mips.net (localhost.localdomain [127.0.0.1])
	by bacchus.net.dhis.org (8.13.4/8.13.1) with ESMTP id jAGFJuG5013394;
	Wed, 16 Nov 2005 15:19:56 GMT
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.13.4/8.13.4/Submit) id jAGFJuYC013393;
	Wed, 16 Nov 2005 15:19:56 GMT
Date:	Wed, 16 Nov 2005 15:19:56 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	Jonathan Day <imipak@yahoo.com>, linux-mips@linux-mips.org
Subject: Re: Another problem with compiling Linux kernel
Message-ID: <20051116151956.GG3229@linux-mips.org>
References: <20051115213005.79456.qmail@web31513.mail.mud.yahoo.com> <437A5511.8020806@avtrex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <437A5511.8020806@avtrex.com>
User-Agent: Mutt/1.4.2.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9513
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Nov 15, 2005 at 01:37:21PM -0800, David Daney wrote:

> >what happens". When trying GCC 4.1.0 (snapshot from
> >20051017), I get the following error:
> >
> >In file included from include/linux/nfs_fs.h:15,
> >                 from init/do_mounts.c:12:
> >include/linux/pagemap.h: In function
> >'fault_in_pages_readable':
> >include/linux/pagemap.h:237: error: read-only variable
> >'__gu_val' used as 'asm' output
> >include/linux/pagemap.h:237: error: read-only variable
> >'__gu_val' used as 'asm' output
> >include/linux/pagemap.h:237: error: read-only variable
> >'__gu_val' used as 'asm' output
> >include/linux/pagemap.h:237: error: read-only variable
> >'__gu_val' used as 'asm' output
> >include/linux/pagemap.h:243: error: read-only variable
> >'__gu_val' used as 'asm' output
> >include/linux/pagemap.h:243: error: read-only variable
> >'__gu_val' used as 'asm' output
> >include/linux/pagemap.h:243: error: read-only variable
> >'__gu_val' used as 'asm' output
> >include/linux/pagemap.h:243: error: read-only variable
> >'__gu_val' used as 'asm' output
> >make[1]: *** [init/do_mounts.o] Error 1
> >make: *** [init] Error 2
> >
> >This one may be a compiler bug (experimental GCCs are,
> >well, experimental!) but it makes it somewhat harder
> >to know if the later issue is resolved by using a
> >different toolchain.
> >
> 
> This is not a GCC bug, but a change in GCC behavior.  One patch was 
> posted here:
> 
> http://www.linux-mips.org/cgi-bin/mesg.cgi?a=linux-mips&i=Pine.LNX.4.61.0511022057140.3511%40trantor.stuart.netsweng.com
> 
> I don't know if the change made it into the linux-mips git repository or 
> not.

That patch has a few shortcomings, so I didn't apply it yet.  Unfortunately
a proper solution turns out to be a pretty hard nut.

  Ralf
