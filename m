Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Nov 2004 08:37:43 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:47839
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225257AbUK3Ihi>; Tue, 30 Nov 2004 08:37:38 +0000
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 3303E2BC3F; Tue, 30 Nov 2004 09:37:37 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 12270-21; Tue, 30 Nov 2004 09:37:29 +0100 (CET)
Received: from bogon.sigxcpu.org (unknown [62.157.100.134])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id C3E9F2BC3C; Tue, 30 Nov 2004 09:37:29 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 2A7DC4683; Tue, 30 Nov 2004 09:36:13 +0100 (CET)
Date: Tue, 30 Nov 2004 09:36:12 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Keith M Wesolowski <wesolows@foobazco.org>,
	linux-mips@linux-mips.org
Subject: Re: PATCH: arcboot cache
Message-ID: <20041130083612.GB8225@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@linux-mips.org
References: <20041123064011.GA17752@foobazco.org> <20041129144149.GB11653@bogon.ms20.nix> <20041129172129.GQ6804@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041129172129.GQ6804@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at honk.physik.uni-konstanz.de
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 29, 2004 at 06:21:29PM +0100, Thiemo Seufer wrote:
> Guido Guenther wrote:
> > On Mon, Nov 22, 2004 at 10:40:12PM -0800, Keith M Wesolowski wrote:
> > > Let's make arcboot 20x faster, shall we?  Tested on ip22, ip32.
> > Very cool. Unfortunately I intended to rip out libext2fs anytime soon,
> 
> What so you want to use instead?
The one shipped with debian like delo.
 -- Guido
