Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Nov 2006 06:04:54 +0000 (GMT)
Received: from wx-out-0506.google.com ([66.249.82.228]:56704 "EHLO
	wx-out-0506.google.com") by ftp.linux-mips.org with ESMTP
	id S20037590AbWKHGEq (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 8 Nov 2006 06:04:46 +0000
Received: by wx-out-0506.google.com with SMTP id h30so1524341wxd
        for <linux-mips@linux-mips.org>; Tue, 07 Nov 2006 22:04:44 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:cc:subject:date:message-id:mime-version:content-type:content-transfer-encoding:x-mailer:thread-index:x-mimeole:in-reply-to;
        b=oZe9LVrWR1cVw4jzc80adAvBBc3oIjPejjZPmi6H2heQNFLX2XEw6xAlJDXLAFNYckCC9E8aoz3GFkUCt+OUvGAGXww3MnRQ9pCdxASWpubL+pnXQCn0KOBfN6xosAZaLrGy1wwSHmxXERHFZuxHdeKc7M/B8eJWRB0QivPfvRA=
Received: by 10.70.76.13 with SMTP id y13mr8747086wxa.1162965884717;
        Tue, 07 Nov 2006 22:04:44 -0800 (PST)
Received: from barrioswinxp ( [210.94.41.89])
        by mx.google.com with ESMTP id i16sm9715937wxd.2006.11.07.22.04.43;
        Tue, 07 Nov 2006 22:04:44 -0800 (PST)
From:	=?ks_c_5601-1987?B?sei5zsL5?= <barrioskmc@gmail.com>
To:	"'Thiemo Seufer'" <ths@networkno.de>,
	"'Tim Bird'" <tim.bird@am.sony.com>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: MIPS processors gain GNU/Linux binary prelinker
Date:	Wed, 8 Nov 2006 15:04:41 +0900
Message-ID: <000801c702fb$c96e89e0$0202fea9@swcenter.sec.samsung.co.kr>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="ks_c_5601-1987"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AccCdlPhiEMmXaCGSkSTiB1vXSyW8wAhUCMA
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2962
In-Reply-To: <20061107140437.GD19541@networkno.de>
Return-Path: <barrioskmc@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13160
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: barrioskmc@gmail.com
Precedence: bulk
X-list: linux-mips

Who know anymore about prelink for mips architecture? 
Let me know prelink for mips detaily.
Thanks in advance.


-----Original Message-----
From: linux-mips-bounce@linux-mips.org [mailto:linux-mips-bounce@linux-mips.
org] On Behalf Of Thiemo Seufer
Sent: Tuesday, November 07, 2006 11:05 PM
To: Tim Bird
Cc: CE Linux Developers List; linux-mips@linux-mips.org
Subject: Re: MIPS processors gain GNU/Linux binary prelinker

Tim Bird wrote:
> FYI - For those interested in bootup time improvements on MIPS
> processors, here is some information about the recently
> developed MIPS prelinking feature, done by CodeSourcery
> and MIPS Technologies.

The patches are showing up piecemeal now on the various mailing lists,
I also dumped a debian-styleish patchset at
ftp://ftp.linux-mips.org/pub/linux/mips/people/ths/mips-prelinker-patches-
debian/


Thiemo
