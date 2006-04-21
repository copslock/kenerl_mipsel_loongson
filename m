Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Apr 2006 15:59:27 +0100 (BST)
Received: from 209-232-97-206.ded.pacbell.net ([209.232.97.206]:65424 "EHLO
	dns0.mips.com") by ftp.linux-mips.org with ESMTP id S8133624AbWDUO7S
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Apr 2006 15:59:18 +0100
Received: from mercury.mips.com (sbcns-dmz [209.232.97.193])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id k3LFBxeD017479;
	Fri, 21 Apr 2006 08:11:59 -0700 (PDT)
Received: from ukservices1.mips.com (ukservices1 [192.168.192.240])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id k3LFBvYO013868;
	Fri, 21 Apr 2006 08:11:59 -0700 (PDT)
Received: from wapping.mips-uk.com ([172.20.192.98])
	by ukservices1.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1FWxIX-0006dr-00; Fri, 21 Apr 2006 16:11:53 +0100
Message-ID: <4448F638.9060502@mips.com>
Date:	Fri, 21 Apr 2006 16:11:52 +0100
From:	Nigel Stephens <nigel@mips.com>
Organization: MIPS Technologies
User-Agent: Mail/News 1.5 (X11/20060318)
MIME-Version: 1.0
To:	Shyamal Sadanshio <shyamal.sadanshio@gmail.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Crosstools for MALTA MIPS in little endian
References: <3857255c0604210808y1208045by3449b003b4b2ffea@mail.gmail.com>
In-Reply-To: <3857255c0604210808y1208045by3449b003b4b2ffea@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MIPS-Technologies-UK-MailScanner: Found to be clean
X-MIPS-Technologies-UK-MailScanner-From: nigel@mips.com
X-Scanned-By: MIMEDefang 2.39
Return-Path: <nigel@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11174
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nigel@mips.com
Precedence: bulk
X-list: linux-mips



Shyamal Sadanshio wrote:
> Hi,
>
> I am come across the MALTA specific stable kernel (2.6.12-rc6)
> available on linux-malta.git repository.
> I have cloned this repository and would like to build it with the
> compatible toolchain in little endian mode.
>
> Can anyone please let me know the toolchain specification
> (gcc/glibc/binutils version specifcations) that have been used or can
> be used for compiling the 2.6.12 kernel?
>
>
>   

See http://www.linux-mips.org/wiki/Toolchains#MIPS_SDE

Regards

Nigel
