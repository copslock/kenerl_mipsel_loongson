Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Nov 2002 02:48:54 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([134.34.144.71]:3332 "EHLO
	honk1.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S1123952AbSKVBsy>; Fri, 22 Nov 2002 02:48:54 +0100
Received: from bogon.sigxcpu.org (unknown [134.34.147.122])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP
	id 6DCF011E10; Fri, 22 Nov 2002 02:48:47 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id 9CA574AC90; Fri, 22 Nov 2002 02:45:38 +0100 (CET)
Date: Fri, 22 Nov 2002 02:45:38 +0100
From: Guido Guenther <agx@sigxcpu.org>
To: David Hansen <hansen@phys.ufl.edu>
Cc: linux-mips@linux-mips.org
Subject: Re: Origin 2000 installation
Message-ID: <20021122014538.GL8360@bogon.ms20.nix>
References: <20021121184119.A29975@linux-mips.org> <Pine.SOL.4.44.0211211254390.11471-100000@neptune.phys.ufl.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.SOL.4.44.0211211254390.11471-100000@neptune.phys.ufl.edu>
User-Agent: Mutt/1.4i
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 695
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips

On Thu, Nov 21, 2002 at 01:00:09PM -0500, David Hansen wrote:
> On Thu, 21 Nov 2002, Ralf Baechle wrote:
> > The Debian installer support Indys only so a bit of creativity will be
> > required to get it to work, I fear.  At least Debian doesn't ship with
> > Origin kernel images.
> 
>  Is there a preferred distribution/method for Origin installations?
You can fetch the debian nfs-root from:
 http://ftp.debian.org/debian/dists/woody/main/disks-mips/3.0.23-2002-05-21/root.tar.gz
This and an Origin200 kernel should do the trick. I'd be nice to add
Origin support to the debian installer though.
 -- Guido
