Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2004 14:36:24 +0000 (GMT)
Received: from holomorphy.com ([IPv6:::ffff:199.26.172.102]:24994 "EHLO
	holomorphy.com") by linux-mips.org with ESMTP id <S8225210AbUBHOgX>;
	Sun, 8 Feb 2004 14:36:23 +0000
Received: from wli by holomorphy.com with local (Exim 3.36 #1 (Debian))
	id 1Apq2j-0007Tc-00; Sun, 08 Feb 2004 06:36:17 -0800
Date: Sun, 8 Feb 2004 06:36:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-mips@linux-mips.org
Cc: linux-cvs@linux-mips.org
Subject: Re: CVS Update@-mips.org: linux
Message-ID: <20040208143617.GC699@holomorphy.com>
References: <20040208143438Z8224987-9616+1909@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040208143438Z8224987-9616+1909@linux-mips.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.5.1+cvs20040105i
Return-Path: <wli@holomorphy.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4312
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wli@holomorphy.com
Precedence: bulk
X-list: linux-mips

On Sun, Feb 08, 2004 at 02:34:34PM +0000, hch@linux-mips.org wrote:
> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	hch@ftp.linux-mips.org	04/02/08 14:34:34
> Modified files:
> 	include/asm-mips: mmzone.h 
> Log message:
> 	Use the defintion of kern_addr_valid() from Linus tree instead of my variant.
> 	This allows blaming wli for this POS instead of me ;)

Hey! That bitmap was uninitialized (apart from being zeroed) in mainline.


-- wli
