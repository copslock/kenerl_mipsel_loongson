Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Mar 2004 10:18:53 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:29298
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225269AbUCPKSw>; Tue, 16 Mar 2004 10:18:52 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42] ident=mail)
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1B3Bes-0007rQ-00
	for <linux-mips@linux-mips.org>; Tue, 16 Mar 2004 11:18:50 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1B3Bes-0001Ej-00
	for <linux-mips@linux-mips.org>; Tue, 16 Mar 2004 11:18:50 +0100
Date: Tue, 16 Mar 2004 11:18:50 +0100
To: linux-mips <linux-mips@linux-mips.org>
Subject: Re: newport console fixes
Message-ID: <20040316101849.GE25814@rembrandt.csv.ica.uni-stuttgart.de>
References: <20040315135708.GA7861@fh-brandenburg.de> <20040316095051.GA19755@icm.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040316095051.GA19755@icm.edu.pl>
User-Agent: Mutt/1.5.5.1i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Dominik 'Rathann' Mierzejewski wrote:
> On Mon, Mar 15, 2004 at 02:57:08PM +0100, Markus Dahms wrote:
> > Hello list,
> > 
> > I patched the newport console driver to have the correct colormap
> > when exiting X11 / switching from X11 to console.
> > This problem doesn't affect all versions of the newport, the old
> > revision in my very old indy doesn't show these effects.
> > Some revision information of my (different) newports is written in
> > the header of the attached diff.
> 
> Just for the record, my Indy also exhibits this fault, but has different
> cmap revision than yours:
> 
> NG1: Revision 6, 8 bitplanes, REX3 revision B, VC2 revision A,
>      xmap9 revision A, cmap revision C, bt445 revision D
> NG1: Screensize 1280x1024

The same as mine, showing this problem also.


Thiemo
