Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jan 2006 15:53:57 +0000 (GMT)
Received: from fw-ca-1-hme0.vitesse.com ([64.215.88.90]:36670 "EHLO
	email.vitesse.com") by ftp.linux-mips.org with ESMTP
	id S3465572AbWAWPxg (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Jan 2006 15:53:36 +0000
Received: from wilson.vitesse.com (wilson [192.9.212.7])
	by email.vitesse.com (8.11.0/8.11.0) with ESMTP id k0NFvgh19376;
	Mon, 23 Jan 2006 07:57:42 -0800 (PST)
Received: from MX-COS.vsc.vitesse.com (mx-cs1 [192.9.212.67])
	by wilson.vitesse.com (8.11.6/8.11.6) with ESMTP id k0NFvfX29873;
	Mon, 23 Jan 2006 08:57:41 -0700 (MST)
Received: MX-COS 192.9.212.98 from 192.9.211.152 192.9.211.152 via HTTP with MS-WebStorage 6.0.6249
Received: from lx-kurts.vitesse.com by MX-COS; 23 Jan 2006 08:57:10 -0700
Subject: Re: Build errors
From:	Kurt Schwemmer <kurts@vitesse.com>
To:	Nigel Stephens <nigel@mips.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
	sde@mips.com
In-Reply-To: <43D4F1E0.1050602@mips.com>
References: <1137793865.15788.26.camel@lx-kurts>
	 <20060122030341.GB11131@linux-mips.org>  <43D4F1E0.1050602@mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Mon, 23 Jan 2006 08:57:09 -0700
Message-Id: <1138031829.6572.2.camel@lx-kurts>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Return-Path: <kurts@vitesse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kurts@vitesse.com
Precedence: bulk
X-list: linux-mips

On Mon, 2006-01-23 at 15:10 +0000, Nigel Stephens wrote:
> I recommend that you download the latest version of SDE (6.03.01)
> which fixes this, from
> ftp://ftp.mips.com/pub/tools/software/sde-for-linux/v6.03.01-1/mipsel-sdelinux-v6.03.01-1.i386.rpm
> 
> Nigel

Great! It builds now, albeit with warnings:

arch/mips/lib/uncached.c: In function `run_uncached':
arch/mips/lib/uncached.c:47: warning: comparison is always true due to
limited range of data type

Is that normal?

Anyway, is there a particular person who maintains the wiki
( http://www.linux-mips.org/wiki/MIPS_SDE_Installation ) or should I
give it a shot? 

Thanks!,
Kurt Schwemmer
