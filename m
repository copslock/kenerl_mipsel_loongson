Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2003 15:44:15 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([IPv6:::ffff:134.34.140.224]:17359
	"EHLO honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225203AbTCRPoO>; Tue, 18 Mar 2003 15:44:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id CC67E2BC30
	for <linux-mips@linux-mips.org>; Tue, 18 Mar 2003 16:44:09 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
 by localhost (honk [127.0.0.1:10024]) (amavisd-new) with ESMTP id 23196-04
 for <linux-mips@linux-mips.org>; Tue, 18 Mar 2003 16:44:08 +0100 (CET)
Received: from bogon.sigxcpu.org (kons-d9bb543c.pool.mediaWays.net [217.187.84.60])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 001E42BC2F
	for <linux-mips@linux-mips.org>; Tue, 18 Mar 2003 16:44:07 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 52AFC1735C; Tue, 18 Mar 2003 16:41:56 +0100 (CET)
Date: Tue, 18 Mar 2003 16:41:56 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: linux-mips@linux-mips.org
Subject: -mcpu vs. binutils 2.13.90.0.18
Message-ID: <20030318154155.GF2613@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	linux-mips@linux-mips.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

Hi,
it seems newer binutils doen't know about -mcpu anymore. Is it correct
to simply change:
 -mcpu=r5000 -mips2 -Wa,--trap
to
 -mtune=r5000 -mips2 -Wa,--trap
for IP22? -mips2 conflicts with -march=r5000 since this implies -mips4.
Regards,
 -- Guido
