Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Mar 2004 16:52:07 +0000 (GMT)
Received: from mx.mips.com ([IPv6:::ffff:206.31.31.226]:7568 "EHLO mx.mips.com")
	by linux-mips.org with ESMTP id <S8225370AbUCRQwG>;
	Thu, 18 Mar 2004 16:52:06 +0000
Received: from mercury.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.12.11/8.12.11) with ESMTP id i2IGgma5010236;
	Thu, 18 Mar 2004 08:42:48 -0800 (PST)
Received: from gmu-linux (gmu-linux.mips.com [172.20.8.94])
	by mercury.mips.com (8.12.11/8.12.11) with ESMTP id i2IGprgp011820;
	Thu, 18 Mar 2004 08:51:54 -0800 (PST)
Subject: Re: gcc support of mips32 release 2
From: Michael Uhler <uhler@mips.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Dominic Sweetman <dom@mips.com>,
	Eric Christopher <echristo@redhat.com>,
	Long Li <long21st@yahoo.com>, linux-mips@linux-mips.org,
	David Ung <davidu@mips.com>, Nigel Stephens <nigel@mips.com>
In-Reply-To: <Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
References: <20040305075517.42647.qmail@web40404.mail.yahoo.com>
	<1078478086.4308.14.camel@dzur.sfbay.redhat.com>
	<16456.21112.570245.1011@arsenal.mips.com> 
	<Pine.LNX.4.55.0403181404210.5750@jurand.ds.pg.gda.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-11) 
Date: 18 Mar 2004 08:52:48 -0800
Message-Id: <1079628769.1558.4.camel@gmu-linux>
Mime-Version: 1.0
X-Spam-Scan: SA 2.63
X-Scanned-By: MIMEDefang 2.39
Return-Path: <uhler@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4582
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: uhler@mips.com
Precedence: bulk
X-list: linux-mips

Dominic already gave the long explanation.

When we added field insert and extract, we were very sensitive to the
implementability of the instructions.  If you look at the semantic
definition, independent of the somewhat complex explanation, you'll
find that both insert and extract can be implemented with a
left or right shift, followed by a mux-per-bit which selects between
the shifted operand or the unshifted operand.  That can be done
very efficiently in hardware.

/gmu

On Thu, 2004-03-18 at 05:18, Maciej W. Rozycki wrote:
> On Fri, 5 Mar 2004, Dominic Sweetman wrote:
> 
> > We added patterns to let our (old) GCC use the new rotates and
> > bit-insert/extracts, at least in simple cases.  I'm not sure whether
> > we've put those in our 3.4 evolution tree yet, but if we have we
> > should push those out.
> 
>  As a side note, it makes me wonder where the borderline of the RISC
> actually is.  Even Intel abandoned support for bit insert/extract
> instructions after an initial attempt for the i386.  They figured out the
> implementation was too complicated. ;-)
> 
> -- 
> +  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
> +--------------------------------------------------------------+
> +        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
> 
-- 
Michael Uhler, Chief Technology Officer
MIPS Technologies, Inc.  Email: uhler@mips.com
1225 Charleston Road     Voice:  (650)567-5025  FAX:   (650)567-5225
Mountain View, CA 94043  Mobile: (650)868-6870  Admin: (650)567-5085
