Received:  by oss.sgi.com id <S42276AbQGaAhl>;
	Sun, 30 Jul 2000 17:37:41 -0700
Received: from u-101.karlsruhe.ipdial.viaginterkom.de ([62.180.19.101]:22024
        "EHLO u-101.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42267AbQGaAhX>; Sun, 30 Jul 2000 17:37:23 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S868884AbQG1RwH>;
        Fri, 28 Jul 2000 19:52:07 +0200
Date:   Fri, 28 Jul 2000 19:52:07 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>,
        Keith M Wesolowski <wesolows@chem.unr.edu>,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: strace on Linux/MIPS?
Message-ID: <20000728195207.C8450@bacchus.dhis.org>
References: <3980C024.8DCCA084@mvista.com> <20000727161212.B12897@chem.unr.edu> <3980C9F0.96B48253@mvista.com> <20000728021137.B1328@bacchus.dhis.org> <3980EC1C.AEF173D2@mvista.com> <20000728042109.C1981@bacchus.dhis.org> <20000728135139.A4903@cistron.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000728135139.A4903@cistron.nl>; from wichert@cistron.nl on Fri, Jul 28, 2000 at 01:51:39PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Fri, Jul 28, 2000 at 01:51:39PM +0200, Wichert Akkerman wrote:

> Previously Ralf Baechle wrote:
> > Looks like strace is still tryping to copy mmap_arg_struct like on Intel
> > but on MIPS we don't use that?
> 
> Could be, I think MIPS and i386 use the same codepath there. Patches
> are appreciated so I can include them in strace 4.3 (eta 3 weeks from
> now)

Well, they shouldn't use the same code ...

Bananaware patch below.

  Ralf

--- strace/linux/mips/syscallent.orig	Mon May  1 03:09:31 2000
+++ strace/linux/mips/syscallent.h	Fri Jul 28 19:50:13 2000
@@ -4088,7 +4088,7 @@
 	{ 1,	TF,	sys_swapon,		"swapon"	}, /* 4087 */
 	{ 3,	0,	sys_reboot,		"reboot"	}, /* 4088 */
 	{ 3,	0,	sys_readdir,		"readdir"	}, /* 4089 */
-	{ 6,	0,	sys_old_mmap,		"mmap"		}, /* 4090 */
+	{ 6,	0,	sys_mmap,		"mmap"		}, /* 4090 */
 	{ 2,	0,	sys_munmap,		"munmap"	}, /* 4091 */
 	{ 2,	TF,	sys_truncate,		"truncate"	}, /* 4092 */
 	{ 2,	0,	sys_ftruncate,		"ftruncate"	}, /* 4093 */
