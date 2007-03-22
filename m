Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2007 02:08:56 +0000 (GMT)
Received: from nz-out-0506.google.com ([64.233.162.239]:22715 "EHLO
	nz-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021844AbXCVCIx (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Mar 2007 02:08:53 +0000
Received: by nz-out-0506.google.com with SMTP id x7so316013nzc
        for <linux-mips@linux-mips.org>; Wed, 21 Mar 2007 19:07:49 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=tcGYw6KyYs0/fJaRDQuWKYqYe4u0Q09pJYF7d8NHIWHqXQHaSs3wYbYblz7SHhA4F7+tCCRWCUKIjS3OsB4oTjNUdTz0TN+5eASP8ch4rWJ687MMktwVo18UrpWH7+BQZUQPvEiTtByRiBbt991k6Ne8EFQSndHlI13IdoVlrhw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=rLimkqJk5msjp0qScO53Yqd2Gwu9RfSDL2BEpQu1tR02X53wGbOXi6Nb68etKmyTeUnEG37skMWQLmjki1KY6bIrQb8G8gIiS34y/T9Un2lM2HhXkEtc49CxFMR0VH2id+nUxf3qEyO5iiRbMDuzq+cpCTbfk9K0/ktHkzvnXwU=
Received: by 10.65.43.17 with SMTP id v17mr3013286qbj.1174529269144;
        Wed, 21 Mar 2007 19:07:49 -0700 (PDT)
Received: by 10.65.97.12 with HTTP; Wed, 21 Mar 2007 19:07:49 -0700 (PDT)
Message-ID: <7d73e7d80703211907l147578b3gc696b8c4c15ae20c@mail.gmail.com>
Date:	Thu, 22 Mar 2007 10:07:49 +0800
From:	"Songmao Tian" <kingkongmao@gmail.com>
To:	"Ralf Baechle" <ralf@linux-mips.org>
Subject: =?GB2312?B?u9i4tDogTWlwcyBTT0MsIExpbnV4?=
Cc:	PhilipS <sphilip30@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <20070311135654.GA26339@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <bf8a8a430703102229k409c4cf5s44fc3510b3e1f64e@mail.gmail.com>
	 <20070311135654.GA26339@linux-mips.org>
Return-Path: <kingkongmao@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14614
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kingkongmao@gmail.com
Precedence: bulk
X-list: linux-mips

Have you heard of loongson? the current version of the cpu is 2e,
while 2f will be released this year, which will clocks at 1GHz,
delivering rather high perfermance:)

Fulong is a miniPC now based on loongson 2e. you can get one for free
if you make recognized contribution to the system:)


Some introduction here:
http://www.cyrius.com/debian/loongson/

2007/3/11, Ralf Baechle <ralf@linux-mips.org>:
> On Sun, Mar 11, 2007 at 11:59:11AM +0530, PhilipS wrote:
>
> > Hello All,
> > I am looking for MIPS Development boards for my hobby projects like Linux
> > Porting and Development, I am here by looking for an Expert suggestion to
> > buy a MIPS custom boards, so far on Google I could come across
> > vendor selling MIPS Evaluation target boards which is Obviously expensive
> > which ,I cannot afford to buy. I hope I am asking this question at the
> right
> > place, else please suggest me where I can post my request if one knows
> about
> > it.
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
> grey shades between white and black.  Some companies seem to have tremendous
> difficulty to be good open source citizens - but they throw some free
> hardware into the crowd.  Not enough to satisfy the demand and usually only
> a few key people are really able to take advantage of that.
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
>
>
