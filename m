Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Apr 2003 02:25:41 +0100 (BST)
Received: from p508B52B7.dip.t-dialin.net ([IPv6:::ffff:80.139.82.183]:2705
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225205AbTDJBZk>; Thu, 10 Apr 2003 02:25:40 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h3A1PUn03299;
	Thu, 10 Apr 2003 03:25:30 +0200
Date: Thu, 10 Apr 2003 03:25:29 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Michael Anburaj <michaelanburaj@hotmail.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Message-ID: <20030410032529.A1493@linux-mips.org>
References: <BAY1-F817dKwKkLxFjj00070900@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <BAY1-F817dKwKkLxFjj00070900@hotmail.com>; from michaelanburaj@hotmail.com on Wed, Apr 09, 2003 at 02:32:03PM -0700
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1964
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Apr 09, 2003 at 02:32:03PM -0700, Michael Anburaj wrote:

> I am new to Linux. But I have a strong ARM & MIPS background with kernel 
> porting & other stuff.
> 
> I want to get a higher-level view of the essential components of Linux for 
> MIPS & documentation about the kernel. Please point me to documents on the 
> net.

I suggest http://www.linux-mips.org to get started.

> Question 2:
> Does Linux-MIPS support the MIPS Atlas board with 4Kc processor using 
> mipsisa32-elf build tool chain (Contain the appropriate HAL or BSP)? Is so, 
> please point me to documents that gives the exact build steps for the same.

No.  You must use a Linux configuration of the tools, that's mips-linux.

> Also do let me know if Cygwin over Win98 dev. environment is good for 
> building & developing with Linux-MIPS or do I need to have Linux installed 
> on my dev. machine?

I've never use Cygwin myself.  The reports I've received are a mixed bag
ranging from extremly bad to very good.

  Ralf
