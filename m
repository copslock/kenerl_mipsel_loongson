Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Mar 2007 16:08:08 +0000 (GMT)
Received: from ip-217-204-115-127.easynet.co.uk ([217.204.115.127]:23820 "EHLO
	apollo.linkchoose.co.uk") by ftp.linux-mips.org with ESMTP
	id S20022155AbXCKQIE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 11 Mar 2007 16:08:04 +0000
Received: from [10.98.1.127] (helo=galaxy.dga.co.uk)
	by apollo.linkchoose.co.uk with esmtp (Exim 4.60)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1HQQXW-0000C4-A9
	for linux-mips@linux-mips.org; Sun, 11 Mar 2007 16:04:54 +0000
Received: from [10.0.1.63] (helo=stargate)
	by galaxy.dga.co.uk with esmtp (Exim 4.62)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1HQQX3-00047h-H0
	for linux-mips@linux-mips.org; Sun, 11 Mar 2007 16:04:26 +0000
From:	David Goodenough <david.goodenough@linkchoose.co.uk>
Organization: Linkchoose Ltd
To:	linux-mips@linux-mips.org
Subject: Re: Mips SOC, Linux
Date:	Sun, 11 Mar 2007 16:04:18 +0000
User-Agent: KMail/1.9.5
References: <bf8a8a430703102229k409c4cf5s44fc3510b3e1f64e@mail.gmail.com> <20070311135654.GA26339@linux-mips.org>
In-Reply-To: <20070311135654.GA26339@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200703111604.19435.david.goodenough@linkchoose.co.uk>
Return-Path: <david.goodenough@linkchoose.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14427
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@linkchoose.co.uk
Precedence: bulk
X-list: linux-mips

On Sunday 11 March 2007 13:56, Ralf Baechle wrote:
> On Sun, Mar 11, 2007 at 11:59:11AM +0530, PhilipS wrote:
> > Hello All,
> > I am looking for MIPS Development boards for my hobby projects like Linux
> > Porting and Development, I am here by looking for an Expert suggestion to
> > buy a MIPS custom boards, so far on Google I could come across
> > vendor selling MIPS Evaluation target boards which is Obviously expensive
> > which ,I cannot afford to buy. I hope I am asking this question at the
> > right place, else please suggest me where I can post my request if one
> > knows about it.
>
> You're touch a big problem here, so I'm going to use this opportunity to
> post a rant ...
>
> Most of the eval boards are have very high price tags due to low volume and
> esotheric components such as very large and fast FPGAs or pricey matched
> impedance connectors for logic analyzers.  Another factor is that the
> vendors making these boards usually target their commercial customers and
> factor in a fairly generous markup for the post-sale support into the sales
> price of the board.
>
> From a Free Software perspective this is a bloody disaster.  Even if for a
> moment I put on my dot com hat again, it's one.  Over the past years the
> commercial contributions have primarily focused on hardware support.  In
> many cases I received large code drops of lousy to medicore quality and
> no maintenance at all after the initial code drop.  I won't go into the
> reasons here nor do I think I need to name companies here - but it's a big
> problem.
>
> As usual exceptions proof the rule and also as usual there are alot of
> grey shades between white and black.  Some companies seem to have
> tremendous difficulty to be good open source citizens - but they throw some
> free hardware into the crowd.  Not enough to satisfy the demand and usually
> only a few key people are really able to take advantage of that.
>
> Otoh many if not most important and highest quality contributions over the
> years have come from hobby hackers, so in the end the lack availability of
> modern hardware is making everybody suffer.  Meanwhile the importance of
> Linux as OS for MIPS is continuing to rise ...
>
> I hear similar complaints from other, mostly embedded architectures such as
> ARM.  But that's not an excuse - this problem wants some remedy.
>
> But let's also look at the options you have right now:
>
>  o Eval boards end on ebay relativly rarely, but you can try anyway.
>    Another option is something like a surplus MIPS workstation.
>  o A bunch of wireless routers and other devices such as some the Linksys
>    WRT54 models have been recycled for hacking use with good success.
>  o Routerboard which is not yet supported out of tree (working in cleaing
>    the patches) would be another reasonably priced option.  Generally you
Which of their boards are you working on patches for?

The RB532 seems to be working OK now with a 2.6 kernel on OpenWrt, but I tried
to migrate some patches for the 1xx series (the ADM5120 based cards) and I 
could not get them boot beyond the dnode and inode table initialisations.  If
you have anything better that would work with current kernels I would be very
interested to have a look.

David
>    may want to look at the list of platforms supported by
>    http://openwrt.org/ - many of their platforms have friendly price tags.
>    Of course alot of those are purpose built hw so may be a bit quirky to
>    use.
>  o Apparently AMD Alchemy boards used to be fairly cheap, on the order of
>    $100.  I have not idea this is true or still true for the new owner of
>    Alchemy Raza Microelectronics.
>  o For the meager investment of a few megabytes of disk space Qemu is a
>    really nice and well performing system which also is rapidly improving.
>
>   Ralf
