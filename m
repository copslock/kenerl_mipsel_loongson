Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 May 2009 13:17:17 +0100 (BST)
Received: from smtp21.services.sfr.fr ([93.17.128.4]:63536 "EHLO
	smtp21.services.sfr.fr" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S20024549AbZESMRK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 May 2009 13:17:10 +0100
Received: from filter.sfr.fr (localhost [127.0.0.1])
	by msfrf2117.sfr.fr (SMTP Server) with ESMTP id B16887000095;
	Tue, 19 May 2009 14:17:03 +0200 (CEST)
Received: from [192.168.1.101] (152.174.71-86.rev.gaoland.net [86.71.174.152])
	by msfrf2117.sfr.fr (SMTP Server) with ESMTP id 3C0D57000094;
	Tue, 19 May 2009 14:17:03 +0200 (CEST)
X-SFR-UUID: 20090519121703246.3C0D57000094@msfrf2117.sfr.fr
Subject: Re: Bigsur?
From:	Laurent GUERBY <laurent@guerby.net>
To:	Jon Fraser <jfraser@broadcom.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Andrew Wiley <debio264@gmail.com>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"Maciej W. Rozycki" <macro@linux-mips.org>
In-Reply-To: <alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org>
References: <ecbbfeda0905152014t62281c79k2001e428da65a442@mail.gmail.com>
	 <1242663215.18301.26.camel@chaos.ne.broadcom.com>
	 <20090518222334.GD16847@linux-mips.org>
	 <alpine.LFD.1.10.0905182335510.20791@ftp.linux-mips.org>
Content-Type: text/plain
Date:	Tue, 19 May 2009 14:17:20 +0200
Message-Id: <1242735440.6098.101.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.26.1 
Content-Transfer-Encoding: 7bit
Return-Path: <laurent@guerby.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22815
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: laurent@guerby.net
Precedence: bulk
X-list: linux-mips

On Mon, 2009-05-18 at 23:47 +0100, Maciej W. Rozycki wrote:
>  Yes, invaluable for native builds and there is a considerable number of 
> software packages which is not capable of being cross-compiled, or 
> requires extreme contortions to be built this way, or if buildable with a 
> reasonable effort, the functionality is limited.  Besides a three-stage 
> GCC bootstrap is a good way of verifying the quality of the tool, never 
> mind standard DejaGNU-based regression testing which although possible 
> using cross-tools and a remote target, is awfully painful to be set up 
> this way.

For MIPS in the GCC Compile Farm http://gcc.gnu.org/wiki/CompileFarm
(which is open to all free software, not limited to GCC) we
have two loongson-2f based netbooks on which a GCC bootstrap
and check is manageable.

Right now this farm is more oriented towards upstream userland
developpers debug/test cycles - they get access to 12 architectures when
they sign in. It's not really oriented towards porting
kernel/distributions or building distribution packages which is already
well covered by existing distribution farms and individual developpers
and those developpers should get priority on new hardware :).

This farm project is part of the Free Software Fundation France (a
french not-for-profit organization) effort to help free software
development and we accept hardware and hosting donations, and also
discounts to purchase commercial hardware when donations are not
possible and there is significant interest in one platform.

Sincerely,

Laurent
