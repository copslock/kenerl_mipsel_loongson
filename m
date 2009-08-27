Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 14:09:10 +0200 (CEST)
Received: from mail-bw0-f208.google.com ([209.85.218.208]:35345 "EHLO
	mail-bw0-f208.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492364AbZH0MJD convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 14:09:03 +0200
Received: by bwz4 with SMTP id 4so1133431bwz.0
        for <multiple recipients>; Thu, 27 Aug 2009 05:08:58 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=8TDRdK6tXngO+lmQHv3aUgugzqYmWV4YsxfRAt8wgGQ=;
        b=sWlxMGiJzh1KlAKh8q6mK0cj+3eaiCfsR7BGCwWT+ShL2un1vejLkpYHFskB+a3S5N
         0N8oUiTl/Z0KRYrG+9oIUPTQnwUYAVXRSzBQ9/BYD4UZUIvKFA6iN4VPwkGtddL+OgN/
         oo814t6nraeN2Z5R+/8H6KJKaMjQxsmoJVnt4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=N2DuICysKzzbhjRp/eDXQEnrN9YuaZ9IW7CdCoJ08qbClrWvlUL4xxC7ltOZ8FCMVN
         DW1WF/sqn2DFtlPCMhtrvF8Yv77TIsQLD7CSUeS5P4Atry4uU+/sbrAgWTqnpPMtNzjd
         IPw7A92M6utWSkQ+m8JBD6tbket1NRr5jNZmw=
MIME-Version: 1.0
Received: by 10.223.103.25 with SMTP id i25mr6606965fao.64.1251374938152; Thu, 
	27 Aug 2009 05:08:58 -0700 (PDT)
In-Reply-To: <20090827105758.GA29561@linux-mips.org>
References: <1250957352-14359-1-git-send-email-manuel.lauss@gmail.com>
	 <20090827105758.GA29561@linux-mips.org>
Date:	Thu, 27 Aug 2009 14:08:58 +0200
Message-ID: <f861ec6f0908270508o4b995468lc1bfd6e136795cc2@mail.gmail.com>
Subject: Re: [PATCH] Alchemy: override loops_per_jiffy detection
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Ralf,

On Thu, Aug 27, 2009 at 12:57 PM, Ralf Baechle<ralf@linux-mips.org> wrote:
> On Sat, Aug 22, 2009 at 06:09:12PM +0200, Manuel Lauss wrote:
>
>> The loops_per_jiffy detection in generic calibrate_delay is a bit off
>> (by ~0.5% usually); calculate the correct value based on detected core
>> clock.  BogoMIPS value will now reflect cpu core clock correctly.
>
> It think this is pretty much solving a non-problem.

Pretty much, yeah, and it doesn't solve it completely either. With certain
frequencies the printed rate is wrong due to rouding ;-)


> Here's an even easier solution:
>
> #include <linux/jiffies.h>
> ...
>        preset_lpj = <loops_per_jiffie_value>;
>
> Avoid the change to Kconfig that eventually will become messy if other
> systems continue along this line.

Ah, much better.  I'll resend a tested new version in a few hours.

Thanks!
     Manuel Lauss
