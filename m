Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Jun 2007 21:03:00 +0100 (BST)
Received: from py-out-1112.google.com ([64.233.166.179]:18329 "EHLO
	py-out-1112.google.com") by ftp.linux-mips.org with ESMTP
	id S20022078AbXFZUCz (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 26 Jun 2007 21:02:55 +0100
Received: by py-out-1112.google.com with SMTP id p76so3382205pyb
        for <linux-mips@linux-mips.org>; Tue, 26 Jun 2007 13:02:54 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ZAmPx8+FZMD+IODoy7509QYOqQfwTdITuLEwJnMDa7CQdjP0ULQ+smiJDJ1h8qy0yiui7r2av3bvWTP+vbwJOh2EfDdnMPl0t6xy0xU253YCO5D4Uwi3dCNzTsokb7S9gNHgdZQ8HQA24sE8AXo2AgKzCIvZ3HorEDpweN/MMxI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Z2QoXYbpg3DiMFn9zDdlLeUMwH/q6waZ22sl7bsnzxVTOo3cHYOi0UReHKpS5PnJjjbwIIcUZRhdHdVFFl0Kufv8r6OqiKfU3EBljm49NJfQ+ofNj+k9ZsGcFub2Wzd0s37MDF7gPkos0P6rnXB4WZLkFV+Sz+2Zluf2o3V4kfA=
Received: by 10.65.219.20 with SMTP id w20mr11900628qbq.1182888173584;
        Tue, 26 Jun 2007 13:02:53 -0700 (PDT)
Received: by 10.65.185.1 with HTTP; Tue, 26 Jun 2007 13:02:53 -0700 (PDT)
Message-ID: <cda58cb80706261302r67629f62hf560d5229df34663@mail.gmail.com>
Date:	Tue, 26 Jun 2007 22:02:53 +0200
From:	"Franck Bui-Huu" <vagabon.xyz@gmail.com>
To:	"Atsushi Nemoto" <anemo@mba.ocn.ne.jp>
Subject: Re: [PATCH] generic clk API implementation for MIPS
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
In-Reply-To: <20070627.013312.25479645.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <cda58cb80706260237r60a0b6b3obeba7daac7cf114a@mail.gmail.com>
	 <20070626.233332.74753130.anemo@mba.ocn.ne.jp>
	 <cda58cb80706260820y4db3eacnae4dff0101852d52@mail.gmail.com>
	 <20070627.013312.25479645.anemo@mba.ocn.ne.jp>
Return-Path: <vagabon.xyz@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vagabon.xyz@gmail.com
Precedence: bulk
X-list: linux-mips

On 6/26/07, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> I just think having centralized clock_list[] array might cause
> maintainance issue.  Calling clk_register() in your platform's
> arch_initcall (or so) seems enough for me.

It seems that clock configuration highly depends on the board, not the
arch. For example, a board can have only static clocks which won't be
unregistered later. In that case most of code provided by the patch is
useless.

So maybe the best thing is to let each board implements their own
generic clock API (exactly like the generic GPIO API you did
recently). Or make a default implementation (your patch) and allow
others boards to make their own implementation.

What do you think ?
-- 
               Franck
