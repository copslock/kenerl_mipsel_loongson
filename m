Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Feb 2003 10:51:37 +0000 (GMT)
Received: from p508B66FD.dip.t-dialin.net ([IPv6:::ffff:80.139.102.253]:26085
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225192AbTBFKvg>; Thu, 6 Feb 2003 10:51:36 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h16ApU803231;
	Thu, 6 Feb 2003 11:51:30 +0100
Date: Thu, 6 Feb 2003 11:51:30 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Chien-Lung Wu <cwu@deltartp.com>
Cc: "'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: Software floating point
Message-ID: <20030206115130.A27384@linux-mips.org>
References: <A4E787A2467EF849B00585F14C9005590689DA@dprn03.deltartp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <A4E787A2467EF849B00585F14C9005590689DA@dprn03.deltartp.com>; from cwu@deltartp.com on Wed, Feb 05, 2003 at 06:21:34PM -0500
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1350
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 05, 2003 at 06:21:34PM -0500, Chien-Lung Wu wrote:

> I am building a cross-compiler for mips-linux on my linux box.  
> Everything seems fine,  except software floating point. 
> How can I turn on the software floating point when I build the glibc? 
> Is software floating point are supported in libm.a/libm.so or ant other
> lib*?

The kernel includes a floating point emulator so your hard fp code will
run fine on fpu-less code.

  Ralf
