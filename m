Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Mar 2003 01:27:58 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:469
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225203AbTCSB15>; Wed, 19 Mar 2003 01:27:57 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id F41B42BC30; Wed, 19 Mar 2003 02:27:55 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 25766-07;
 Wed, 19 Mar 2003 02:27:55 +0100 (CET)
Received: from bogon.sigxcpu.org (kons-d9bb543c.pool.mediaWays.net [217.187.84.60])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 102602BC2F; Wed, 19 Mar 2003 02:27:55 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 801331735C; Wed, 19 Mar 2003 02:25:40 +0100 (CET)
Date: Wed, 19 Mar 2003 02:25:40 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: linux-mips@linux-mips.org
Subject: Re: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030319012540.GF19990@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	linux-mips@linux-mips.org
References: <20030318154155.GF2613@bogon.ms20.nix> <20030318160303.GN13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318174241.GG2613@bogon.ms20.nix> <20030318190841.GO13122@rembrandt.csv.ica.uni-stuttgart.de> <20030318232454.GA19990@bogon.ms20.nix> <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030319001652.GB19189@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 19, 2003 at 01:16:52AM +0100, Thiemo Seufer wrote:
> Yes, this should work. You can leave the -mtune out, since it defaults
> to the value of -march anyway.
Thanks.
 -- Guido
