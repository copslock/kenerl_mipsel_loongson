Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 08:56:17 +0100 (BST)
Received: from rwcrmhc12.comcast.net ([IPv6:::ffff:216.148.227.85]:25047 "EHLO
	rwcrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8225072AbTHLH4L>; Tue, 12 Aug 2003 08:56:11 +0100
Received: from gentoo.org (pcp02545003pcs.waldrf01.md.comcast.net[68.48.92.102](untrusted sender))
          by comcast.net (rwcrmhc12) with SMTP
          id <2003081207560401400kb0ope>
          (Authid: kumba12345);
          Tue, 12 Aug 2003 07:56:04 +0000
Message-ID: <3F389DB2.5020101@gentoo.org>
Date: Tue, 12 Aug 2003 03:56:34 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp> <3F388E0C.50802@gentoo.org> <20030812070645.GF23104@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20030812070645.GF23104@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3027
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

> I recommend to prefer -march=mips3 over -mips3. It documents the
> intention to use a generic arch better and avoids confusion with
> e.g. -mips16, which has a totally different meaning.
> 
> It won't work with old toolchains, though.
> 
> 
> Thiemo

Good point.  Does the -march=mips3 work for gcc-3.2.x as well, or is 
that a gcc-3.3.x change?

--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
