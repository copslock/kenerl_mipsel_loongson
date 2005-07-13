Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jul 2005 05:40:53 +0100 (BST)
Received: from zproxy.gmail.com ([IPv6:::ffff:64.233.162.193]:25936 "EHLO
	zproxy.gmail.com") by linux-mips.org with ESMTP id <S8226533AbVGMEk2> convert rfc822-to-8bit;
	Wed, 13 Jul 2005 05:40:28 +0100
Received: by zproxy.gmail.com with SMTP id 12so58174nzp
        for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 21:41:27 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=E4PgcbvG5rhW3jdczoklVsBS1BtLfGiPQEZ1xmLegJoHQ72NkW4DbYHMQD9IcfrHnGnOwYcpy3OBSOlRc2LJ5rBe2BM7L8ACPP15T2Hx//VJhNAd04eaYLaPqBgHqxvF5CfB94aA473bVTt98eiHQUdyzAtG/6wo6g3Ay03biNc=
Received: by 10.36.157.15 with SMTP id f15mr552760nze;
        Tue, 12 Jul 2005 21:41:27 -0700 (PDT)
Received: by 10.36.68.6 with HTTP; Tue, 12 Jul 2005 21:41:27 -0700 (PDT)
Message-ID: <6097c4905071221414a929ed2@mail.gmail.com>
Date:	Wed, 13 Jul 2005 08:41:27 +0400
From:	Maxim Osipov <maxim.osipov@gmail.com>
Reply-To: maxim@mox.ru
To:	Bryan Althouse <bryan.althouse@3phoenix.com>
Subject: Re: mips64 crosstool
Cc:	Linux/MIPS Development <linux-mips@linux-mips.org>
In-Reply-To: <20050712181447Z8226651-3678+2808@linux-mips.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
References: <20050712181447Z8226651-3678+2808@linux-mips.org>
Return-Path: <maxim.osipov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8473
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maxim.osipov@gmail.com
Precedence: bulk
X-list: linux-mips

When I was looking at crosstool, it had problems with miltiarch
support for mips. If you want to produce mips64 only tools, you'll
need patches from Maciej which are not there also. And take a look
into build matrix :)

Conclusion - mips is not very well supported in crosstool.

BR,
Maxim

On 7/12/05, Bryan Althouse <bryan.althouse@3phoenix.com> wrote:
> 
> Is anyone using crosstool to produce a 64 bit mips compiler?
> 
> I need to produce a gcc that will accept the -mabi=64 option. I have been
> able to generate a 32bit gcc with crosstool, using
> TARGET=mips-unknown-linux-gnu.  Must I change this to
> TARGET=mips64-unkown-linux-gnu to create a 64bit compiler?  I have tried
> this, but crosstool will fail.  It appears as if -mabi=n32 is passed to the
> native gcc during the build-glibc-headers step.  This of course causes the
> native gcc to give up.
> 
> Are there any patches for mips64 tool chain build?
> 
> Thanks to all.
> Bryan
> 
> 
> 
> 
>
