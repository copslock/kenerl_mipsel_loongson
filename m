Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Oct 2009 13:49:54 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:59203 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492470AbZJCLts convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 3 Oct 2009 13:49:48 +0200
Received: by fxm21 with SMTP id 21so1601410fxm.33
        for <linux-mips@linux-mips.org>; Sat, 03 Oct 2009 04:49:42 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9ugZf+IV4IRQ6cyQl4IrZxqO9uG1AxIuMFIONUJMmUs=;
        b=lUY44RrZBbT+Pni+K5GFFBfhUkwqAlvVaclYkWyJABDghJoWkr+ChB6amgWCPRYTqy
         bZYchKRJang7KjcTE4bKbI1yUlPETFMI6d5zHRk3sl8WJiOJw44Y4v4lv1UHBGqok05w
         bC35gDjI51nezrMXf7Y4HDk0/9gBzW+F2Q3cI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=bm8+74PP2WPQQqGCyswKXUimFGUD0/qgxHkiVpFYMgx08jr1TEbU7R7Wh1W1ZurX+Q
         /ur8WiqTrbGnK5YCCEvDDdPkkNcHwZBUDsoRGqqMVnKUeRdI+g963Q3aBF+GdeOmVKWX
         fb16y1uGINuTBm8FEru1nu2CKoRt+ev9eYOlk=
MIME-Version: 1.0
Received: by 10.103.126.27 with SMTP id d27mr861929mun.56.1254570582081; Sat, 
	03 Oct 2009 04:49:42 -0700 (PDT)
In-Reply-To: <20091003102221.GB24206@pengutronix.de>
References: <1254250236-18130-1-git-send-email-manuel.lauss@gmail.com>
	 <20091002105903.GC3179@pengutronix.de>
	 <f861ec6f0910020415j5125295fn6b5dff7db4bf170e@mail.gmail.com>
	 <20091002125423.GD3179@pengutronix.de>
	 <f861ec6f0910020732p2ff76990q1e7a2bca16e52e64@mail.gmail.com>
	 <20091003102221.GB24206@pengutronix.de>
Date:	Sat, 3 Oct 2009 13:49:42 +0200
Message-ID: <f861ec6f0910030449q635360ct12d6c47cfb24670d@mail.gmail.com>
Subject: Re: [PATCH] Alchemy: XXS1500 PCMCIA driver rewrite
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	linux-pcmcia <linux-pcmcia@lists.infradead.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Florian Fainelli <florian@openwrt.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Sat, Oct 3, 2009 at 12:22 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>> > Yeah, I saw that you want to remove it, still I don't know why :) Is it feature
>> > incomplete and updating is impossible? Is the concept outdated? Could you
>> > enlighten me on that?
>>
>> I started out with the intention to fix its styling issues, add carddetect irq
>> support, etc.  In the end it was easier to write a quick-and-dirty standalone
>> full-features socket driver for the DB1200 and extend it to support the
>> other DB/PB boards. While I was at it I modified my driver for the xxs1500,
>> that's all.
>
> Okay, that explains.
>
>>
>> The only *technical* reason I have is a personal dislike for how the current
>> one works: it forces every conceivable board to add dozens of cpp macros
>> for mem/io ranges and gets registered by board-independent code.
>> Hardly convincing, I know.
>
> Well, you have the (to me) pretty convincing technical argument that your
> drivers provide more features and less crashes which is a clear benefit for
> users. If we remove the generic au1000-part, then it might even be in the same
> amount in LoC. Okay, we lose a bit of maintainability if a bug is found in a
> section which was shared among the former users of generic, as it has to be
> updated for each of the three drivers, but well... Are there any plans to
> convert pb1x00 as well?

The new db1xxx_ss.c already supports all boards pb1x00 is supposed to,
except for the PB1000 (the very first Alchemy devboard), which has a
rather awkward carddetect irq scheme, so I kept the au1000_pb1x00.c
for it.  Unfortunately I don't have this board to test on, and *if* there are
any linux users with this board, they choose to remain silent (the driver
hasn't built for it in years, so go figure).  I'd rather get rid of
PB1000 support
altogether...


> Maybe I find time to look a bit more into it, but I can't test anything, of
> course, so the more additional comments/test-reports the better.

Thanks.  As I mentioned, the db1xxx_ss part works on my Db1200/Db1300
boards; I don't have any others to test on.

        Manuel Lauss
