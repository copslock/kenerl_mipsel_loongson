Received:  by oss.sgi.com id <S42236AbQIHBpZ>;
	Thu, 7 Sep 2000 18:45:25 -0700
Received: from u-93.karlsruhe.ipdial.viaginterkom.de ([62.180.21.93]:2310 "EHLO
        u-93.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com with ESMTP
	id <S42241AbQIHBo5>; Thu, 7 Sep 2000 18:44:57 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S869075AbQIGJ6t>;
        Thu, 7 Sep 2000 11:58:49 +0200
Date:   Thu, 7 Sep 2000 11:58:49 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Jun Sun <jsun@mvista.com>, linux-fbdev@vuser.vu.union.edu,
        linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: mmap() frame buffer causes bus error on MIPS ...
Message-ID: <20000907115849.A6341@bacchus.dhis.org>
References: <39B5BD14.A8D2F467@mvista.com> <39B5DABB.7FB85B09@mvista.com> <39B6B75D.2501654E@mvista.com> <20000907112013.A6259@bacchus.dhis.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20000907112013.A6259@bacchus.dhis.org>; from ralf@oss.sgi.com on Thu, Sep 07, 2000 at 11:20:13AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Sep 07, 2000 at 11:20:13AM +0200, Ralf Baechle wrote:

> The definition should be:
> 
> extern inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
> {
> 	return __pte(physpage) | pgprot_val(pgprot);
> }
> 
> Masking with PAGE_MASK also seemed to be useless.
> 
> It's really surprising why it never has been caught.  Probably people
> feed it with the addresses that are tweaked such that sich just work.
> 
> I'll cook up a patch for this bug.

This one has a interesting history in CVS:

revision 1.21
date: 1999/07/26 19:42:43;  author: harald;  state: Exp;  lines: +84 -82
The remaining R3000 changes. From now on the CVS will be R3000 aware. R3000
Indigo anyone? :-)

which re-establishes a bug which was fixed by:

revision 1.16
date: 1998/08/28 23:24:03;  author: tsbogend;  state: Exp;  lines: +2 -2
fixed MAP_NR() second try:-(

which I introduced in:

revision 1.15
date: 1998/08/25 09:21:59;  author: ralf;  state: Exp;  lines: +148 -70
 o Merge with Linux 2.1.116.
 o New Newport console code.
 o New G364 console code.

which got fixed by:

revision 1.13
date: 1998/07/13 23:28:18;  author: tsbogend;  state: Exp;  lines: +1 -1
fixed physical mapping

So the original bug is probably as old as the MIPS port itself ...

Ouch.

  Ralf
