Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jan 2004 16:47:31 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:10573
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225437AbUATQra>; Tue, 20 Jan 2004 16:47:30 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1Aiz2E-0006Ev-00; Tue, 20 Jan 2004 17:47:26 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1Aiz2E-0000qz-00; Tue, 20 Jan 2004 17:47:26 +0100
Date: Tue, 20 Jan 2004 17:47:26 +0100
To: Goswin von Brederlow <brederlo@informatik.uni-tuebingen.de>
Cc: Guido Guenther <agx@debian.org>, linux-mips@linux-mips.org,
	debian-mips@lists.debian.org
Subject: Re: Need .config files for Debians kernel-image-2.4.24-mips(el)
Message-ID: <20040120164726.GA22218@rembrandt.csv.ica.uni-stuttgart.de>
References: <878yk21z7p.fsf@mrvn.homelinux.org> <20040120144212.GA7046@bogon.ms20.nix> <874quq1tdg.fsf@mrvn.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874quq1tdg.fsf@mrvn.homelinux.org>
User-Agent: Mutt/1.5.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Goswin von Brederlow wrote:
[snip]
> While working on the upgrade I came across some questions:
> 
> Is the kernel-patch-2.4.22-mips relative to the debian kernel source
> or the vanilla source?

It'S relative to the debian kernel source package.

> And is the result (after patching) the mips cvs
> or cvs merged with the debian patch? And should that be done that way
> again?

AFAIK mips cvs plus (usually generic) debian fixes.

[snip]
> Have you thought about dropping the udebs and letting debian-installer
> build -di udebs the way it does for several other arches now?

The decstations still use the -udeb flavour.


Thiemo
