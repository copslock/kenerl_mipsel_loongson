Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Oct 2004 23:51:39 +0100 (BST)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:38712
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8224896AbUJRWvb>; Mon, 18 Oct 2004 23:51:31 +0100
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CJgLM-0001rh-00; Tue, 19 Oct 2004 00:51:08 +0200
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CJgLJ-00085I-00; Tue, 19 Oct 2004 00:51:05 +0200
Date: Tue, 19 Oct 2004 00:51:05 +0200
To: "Stephen P. Becker" <geoman@gentoo.org>
Cc: Andre.Messerschmidt@infineon.com, linux-mips@linux-mips.org
Subject: Re: Mozilla Firefox compile problem
Message-ID: <20041018225105.GA21691@rembrandt.csv.ica.uni-stuttgart.de>
References: <34A8108658DCCE4B8595675ABFD8172709FAFE@dusse201.eu.infineon.com> <4173BD42.9050009@gentoo.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4173BD42.9050009@gentoo.org>
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Stephen P. Becker wrote:
> Andre.Messerschmidt@infineon.com wrote:
> >Hi,
> >
> >I am trying to compile Mozilla Firefox 1.0PR with Montavista Pro 3.1 
> >toolchain (I linked mips_fp_be to mips-linux), but I get the following 
> >error messages:
[snip]
> https://bugzilla.mozilla.org/show_bug.cgi?id=71627
> 
> The patch there will fix the compile, but the resulting binary probably 
> won't run.

This patch is broken and will only paper over the problem. Use the
patch in https://bugzilla.mozilla.org/show_bug.cgi?id=258429
At least the firefox 0.93 in Debian mips works with it.


Thiemo
