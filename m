Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2003 08:44:17 +0100 (BST)
Received: from [IPv6:::ffff:62.116.167.108] ([IPv6:::ffff:62.116.167.108]:55513
	"EHLO oricom4.internetx.de") by linux-mips.org with ESMTP
	id <S8225193AbTGWHoN>; Wed, 23 Jul 2003 08:44:13 +0100
Received: from mycable.de (pD9527980.dip.t-dialin.net [217.82.121.128])
	(authenticated bits=0)
	by oricom4.internetx.de (8.12.8/8.12.8) with ESMTP id h6N7bgC7015101;
	Wed, 23 Jul 2003 09:37:43 +0200
Message-ID: <3F1E3D27.2030501@mycable.de>
Date: Wed, 23 Jul 2003 09:45:43 +0200
From: Tiemo Krueger - mycable GmbH <tk@mycable.de>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: saravana_kumar@naturesoft.net
CC: linux-mips@linux-mips.org
Subject: Re: Cross Compilation
References: <1058941229.9252.13.camel@192.168.0.206>
In-Reply-To: <1058941229.9252.13.camel@192.168.0.206>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tk@mycable.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tk@mycable.de
Precedence: bulk
X-list: linux-mips

You could even use the buildroot thing from uclibc.org:

http://uclibc.org/cgi-bin/cvsweb/buildroot/buildroot.tar.gz?tarball=1

It's one of the most simple way for cross toolchain beginners, it
provides you finally with a toolchain and rootfile system and more

Tiemo

SaravanaKumar wrote:

>Dear All, 
>    I am having my application in x86. 
> I have to cross compile that to MIPS architecture. 
>How to do that. 
>
>Is there is any document for doing the cross compilation to MIPS.
>
>Cheers, 
>N.S.Kumar
>
>
>
>  
>
