Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Mar 2003 13:46:45 +0000 (GMT)
Received: from p508B4B98.dip.t-dialin.net ([IPv6:::ffff:80.139.75.152]:33756
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTCINqo>; Sun, 9 Mar 2003 13:46:44 +0000
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h29DkQ627754;
	Sun, 9 Mar 2003 14:46:26 +0100
Date: Sun, 9 Mar 2003 14:46:26 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Tinga Shilo <tingashilo@yahoo.com>
Cc: linux-mips@linux-mips.org
Subject: Re: static variables access and gp
Message-ID: <20030309144625.A27651@linux-mips.org>
References: <20030306073017.65521.qmail@web41509.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030306073017.65521.qmail@web41509.mail.yahoo.com>; from tingashilo@yahoo.com on Wed, Mar 05, 2003 at 11:30:17PM -0800
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Mar 05, 2003 at 11:30:17PM -0800, Tinga Shilo wrote:

> I am implementing a kernel mechanism which is 
> very performance oriented. Along my long critical
> path,
> there is a static variable that needs to be accessed
> quite a few times. This variable is a structure which
> is approximately 60 bytes big.
> In there any way I can "convince" my kernel (compiled
> with gcc) to access this variable using gp ?
> Is gp usually used for this purpose in mips-linux ?
> Can it be ?
> 
> A while ago I saw a small discussion here about usage
> of gp for static variables, but it didn't provide
> any definite answers.

Use a pointer to the that structure.  Gcc will keep this pointer in a
registers wherever it considers that sensible.  Any reference to members
of the structure can then be made with just a single instruction.

$28 is used for the current pointer so only suitable for per-process
data.

  Ralf
