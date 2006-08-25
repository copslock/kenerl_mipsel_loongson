Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Aug 2006 06:11:12 +0100 (BST)
Received: from web31505.mail.mud.yahoo.com ([68.142.198.134]:1186 "HELO
	web31505.mail.mud.yahoo.com") by ftp.linux-mips.org with SMTP
	id S20037560AbWHYFLJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 25 Aug 2006 06:11:09 +0100
Received: (qmail 70670 invoked by uid 60001); 25 Aug 2006 05:11:00 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=iC/Taa7RCaQA6N0lwk7demU4wEmaw6YeN2GQ1xZhvYoaxCI2B5XQt+bKaUpwt9HegwR9ARmweeCc4/DcfectmVFuDfw3znUqyMpigz7X4INC2juOR9c80NO3f6KbTLVM5mNLA5+tb90GrxN9N8y7MwFeuamCLwitaTyeCDvKJgg=  ;
Message-ID: <20060825051100.70667.qmail@web31505.mail.mud.yahoo.com>
Received: from [65.102.5.19] by web31505.mail.mud.yahoo.com via HTTP; Thu, 24 Aug 2006 22:11:00 PDT
Date:	Thu, 24 Aug 2006 22:11:00 -0700 (PDT)
From:	Jonathan Day <imipak@yahoo.com>
Subject: Re: [PATCH] 64K page size
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Thiemo Seufer <ths@networkno.de>,
	Peter Watkins <treestem@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <20060825002811.GA31044@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <imipak@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12432
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: imipak@yahoo.com
Precedence: bulk
X-list: linux-mips

The short answer is that I'm actually working on a
MIPS-based supercomputer. :)

The longer answer is that the group I'm working with
is linking an extremely large number of SB1-based MIPS
nodes together to build a very large multicast-based
cluster. Back-of-the-envelope calculations suggest
that large pages - although inefficient on memory per
node - would be highly efficient for what we have in
mind.

(You are correct that this will not involve solving
world hunger - although I'm always happy to be proven
wrong on such matters.)

Large pages are not the only technical issue that has
been bugging me - Linux clustering technology in
general is a long way from where I'd like it to be -
but I'm happy with the idea of someone solving one of
the potentially larger thorns that has been bugging me
for a while.

Jonathan Day


--- Ralf Baechle <ralf@linux-mips.org> wrote:
> 64K pages are not the universal solution to world
> hunger.  They're a
> tradeoff and usually one that is considered
> apropriate for full blown
> supercomputers.  On smaller systems the memory
> overhead is likely to be
> prohibitive.  The memory overhead problem is being
> worked on but it's
> likely to be quite some time before this is finished
> and integrated.
> 
> Do we want to get them to work?  Of course,
> Linux/MIPS supports some
> extremly large systems.  But aside of those 64K
> pagesize is rarely useful.
> 
>   Ralf
> 


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
