Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2004 01:02:01 +0000 (GMT)
Received: from sccrmhc12.comcast.net ([IPv6:::ffff:204.127.202.56]:28041 "EHLO
	sccrmhc12.comcast.net") by linux-mips.org with ESMTP
	id <S8224991AbUAPBCB>; Fri, 16 Jan 2004 01:02:01 +0000
Received: from gentoo.org (pcp04939029pcs.waldrf01.md.comcast.net[68.48.72.58])
          by comcast.net (sccrmhc12) with SMTP
          id <200401160101540120029lpre>
          (Authid: kumba12345);
          Fri, 16 Jan 2004 01:01:54 +0000
Message-ID: <4007386F.80207@gentoo.org>
Date: Thu, 15 Jan 2004 20:03:43 -0500
From: Kumba <kumba@gentoo.org>
Reply-To: kumba@gentoo.org
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: Current 2.4 CVS (2.4.24-pre2) doesn't boot on SGI Indy
References: <20040115141427.GA28546@icm.edu.pl> <Pine.LNX.4.21.0401151816540.3511-100000@www.marty44.net> <20040115231735.GA6619@icm.edu.pl>
In-Reply-To: <20040115231735.GA6619@icm.edu.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
Precedence: bulk
X-list: linux-mips

Dominik 'Rathann' Mierzejewski wrote:
> Well, it appears something has been broken during the last 2 months.
> Good to know I'm not alone in this.

I have a 2.4.23 kernel I used from a 20031128 CVS snapshot that works 
fine, but a 2.4.23 20031214 snapshot didn't work (on an R4400@250MHz 
I2), so likely the problem was introduced sometime between those dates. 
  Might help for tracking down the issue.


--Kumba

-- 
"Such is oft the course of deeds that move the wheels of the world: 
small hands do them because they must, while the eyes of the great are 
elsewhere."  --Elrond
