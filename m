Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jan 2005 05:04:40 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:41220 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224788AbVASFEe>; Wed, 19 Jan 2005 05:04:34 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 6CB7BE1D10; Wed, 19 Jan 2005 06:04:32 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 08058-02; Wed, 19 Jan 2005 06:04:32 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 3FBA9E1CB9; Wed, 19 Jan 2005 06:04:32 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j0J54VTX002641;
	Wed, 19 Jan 2005 06:04:32 +0100
Date: Wed, 19 Jan 2005 05:04:32 +0000 (GMT)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050119134211.2c0e24f5.yuasa@hh.iij4u.or.jp>
Message-ID: <Pine.LNX.4.61L.0501190502070.26851@blysk.ds.pg.gda.pl>
References: <20050115013112Z8225557-1340+1316@linux-mips.org>
 <20050119134211.2c0e24f5.yuasa@hh.iij4u.or.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.80/661/Tue Jan 11 02:44:13 2005
	clamav-milter version 0.80j
	on piorun.ds.pg.gda.pl
X-Virus-Status: Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 19 Jan 2005, Yoichi Yuasa wrote:

> arch/mips/vr41xx/common/giu.c and icu.c need <linux/config.h>
> I,m going to update 2 files soon.

 Neither of these uses any CONFIG_* macros.

  Maciej
