Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jun 2004 04:16:52 +0100 (BST)
Received: from eth13.com-link.com ([IPv6:::ffff:208.242.241.164]:65446 "EHLO
	real.realitydiluted.com") by linux-mips.org with ESMTP
	id <S8224773AbUFADQs>; Tue, 1 Jun 2004 04:16:48 +0100
Received: from localhost ([127.0.0.1] helo=realitydiluted.com)
	by real.realitydiluted.com with esmtp (Exim 3.36 #1 (Debian))
	id 1BUzlS-0005BN-00; Mon, 31 May 2004 22:16:34 -0500
Message-ID: <40BBF555.6000600@realitydiluted.com>
Date: Mon, 31 May 2004 22:17:41 -0500
From: "Steven J. Hill" <sjhill@realitydiluted.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040528 Debian/1.6-7
X-Accept-Language: en
MIME-Version: 1.0
To: Guido Guenther <agx@sigxcpu.org>
CC: linux-mips@linux-mips.org, debian-toolchain@lists.debian.org
Subject: Re: TLS register
References: <20040531230524.GB2785@bogon.ms20.nix>
In-Reply-To: <20040531230524.GB2785@bogon.ms20.nix>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sjhill@realitydiluted.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5227
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@realitydiluted.com
Precedence: bulk
X-list: linux-mips

Guido Guenther wrote:
>
> He suggested $24 (t8) another discussed possibility would be $27 (k1)
> which is already abused by the PS/2 folks for ll/sc emulation.
> Another possibility would be to reserve such a register only in the
> n32/n64 ABIs and let o32 stay without __thread and TLS forever.
> Any feedback welcome.
>
I vote for $24 (t8). LL/SC emulation is an issue and I believe some of
the exception vectors, if not all of them indirectly depend on k1. It
would take a lot of work (and testing) to rewrite the exceptions to not
utilize k1 and it would probably be a nasty performance hit in many
cases. I agree with "Screw o32" and let's move forward.

-Steve
