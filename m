Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2007 18:19:18 +0000 (GMT)
Received: from an-out-0708.google.com ([209.85.132.240]:21900 "EHLO
	an-out-0708.google.com") by ftp.linux-mips.org with ESMTP
	id S20038962AbXBASTO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Feb 2007 18:19:14 +0000
Received: by an-out-0708.google.com with SMTP id c8so402997ana
        for <linux-mips@linux-mips.org>; Thu, 01 Feb 2007 10:19:12 -0800 (PST)
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=NxZwV5fA/hOundN27tL+DIZz2UORFMDQQWJ5O2eIuwiow3bCC7BcEjQG7/WAOXuHekdh71xuycAhap+88kQ/MVa7SOv/wua9B1WQEg0CLMfgHWHywyvJO6zpJquXQAu0WQ+SDv0aS65q4eu0PEwV7myZeb7zpBFP6GS2yeeK3nc=
Received: by 10.78.170.17 with SMTP id s17mr551380hue.1170353948628;
        Thu, 01 Feb 2007 10:19:08 -0800 (PST)
Received: by 10.78.184.6 with HTTP; Thu, 1 Feb 2007 10:19:08 -0800 (PST)
Message-ID: <f383264b0702011019ha411ef7t3447e65f6266917e@mail.gmail.com>
Date:	Thu, 1 Feb 2007 10:19:08 -0800
From:	"Matt Reimer" <mattjreimer@gmail.com>
To:	"Rodolfo Giometti" <giometti@enneenne.com>
Subject: Re: Advice on battery support [was: Advice on APM-EMU reunion]
Cc:	"Paul Mundt" <lethal@linux-sh.org>, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.arm.linux.org.uk, linux-mips@linux-mips.org
In-Reply-To: <20070201095904.GE8882@enneenne.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20070129230755.GA8705@enneenne.com>
	 <20070130010055.GA15907@linux-sh.org>
	 <20070201095904.GE8882@enneenne.com>
Return-Path: <mattjreimer@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13886
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattjreimer@gmail.com
Precedence: bulk
X-list: linux-mips

On 2/1/07, Rodolfo Giometti <giometti@enneenne.com> wrote:
>
> Ok, starting from these patches I'd like to add a "battery support" to
> the kernel.
>
> What I suppose to do is a new class with a proper methods useful to
> collect several info on battery status, such as get_ac_line_status()
> get_battery_status(), get_battery_flags(),
> get_remaining_battery_life() and so on.

Wasn't there recently a big discussion on lkml about a battery class?

Matt
