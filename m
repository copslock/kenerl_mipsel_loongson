Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 27 Sep 2006 14:06:04 +0100 (BST)
Received: from nf-out-0910.google.com ([64.233.182.184]:21307 "EHLO
	nf-out-0910.google.com") by ftp.linux-mips.org with ESMTP
	id S20038466AbWI0NGA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 27 Sep 2006 14:06:00 +0100
Received: by nf-out-0910.google.com with SMTP id l23so468492nfc
        for <linux-mips@linux-mips.org>; Wed, 27 Sep 2006 06:05:59 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=izxJzSQicSz+ljGycqR1WQAPx35ylJoj0HCKifX2dp0zDgrauhPjUgvDcdlRl8WuhTu+4Cm2B2qiz13PSEy5OpjsjtWKjNgTVlV3/p9+dxNq7E6RHicduFhL5qoO/HUkVK7PKyshDyWuy4QkAYAMTx9iLkBBrus4rQxd2Ec1NaA=
Received: by 10.48.48.18 with SMTP id v18mr2380877nfv;
        Wed, 27 Sep 2006 06:05:58 -0700 (PDT)
Received: by 10.48.163.3 with HTTP; Wed, 27 Sep 2006 06:05:58 -0700 (PDT)
Message-ID: <2e134a330609270605u12d04f27t57316a721fdca211@mail.gmail.com>
Date:	Wed, 27 Sep 2006 09:05:58 -0400
From:	"s c" <steve.carren@gmail.com>
To:	"Freddy Spierenburg" <freddy@dusktilldawn.nl>
Subject: Re: How is the au1000_gpio char driver used?
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20060926155832.GC17027@dusktilldawn.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2e134a330609260839l5ab33123p4e712a8fe4e0b60b@mail.gmail.com>
	 <20060926155832.GC17027@dusktilldawn.nl>
Return-Path: <steve.carren@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12691
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: steve.carren@gmail.com
Precedence: bulk
X-list: linux-mips

On 9/26/06, Freddy Spierenburg <freddy@dusktilldawn.nl> wrote:
> Hi Steve,
>
> On Tue, Sep 26, 2006 at 11:39:41AM -0400, s c wrote:
> > I would like to use the au1000_gpio char driver to blink some status
> > lights. Specifically, I would like to control the hex leds on the
> > dbau1500 development board. Preferably via shell script.
>
> http://free-electrons.com/pub/mirror/devmem2.c is your friend.
>
> On a DBAu1100 for instance I have a nice example:
>
>         $ while true; do
>         >       for i in 7 B D E D B; do
>         >                       ./devmem2 0x0E000018 w 0x00000${i}03
>         >                       sleep 0.01
>         >               done
>         > done > /dev/null
>         $
>
> Remember the days of the Night Rider? You will see LED D5, D6, D7
> and D8 flash in a nice manner.
>
> In the same way you must be able to alter the hex leds.
>
> Freddy Spierenburg <freddy@dusktilldawn.nl>  http://freddy.snarl.nl/

Thanks. Works as advertised.

A couples notes to anyone else interested
- devmem2 does not use the au1000_gpio char driver so it could
potentially be used with other processors.
-busybox (if you are using it) doesn't support sub-second sleep like
in the example given by Freddy.
