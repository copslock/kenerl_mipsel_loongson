Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Nov 2002 20:45:46 +0100 (CET)
Received: from p508B502B.dip.t-dialin.net ([80.139.80.43]:52633 "EHLO
	p508B502B.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S1122117AbSKITpp>; Sat, 9 Nov 2002 20:45:45 +0100
Received: (ralf@3ffe:8260:2020:2::20) by ralf.linux-mips.org
	id <S868139AbSKITmN>; Sat, 9 Nov 2002 20:42:13 +0100
Date: Sat, 9 Nov 2002 20:42:13 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Kip Walker <kwalker@broadcom.com>
Cc: linux-mips@linux-mips.org
Subject: Re: 64-bit little endian semaphore bug
Message-ID: <20021109204213.A13826@bacchus.dhis.org>
References: <3DCC4AC2.EC7BD4E1@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DCC4AC2.EC7BD4E1@broadcom.com>; from kwalker@broadcom.com on Fri, Nov 08, 2002 at 03:37:38PM -0800
X-Accept-Language: de,en,fr
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 08, 2002 at 03:37:38PM -0800, Kip Walker wrote:

> In the 64-bit kernel, the semaphore structure (like the 32-bit kernel)
> has waking and count fields swizzled so they line up the same in a
> 64-bit double word for either endian.  However, the semaphore-helper.h
> function waking_non_zero_interruptible still has specialized code for
> little-endian manipulation of the fields as though they are swapped.
> 
> Patch is attached, and fixes a pipe deadlock I was seeing (both the
> reader and writer were down'ing the semaphore).
> 
> patch is against 2.5, but should be clean against 2.4 also.

Patch is ok.  I tweaked it slightly to make the 2.4 and 2.5 versions
identical.

General request to everybody - cc me on all patches that you wish to
submit even if you're posting them to some list.

  Ralf
