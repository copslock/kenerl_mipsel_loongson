Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 15:10:22 +0100 (BST)
Received: from p508B7731.dip.t-dialin.net ([IPv6:::ffff:80.139.119.49]:63 "EHLO
	mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224942AbUJFOKR>; Wed, 6 Oct 2004 15:10:17 +0100
Received: from fluff.linux-mips.net (fluff.linux-mips.net [127.0.0.1])
	by mail.linux-mips.net (8.12.11/8.12.8) with ESMTP id i96EADGQ010731;
	Wed, 6 Oct 2004 16:10:13 +0200
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.12.11/8.12.11/Submit) id i96EAAFo010727;
	Wed, 6 Oct 2004 16:10:10 +0200
Date: Wed, 6 Oct 2004 16:10:10 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: priya.mani@wipro.com
Cc: linux-mips@linux-mips.org
Subject: Re: __up, __down_trylock & __down_interruptible for MIPS
Message-ID: <20041006141010.GB10024@linux-mips.org>
References: <6BF015B686198842A1C8F84F4B7E6D2601276A0F@chn-snr-msg.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6BF015B686198842A1C8F84F4B7E6D2601276A0F@chn-snr-msg.wipro.com>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 06, 2004 at 04:55:10PM +0530, priya.mani@wipro.com wrote:

> If I try to use the functions from the latest CVS files in the mips-org
> site it gives other compilation errors.
> 
> Please can you tell me how do I go about this problem. Have the above
> functions been obsoleted? Is there any patch available for them? Or is
> there any doc explaining this? I am using Kernel version 2.4.22.

This was working in 2.4.22 so it seems you're using a broken tree.  Where
did you get it from?

  Ralf
