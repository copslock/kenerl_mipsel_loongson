Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Sep 2014 02:43:56 +0200 (CEST)
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:50203 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008644AbaIKAnz30b4D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Sep 2014 02:43:55 +0200
Received: from omta18.westchester.pa.mail.comcast.net ([76.96.62.90])
        by resqmta-ch2-01v.sys.comcast.net with comcast
        id pcT31o0021wpRvQ01cjif1; Thu, 11 Sep 2014 00:43:42 +0000
Received: from [192.168.1.13] ([50.190.84.14])
        by omta18.westchester.pa.mail.comcast.net with comcast
        id pcji1o00C0JZ7Re3ecjiur; Thu, 11 Sep 2014 00:43:42 +0000
Message-ID: <5410F03B.6080505@gentoo.org>
Date:   Wed, 10 Sep 2014 20:43:39 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: IRIX support removal from the GNU toolchain
References: <alpine.LFD.2.11.1409110007340.11957@eddie.linux-mips.org>
In-Reply-To: <alpine.LFD.2.11.1409110007340.11957@eddie.linux-mips.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1410396223;
        bh=vkIdjwai/KPBdaR5cZnsw5SQg5ray8hTMtc/oDu25KA=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=UDZt0PbmSx9oJ8D5SetxOLwuXBCnwJHj7JgAd6xA9Fz+VsBQU3RC86uzdJz7XgU2D
         mPfpSqjbrefdG3QejDNXP71xJ042CWejNc6/uhTsR72/bWkgUJEaWP5hHP35p/Sw8o
         RvFZCCE4EpTUEF503zD9VxleMuXfzx8ZXm4dF8YMaXv4wH6MbNs+3BXRgH8RDcm3xW
         9d6zDztJUqVvv9HZRsFUoPsuAh1s0RT0NL2oyWzxYPU5xUEGQnvNop4pEzDf+Kxu4e
         5P2KK8zmTkrh2v5sTJbei8/4QfEN8NfeV6Y8BBSfQOOAe3zfGIM30IdsTnZ+8++grU
         Cx59mjyNHMhoQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42499
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

On 09/10/2014 19:16, Maciej W. Rozycki wrote:
> Everyone --
> 
>  Just to raise your attention, IRIX support removal is being discussed 
> across GNU toolchain mailing lists right now with the likely outcome of a 
> go-ahead very soon, especially as support for the OS itself has been 
> recently withdrawn by SGI and also toolchain maintainers have no access to 
> IRIX machines anymore.  So if there's anyone among you who in addition to 
> being keen on Linux for the MIPS platform is also an IRIX enthusiast and 
> would like to keep the platform alive in the GNU toolchain, now's about 
> time to speak up and step in as the maintainer.
> 
>   Maciej

My understanding is that IRIX was already removed from gcc two years ago,
deprecated in 4.7 and removed in 4.8:

https://gcc.gnu.org/ml/libstdc++/2012-03/msg00067.html

Not sure about binutils -- links to the mailing lists in question?

-- 
Joshua Kinard
Gentoo/MIPS
kumba@gentoo.org
4096R/D25D95E3 2011-03-28

"The past tempts us, the present confuses us, the future frightens us.  And our
lives slip away, moment by moment, lost in that vast, terrible in-between."

--Emperor Turhan, Centauri Republic
