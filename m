Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Feb 2003 12:26:47 +0000 (GMT)
Received: from p508B76F7.dip.t-dialin.net ([IPv6:::ffff:80.139.118.247]:16041
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224939AbTBCM0q>; Mon, 3 Feb 2003 12:26:46 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h13CQY021345;
	Mon, 3 Feb 2003 13:26:34 +0100
Date: Mon, 3 Feb 2003 13:26:34 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Nemanja Popov <Nemanja.Popov@micronasnit.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Lexra' s MMU
Message-ID: <20030203132634.C18186@linux-mips.org>
References: <001701c2cb62$3eccd500$e000a8c0@micronasnit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <001701c2cb62$3eccd500$e000a8c0@micronasnit.com>; from Nemanja.Popov@micronasnit.com on Mon, Feb 03, 2003 at 09:57:02AM +0100
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1296
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 03, 2003 at 09:57:02AM +0100, Nemanja Popov wrote:

>   Does Lexra's CPU LX4280 has MMU. I've found from dateaheet LX4280 that
> there is only SMMU (S stands for Simple) which does not include TLB and
> exceptions related to that.
>   I've noticed port for lexra (among others also for LX4280) on cvs. Is it
> possible to run linux on that kind of processor, and if so will it manage
> user space application as it should  with mmu.

TLB-less processors aren't supported at all by Linux 2.4.  Linux 2.5 has
the infrastructure in place to support TLB-less processors but we don't
support that on MIPS.  I guess it's probably not interesting because
TLB-less CPUs tend to be part of systems that are too resource constrained
to be of interest for use with Linux but I certainly wouldn't refuse such
patches.

The CVS kernel does not support Lexra processors.  There are a bit over one
year old Lexra patches for 2.4.  Me and the author agreed to not merge those
patches into the CVS kernel because Lexra is a dead company.

  Ralf
