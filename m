Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Apr 2004 18:56:23 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:33789 "EHLO
	orion.mvista.com") by linux-mips.org with ESMTP id <S8224769AbUDER4W>;
	Mon, 5 Apr 2004 18:56:22 +0100
Received: from orion.mvista.com (localhost.localdomain [127.0.0.1])
	by orion.mvista.com (8.12.8/8.12.8) with ESMTP id i35Htux6013502;
	Mon, 5 Apr 2004 10:55:56 -0700
Received: (from jsun@localhost)
	by orion.mvista.com (8.12.8/8.12.8/Submit) id i35HtZYv013500;
	Mon, 5 Apr 2004 10:55:35 -0700
Date: Mon, 5 Apr 2004 10:55:35 -0700
From: Jun Sun <jsun@mvista.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org,
	jsun@mvista.com
Subject: Re: [patch] swarm-cs4297a: Support little-endian configuration
Message-ID: <20040405105535.D13322@mvista.com>
References: <Pine.LNX.4.55.0404051236290.31851@jurand.ds.pg.gda.pl> <20040405125436.GA2741@deprecation.cyrius.com> <Pine.LNX.4.55.0404051457010.31851@jurand.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.55.0404051457010.31851@jurand.ds.pg.gda.pl>; from macro@ds2.pg.gda.pl on Mon, Apr 05, 2004 at 03:01:19PM +0200
Return-Path: <jsun@orion.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4735
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsun@mvista.com
Precedence: bulk
X-list: linux-mips

On Mon, Apr 05, 2004 at 03:01:19PM +0200, Maciej W. Rozycki wrote:
> On Mon, 5 Apr 2004, Martin Michlmayr wrote:
> 
> > Are you using their boot loader (sibyl), and did you notice it has
> > problems in little-endian?  (IF so, do you have patches?  ;-)  Also,
> > have you been able to compile sibyl against a normal e2fslibs rather
> > than their custom version?
> 
>  I boot kernels directly (a bit dissatisfied with no ELF64 support in CFE,
> but that can be fixed, I suppose) over the network, so I can't help you
> with your problems, sorry.
>

I have been using objcopy to convert ELF64 to ELF32 and then boot through 
CFE (suggested by Drow).  This seems to be working fine.

I have also used a LE version sibyl before and did not notice any problem.
I think that version is a binary from broadcom.

Jun
