Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2HFlUs28067
	for linux-mips-outgoing; Sat, 17 Mar 2001 07:47:30 -0800
Received: from boco.fee.vutbr.cz (boco.fee.vutbr.cz [147.229.9.11])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2HFlTM28064
	for <linux-mips@oss.sgi.com>; Sat, 17 Mar 2001 07:47:29 -0800
Received: from fest.stud.fee.vutbr.cz (fest.stud.fee.vutbr.cz [147.229.9.16])
	by boco.fee.vutbr.cz (8.11.3/8.11.3) with ESMTP id f2HFlQt47888
	(using TLSv1/SSLv3 with cipher EDH-RSA-DES-CBC3-SHA (168 bits) verified OK);
	Sat, 17 Mar 2001 16:47:27 +0100 (CET)
Received: (from xjezda00@localhost)
	by fest.stud.fee.vutbr.cz (8.11.2/8.11.2) id f2HFlQF86608;
	Sat, 17 Mar 2001 16:47:26 +0100 (CET)
Date: Sat, 17 Mar 2001 16:47:26 +0100
From: David Jez <dave.jez@seznam.cz>
To: Karel van Houten <K.H.C.vanHouten@kpn.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: rpm crashing on RH 7.0 indy
Message-ID: <20010317164726.B86495@stud.fee.vutbr.cz>
References: <200103171051.LAA04852@pandora.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200103171051.LAA04852@pandora.research.kpn.com>; from K.H.C.vanHouten@kpn.com on Sat, Mar 17, 2001 at 11:51:19AM +0100
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Sat, Mar 17, 2001 at 11:51:19AM +0100, Karel van Houten wrote:
> Hi all,
> 
> I hope someone can help me with this problem...
> 
> I've installed an Indy with Ralfs Redhat/test-7.0 packages.
> Most things work OK, but rpm itself crashes when installing
> a package. Here is a trace of what happens:
> 
> This is a static rpm binary, so I don't understand why it tries
> do dynaload anything at all...
  Hi,

Ooops, i think: haven't you got broken rpm? Have you downloaded the rpm
complete? Try checksum or md5.

> 
> Thanks in advance,
> -- 
> Karel van Houten
Hope you will be succeded,
Dave
-- 
-------------------------------------------------------
  David "Dave" Jez                Brno, CZ, Europe
 E-mail: dave.jez@seznam.cz
PGP key: finger xjezda00@fest.stud.fee.vutbr.cz
---------=[ ~EOF ]=------------------------------------
