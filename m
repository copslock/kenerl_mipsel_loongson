Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2003 00:48:36 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:42126
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225195AbTCXAsf>; Mon, 24 Mar 2003 00:48:35 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 2EEF12BC31; Mon, 24 Mar 2003 01:48:33 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 23156-02;
 Mon, 24 Mar 2003 01:48:32 +0100 (CET)
Received: from bogon.sigxcpu.org (kons-d9bb5426.pool.mediaWays.net [217.187.84.38])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 2AC272BC2D; Mon, 24 Mar 2003 01:48:32 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 17CC51735C; Mon, 24 Mar 2003 01:46:15 +0100 (CET)
Date: Mon, 24 Mar 2003 01:46:14 +0100
From: Guido Guenther <agx@debian.org>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org, vivien.chappelier@linux-mips.org
Subject: Re: [PATCH 2.5]: IP32 enable power button
Message-ID: <20030324004614.GH26796@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@debian.org>,
	ralf@linux-mips.org, linux-mips@linux-mips.org,
	vivien.chappelier@linux-mips.org
References: <20030323184317.GE26796@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030323184317.GE26796@bogon.ms20.nix>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1795
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@debian.org
Precedence: bulk
X-list: linux-mips

On Sun, Mar 23, 2003 at 07:43:17PM +0100, Guido Guenther wrote:
> the attached patch enables the power button on IP32 and adds definitions
> for the extra registers of the ds1728[57]. Please apply.
Hmm...the patch that worked without problems all over the day now
refuses to shut of the machine. I'll have to look into that and post a
fixed version when I know whats wrong.
Regards,
 -- Guido
