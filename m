Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 May 2015 05:09:50 +0200 (CEST)
Received: from resqmta-ch2-10v.sys.comcast.net ([69.252.207.42]:57336 "EHLO
        resqmta-ch2-10v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006509AbbELDJtdHvUk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 May 2015 05:09:49 +0200
Received: from resomta-ch2-10v.sys.comcast.net ([69.252.207.106])
        by resqmta-ch2-10v.sys.comcast.net with comcast
        id Sr9d1q0072JGN3p01r9ker; Tue, 12 May 2015 03:09:44 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-10v.sys.comcast.net with comcast
        id Sr9j1q00442s2jH01r9jiJ; Tue, 12 May 2015 03:09:44 +0000
Message-ID: <55516EF3.7010706@gentoo.org>
Date:   Mon, 11 May 2015 23:09:39 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.6.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: IP28: "Inconsistent ISA" messages during kernel build
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1431400184;
        bh=mWSYfIgxtsw2D5w4JtVmfANcNYtbC8CZCUwgSqblt18=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=RLsSeQfLhhJlC3IP6tq2C0KVw3AuzEQDnie7Nf/revfNyzLUZNVfxFS6oEgoVW1LH
         PPy5LEvKNKMCX47GTT2GABlNHIIcRnIjyR5+CAklTLu+sVhw7GjSqmYtsGUOTXn96Q
         REzacmmH5Efpgh3sLa2FqAYDc7BxDjr6faYwgi3RhgdySEbijU3+MB6yJVum5kYY2F
         6vPnr4sA4Lua4Cqr/aBCdSPzr/LbzOh/DcurmyhJBF3AE8FGlDSnLWTTh5VYCY3f0N
         tpwXR0TNOSvvBDcZy7w3dth5YNCSBOPEuxtiojhnqfY3AOGil3FdCYoH5Er8EF2k4m
         OJhbTcNuZ/JGA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


Has anyone tried to build an IP28 kernel lately?  I've been getting quite a few
warnings out of the linker regarding e_flags and the new .MIPS.abiflags stuff.
 Not seen it on the other SGI platforms, so I am assuming this has something to
do with what flags are passed to the compiler/linker.

mips64-unknown-linux-gnu-ld: fs/ext4/symlink.o: warning: Inconsistent ISA
between e_flags and .MIPS.abiflags
mips64-unknown-linux-gnu-ld: fs/ext4/symlink.o: warning: Inconsistent ISA
extensions between e_flags and .MIPS.abiflags

Seeing this on a build of 4.0.2 based off of a 20150418 checkout from git.

--J
