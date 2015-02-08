Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 Feb 2015 03:58:59 +0100 (CET)
Received: from resqmta-ch2-05v.sys.comcast.net ([69.252.207.37]:54448 "EHLO
        resqmta-ch2-05v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012879AbbBHC6550AOv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 Feb 2015 03:58:57 +0100
Received: from resomta-ch2-09v.sys.comcast.net ([69.252.207.105])
        by resqmta-ch2-05v.sys.comcast.net with comcast
        id peyk1p0022GyhjZ01eyrxU; Sun, 08 Feb 2015 02:58:51 +0000
Received: from [192.168.1.13] ([69.250.160.75])
        by resomta-ch2-09v.sys.comcast.net with comcast
        id peyr1p0051duFqV01eyr0x; Sun, 08 Feb 2015 02:58:51 +0000
Message-ID: <54D6D0D5.8020704@gentoo.org>
Date:   Sat, 07 Feb 2015 21:58:29 -0500
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Linux MIPS List <linux-mips@linux-mips.org>
Subject: IP27: Random hard locks after ~16hrs uptime
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1423364331;
        bh=KZh1jqrDfrvxLmuzu5N5AH09x8KRRCYFzh1gg8PAbLc=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=vZj0pQ4PpuCTD6Uvjai0PlhBrCGugG+5GZc79Qq3oulrfUeq9mbP0GoiUYx2H5vTD
         UdAF9FraqNoU1hl8ga78jAY25fEiUBMNjAOZPvP7wI7MXb4Y/CeTieA4wrBHkrKnT0
         iq0x92pmj/hXawEe9TZXp5YNiZvIqAp30S1Kcpg/ubbRiWiCjXy0jpts6vPM3MS4jS
         0NAiMKXWeBp2beA2heZFxehNUyABjN8JboWxL43YHD0Bkw1ffIABiulNWdk2xHbBeM
         xcgkdrIcLFceT+xUfBXiV0q6Ra2u+eUMUoB3Uc1/53ExzJUrZzamggxEtRw4LLLjmQ
         KpdZ/omyu5GRw==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45763
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

I've had my Onyx2 running quite a bit lately doing compile runs, and it seems
that after about ~16 hours, there's a random possibility that the machine just
completely stops.  No errors printed anywhere, serial becomes completely
unresponsive.  I have to issue a 'rst' from the MSC to bring it back up again.

It's currently got dual IP31 R14000 node boards (500MHz), and for the most
part, runs great (I'll regret the electric bill later...).  Clearly a bug,
though, but I am not sure where to start debugging on this platform to find
this bug, since I can't trigger it manually.  Even tried an NMI interrupt,
since this machine has an NMI handler in the kernel, but all that does is reset
the machine.

Already ran an extensive memory test from the PROM and had no issues with that.
 Haven't tried running any of the more thorough hardware tests from IRIX, though.

Ideas?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
