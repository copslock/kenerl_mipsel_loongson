Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Mar 2003 00:52:07 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:30639
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225199AbTCMAwF>; Thu, 13 Mar 2003 00:52:05 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp (Exim 3.36 #2)
	id 18tGx1-001qpe-00; Thu, 13 Mar 2003 01:52:03 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 18tGx1-00022v-00; Thu, 13 Mar 2003 01:52:03 +0100
Date: Thu, 13 Mar 2003 01:52:03 +0100
To: Ralf Baechle <ralf@linux-mips.org>
Cc: Ranjan Parthasarathy <ranjanp@efi.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Disabling lwl and lwr instruction generation
Message-ID: <20030313005203.GH13122@rembrandt.csv.ica.uni-stuttgart.de>
References: <D9F6B9DABA4CAE4B92850252C52383AB0796823C@ex-eng-corp.efi.com> <20030313014338.C29568@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030313014338.C29568@linux-mips.org>
User-Agent: Mutt/1.4i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Mar 12, 2003 at 10:05:20AM -0800, Ranjan Parthasarathy wrote:
> 
> > Is there a way to tell gcc to not generate the lwl, lwr instructions?
> 
> Gcc will only ever generate these instructions when __attribute__((unaligned))
> is used.

Which might be not that obvious, e.g. __attribute__((packed)) can cause such
instructions, too.


Thiemo
