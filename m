Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 14:48:10 +0100 (BST)
Received: from mx02.qsc.de ([IPv6:::ffff:213.148.130.14]:61869 "EHLO
	mx02.qsc.de") by linux-mips.org with ESMTP id <S8225307AbVGVNrz>;
	Fri, 22 Jul 2005 14:47:55 +0100
Received: from port-195-158-170-19.dynamic.qsc.de ([195.158.170.19] helo=hattusa.textio)
	by mx02.qsc.de with esmtp (Exim 3.35 #1)
	id 1DvxuM-0002gP-00; Fri, 22 Jul 2005 15:49:46 +0200
Received: from ths by hattusa.textio with local (Exim 4.52)
	id 1DvxuM-0005sZ-88; Fri, 22 Jul 2005 15:49:46 +0200
Date:	Fri, 22 Jul 2005 15:49:46 +0200
To:	Jerry <jerry@wicomtechnologies.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: structure initialization
Message-ID: <20050722134946.GE1692@hattusa.textio>
References: <1663025994.20050722163929@wicomtechnologies.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1663025994.20050722163929@wicomtechnologies.com>
User-Agent: Mutt/1.5.9i
From:	Thiemo Seufer <ths@networkno.de>
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8604
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Jerry wrote:
> 
> A kind of lame offtopic question :)
> What reason in 2.6 to do structure init in this way:
>  struct a = {
>   .name = value
> ...
> 
> instead of 2.4-like:
>  struct a = {
>   name: value
> ...
> 
> Is this a bad form to use ".name" in 2.4 or "name:" in 2.6?

name: is the obsolete GNU gcc extension, .name = is C99. The C99 style
is strongly preferred now.


Thiemo
