Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Dec 2004 04:01:23 +0000 (GMT)
Received: from web52806.mail.yahoo.com ([IPv6:::ffff:206.190.39.170]:59730
	"HELO web52806.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225255AbULXEBI>; Fri, 24 Dec 2004 04:01:08 +0000
Received: (qmail 93589 invoked by uid 60001); 24 Dec 2004 04:00:51 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=GSUAie02IlxekLIAVxYYn1aDqCXQAfkBkkY1OWbqcnjHtLgxKyhvEV4X/wJmB1Q1RIVp/P3StjsQRs4sRzgHSLyticT2bTd3Raqi+w7K57c5212A2q3fdbyKkXGjyiOzg65PIXHY9AbgyyYnZlimevVWd3I3ll6RIne6wzxs600=  ;
Message-ID: <20041224040051.93587.qmail@web52806.mail.yahoo.com>
Received: from [203.145.153.244] by web52806.mail.yahoo.com via HTTP; Thu, 23 Dec 2004 20:00:51 PST
Date: Thu, 23 Dec 2004 20:00:51 -0800 (PST)
From: Manish Lachwani <m_lachwani@yahoo.com>
Subject: Re: [PATCH] Further TLB handler optimizations
To: Martin Michlmayr <tbm@cyrius.com>, linux-mips@linux-mips.org
In-Reply-To: <20041223202526.GA2254@deprecation.cyrius.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <m_lachwani@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m_lachwani@yahoo.com
Precedence: bulk
X-list: linux-mips

Hello !

In what way does it break? Can you please provide more
details. Also, does it break on UP or SMP?

Thanks
Manish Lachwani

--- Martin Michlmayr <tbm@cyrius.com> wrote:

> * Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
> [2004-12-22 22:55]:
> > The patch was tested on an O200 SMP system with 2
> x R12000. Other
> > machines are untested. Please test if it still
> works for you,
> 
> It breaks SB1 SWARM.
> -- 
> Martin Michlmayr
> http://www.cyrius.com/
> 
> 


=====
http://www.koffee-break.com
