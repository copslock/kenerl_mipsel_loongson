Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2004 06:33:18 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:58174
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224893AbUA3GdR>; Fri, 30 Jan 2004 06:33:17 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1AmSD1-0006yo-00; Fri, 30 Jan 2004 07:32:55 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1AmSD0-0001OU-00; Fri, 30 Jan 2004 07:32:54 +0100
Date: Fri, 30 Jan 2004 07:32:54 +0100
To: Jerry Walden <jerry.walden@lantronix.com>
Cc: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: Gcc - can't branch to undefined symbol
Message-ID: <20040130063254.GA5057@rembrandt.csv.ica.uni-stuttgart.de>
References: <603BA0CFF3788E46A0DB0918D9AA95100A0E3088@sj580004wcom.int.lantronix.com> <20040129221426.GA8465@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040129221426.GA8465@linux-mips.org>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Thu, Jan 29, 2004 at 12:25:16PM -0800, Jerry Walden wrote:
> 
> > I am using gcc 3.3.2 - when I assemble a file that has a branch to a
> > label, and the label is not defined in the .S file (i.e. there is no
> > extern - the label exists in another .S file) the error "cannot branch
> > to an undefined symbol" results.  Using an older version of
> > mipsel-gnu-linux-gcc does not report this error.  Any idea what I am
> > doing wrong?
> 
> This construct is illegal because it cannot be represented in MIPS ELF.

MIPS ELF could do (modulo some documentation bug in the spec), it is
specifically the assembler which forbids branches to external labels.
I wrote once a patch to allow it, but this broke NewABI support in turn.

It would be nice optimization as long as the linker can guarantee the
code is in the maximum branch range (+-128k).


Thiemo
