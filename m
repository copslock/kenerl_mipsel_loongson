Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Dec 2003 22:27:14 +0000 (GMT)
Received: from mail.jlokier.co.uk ([IPv6:::ffff:81.29.64.88]:60547 "EHLO
	mail.shareable.org") by linux-mips.org with ESMTP
	id <S8225439AbTLMW1L>; Sat, 13 Dec 2003 22:27:11 +0000
Received: from mail.shareable.org (localhost [127.0.0.1])
	by mail.shareable.org (8.12.8/8.12.8) with ESMTP id hBDMQQcT020351;
	Sat, 13 Dec 2003 22:26:26 GMT
Received: (from jamie@localhost)
	by mail.shareable.org (8.12.8/8.12.8/Submit) id hBDMQQmH020349;
	Sat, 13 Dec 2003 22:26:26 GMT
Date: Sat, 13 Dec 2003 22:26:26 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Peter Horton <pdh@colonel-panic.org>
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: Possible shared mapping bug in 2.4.23 (at least MIPS/Sparc)
Message-ID: <20031213222626.GA20153@mail.shareable.org>
References: <20031213114134.GA9896@skeleton-jack>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213114134.GA9896@skeleton-jack>
User-Agent: Mutt/1.4.1i
Return-Path: <jamie@shareable.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamie@shareable.org
Precedence: bulk
X-list: linux-mips

Peter Horton wrote:
> A quick look at sparc and sparc64 seem to show the same problem.

D-cache incoherence with unsuitably aligned multiple MAP_FIXED
mappings is also observed on SH4, SH5, PA-RISC 1.1d.  The kernel may
have the same behaviour on those platforms: allowing a mapping that
should not be allowed.

On some ARM and m68k boxes, incoherence is observed independent of
alignment, for multiple mappings of a page in the same user memory
space.

-- Jamie
