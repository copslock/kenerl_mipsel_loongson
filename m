Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 14:46:57 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:64210
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225230AbUK2Oqu>; Mon, 29 Nov 2004 14:46:50 +0000
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id DA50F2BC3F; Mon, 29 Nov 2004 15:46:48 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 04294-20; Mon, 29 Nov 2004 15:46:41 +0100 (CET)
Received: from bogon.sigxcpu.org (xdsl-195-14-221-250.netcologne.de [195.14.221.250])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 1C8742BC3C; Mon, 29 Nov 2004 15:46:41 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 2A2844682; Mon, 29 Nov 2004 15:41:49 +0100 (CET)
Date: Mon, 29 Nov 2004 15:41:49 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: linux-mips@linux-mips.org
Subject: Re: PATCH: arcboot cache
Message-ID: <20041129144149.GB11653@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@linux-mips.org
References: <20041123064011.GA17752@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041123064011.GA17752@foobazco.org>
User-Agent: Mutt/1.5.6i
X-Virus-Scanned: by amavisd-new-20030616-p7 (Debian) at honk.physik.uni-konstanz.de
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6485
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 22, 2004 at 10:40:12PM -0800, Keith M Wesolowski wrote:
> Let's make arcboot 20x faster, shall we?  Tested on ip22, ip32.
Very cool. Unfortunately I intended to rip out libext2fs anytime soon,
anyways I'll apply the patch until then.
 -- Guido
