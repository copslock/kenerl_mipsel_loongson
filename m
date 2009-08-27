Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Aug 2009 15:01:24 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:39612 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492316AbZH0NBR convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Aug 2009 15:01:17 +0200
Received: by fxm20 with SMTP id 20so1197993fxm.0
        for <multiple recipients>; Thu, 27 Aug 2009 06:01:11 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=i0zIStESLgPSXir5RyuhKO6iY4sJ+gdCKI0F7o+tCVY=;
        b=P6fEVIlO4QwMo9FyV2x9x8/FWKvpp3adibetAmmBHss9buWUL3Ki17rT/g0ZqV4x71
         4jRQK52SH9YzPd7Sk4FND7/0RJONB/l/Vy3eHL8mUD6YQI+je9xOBljy+LW3tNwjuPto
         Z6+ysL3UDbXPp5fs2WT8LKvWEmmLpgjCbwqQI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=qCgXyvz1eOw+kfRAHtTh5beVBJfTSOK+rAXNUTxhkDOlWsLp6VramLNJYgehdwZrb4
         3VzpHNHXlK6ZoKBEsRX5DWYYX++lK17vCX/GDdaqWeG/zwD3PDDiDA8tRNMk8BfGg3oX
         H9iVaBbRljU8WW1cFAtHFcbanV/k8MXsNjuuc=
MIME-Version: 1.0
Received: by 10.223.144.204 with SMTP id a12mr6580541fav.49.1251378071447; 
	Thu, 27 Aug 2009 06:01:11 -0700 (PDT)
In-Reply-To: <20090827114907.GD29984@linux-mips.org>
References: <1250957401-14447-1-git-send-email-manuel.lauss@gmail.com>
	 <20090827114907.GD29984@linux-mips.org>
Date:	Thu, 27 Aug 2009 15:01:11 +0200
Message-ID: <f861ec6f0908270601p4e33a95ei6dc213cddcc52597@mail.gmail.com>
Subject: Re: [PATCH 0/2] RFC: Alchemy: multiple timer base address support
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
X-archive-position: 23939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Thu, Aug 27, 2009 at 1:49 PM, Ralf Baechle<ralf@linux-mips.org> wrote:
> On Sat, Aug 22, 2009 at 06:09:59PM +0200, Manuel Lauss wrote:
>> From: Manuel Lauss <manuel.lauss@googlemail.com>
>> Date: Sat, 22 Aug 2009 18:09:59 +0200
>> To: Linux-MIPS <linux-mips@linux-mips.org>,
>>       Ralf Baechle <ralf@linux-mips.org>
>> Cc: Manuel Lauss <manuel.lauss@gmail.com>
>> Subject: [PATCH 0/2] RFC: Alchemy: multiple timer base address support
>
> Ah, I missed the "RFC" in the subject line.  Lemme know if you want me to
> keep this in -queue or yank it out.

Please yank it for now, I'll resend diffed against -queue at a later date.

Manuel Lauss
