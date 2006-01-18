Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Jan 2006 14:10:16 +0000 (GMT)
Received: from lennier.cc.vt.edu ([198.82.162.213]:17616 "EHLO
	lennier.cc.vt.edu") by ftp.linux-mips.org with ESMTP
	id S8133618AbWAROJ5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 18 Jan 2006 14:09:57 +0000
Received: from dagger.cc.vt.edu (IDENT:mirapoint@evil-dagger.cc.vt.edu [10.1.1.11])
	by lennier.cc.vt.edu (8.12.11/8.12.11) with ESMTP id k0IECfWn000487;
	Wed, 18 Jan 2006 09:12:41 -0500
Received: from [128.173.184.73] (gs4073.geos.vt.edu [128.173.184.73])
	by dagger.cc.vt.edu (MOS 3.6.4-CR)
	with ESMTP id FAU86636;
	Wed, 18 Jan 2006 09:12:39 -0500 (EST)
Message-ID: <43CE4CCB.9050605@gentoo.org>
Date:	Wed, 18 Jan 2006 09:12:27 -0500
From:	"Stephen P. Becker" <geoman@gentoo.org>
User-Agent: Mail/News 1.5 (X11/20060116)
MIME-Version: 1.0
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
CC:	Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
Subject: Re: CONFIG_64BIT and CONFIG_BUILD_ELF64
References: <20060118123110.GA21786@deprecation.cyrius.com> <Pine.LNX.4.64N.0601181240090.18424@blysk.ds.pg.gda.pl>
In-Reply-To: <Pine.LNX.4.64N.0601181240090.18424@blysk.ds.pg.gda.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <geoman@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9966
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geoman@gentoo.org
Precedence: bulk
X-list: linux-mips

Maciej W. Rozycki wrote:
> On Wed, 18 Jan 2006, Martin Michlmayr wrote:
> 
>> Is there a good reason why CONFIG_64BIT does not activate
>> CONFIG_BUILD_ELF64 automatically?
> 
>  It works with some old toolchains and apparently there are people who 
> want this feature.  Please feel free to propose a patch to add such a 
> dependency and see if there are any objections.
> 

Interesting this was brought up today, as Kumba and I were having a 
little discussion concerning this yesterday.  The thing is that for 
certain machines such as ip22 and ip32, booting a ELF64 kernel is 
problematic, so people have to make sure they use the vmlinux.32 target.

-Steve
