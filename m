Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2003 09:26:55 +0100 (BST)
Received: from rwcrmhc13.comcast.net ([IPv6:::ffff:204.127.198.39]:41110 "EHLO
	rwcrmhc13.comcast.net") by linux-mips.org with ESMTP
	id <S8225072AbTHLI0v>; Tue, 12 Aug 2003 09:26:51 +0100
Received: from gentoo.org (pcp02545003pcs.waldrf01.md.comcast.net[68.48.92.102](untrusted sender))
          by comcast.net (rwcrmhc13) with SMTP
          id <20030812082643015006j4pje>
          (Authid: kumba12345);
          Tue, 12 Aug 2003 08:26:43 +0000
Message-ID: <3F38A4D2.9080105@gentoo.org>
Date: Tue, 12 Aug 2003 04:26:58 -0400
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: GCCFLAGS for gcc 3.3.x (-march and _MIPS_ISA)
References: <20030812.152654.74756131.nemoto@toshiba-tops.co.jp> <3F388E0C.50802@gentoo.org> <20030812070645.GF23104@rembrandt.csv.ica.uni-stuttgart.de> <3F389DB2.5020101@gentoo.org> <20030812081052.GG23104@rembrandt.csv.ica.uni-stuttgart.de>
In-Reply-To: <20030812081052.GG23104@rembrandt.csv.ica.uni-stuttgart.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3029
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Thiemo Seufer wrote:

> It's only in 3.3 and upwards.
> 
> 
> Thiemo

Ahh.  This was why I was still using -mipsX, to maintain backwards 
compatibility until gcc-3.3.x becomes the mainstream compiler.

Something to keep in mind.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
