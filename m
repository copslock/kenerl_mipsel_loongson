Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Mar 2007 14:18:56 +0000 (GMT)
Received: from qb-out-0506.google.com ([72.14.204.235]:39643 "EHLO
	qb-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20021876AbXCSOSw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 19 Mar 2007 14:18:52 +0000
Received: by qb-out-0506.google.com with SMTP id e12so4744655qba
        for <linux-mips@linux-mips.org>; Mon, 19 Mar 2007 07:17:51 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZMPMDVzh+Wag/mjNxoi+KedLlF46IizRcGt8dsJeRL/WtYIu0StrkrNpB+7IRnHp9ZAAxM+1AjX47ETu7wOEItxtfKZmp+Ealj2QmRngF9EQ7R0sR85PPeSV4Mw56IYeZT/Z3HwnTjsoBg8IWC5w532x0PxhznvLhoka990DAjY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=oJ4VcuwuavjfWiWacJtHOrXeqcx263RplMIDgdRyxnB5QXbjwzNCig3RfosZT0GTt7RtbFqF5fHhe3/oP3bszmS4ICJWXQcnTJ5msUhr2gJMUJaZeVz5Y9kMfcMf+6WYHX/xXAXh6Dugj1fcd2d3hJ0Ni21rGqpTkzRNBAUToVE=
Received: by 10.100.136.13 with SMTP id j13mr3726494and.1174313871145;
        Mon, 19 Mar 2007 07:17:51 -0700 (PDT)
Received: by 10.114.136.11 with HTTP; Mon, 19 Mar 2007 07:17:50 -0700 (PDT)
Message-ID: <cda58cb80703190717o1f1a6af7k36b1ff7db185d1d5@mail.gmail.com>
Date:	Mon, 19 Mar 2007 15:17:50 +0100
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	Kumba <kumba@gentoo.org>
Subject: Re: IP32 prom crashes due to __pa() funkiness
Cc:	"Linux MIPS List" <linux-mips@linux-mips.org>,
	"Arnaud Giersch" <arnaud.giersch@free.fr>
In-Reply-To: <45FE95EE.5030108@innova-card.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <45D8B070.7070405@gentoo.org>
	 <cda58cb80703010139y3e5bbb8eqa4d25b75ba658a22@mail.gmail.com>
	 <45FC46F0.3070300@gentoo.org> <87irczzglc.fsf@groumpf.homeip.net>
	 <45FC9E39.7010506@gentoo.org> <45FE95EE.5030108@innova-card.com>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14550
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 3/19/07, Franck Bui-Huu <vagabon.xyz@gmail.com> wrote:
> Now it's clear that CONFIG_BUILD_ELF64 is really confusing. I would say
> that whatever the value of CONFIG_BUILD_ELF64, your kernel should run
> fine. BUT it really depends on your kernel load address:
>
> if CONFIG_BUILD_ELF64=y then kernel load address must be in XKPHYS
> if CONFIG_BUILD_ELF64=n then kernel load address must be in CKSEG0

to be more accurate, the following other config:

        CONFIG_BUILD_ELF64=y and kernel load address in CKSEG0

should theoretically work but currently doesn't because of __pa() introduction.

This config should not be used because it's normally not interesting
for normal user. It's only interesting for testing purpose if I recall
correctly. And the patch that automatically set CONFIG_BUILD_ELF64
should fix this.

BTW, you should take a look at:

http://marc.info/?l=linux-mips&m=117019833420946&w=2

this thread clearly state that current config of IP32 kernel is
broken. Sorry for remembering so lately...
-- 
               Franck
