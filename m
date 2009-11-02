Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 14:57:17 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:65164 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493138AbZKBN5L convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 2 Nov 2009 14:57:11 +0100
Received: by bwz21 with SMTP id 21so6287267bwz.24
        for <multiple recipients>; Mon, 02 Nov 2009 05:57:06 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=zs8JviXmnYJTQ8coPMYjyIzlGTycL6/+YF6WtAIUkis=;
        b=d2ggYDqlDND8Bato0+ET0E1hSBj331L+mw+tXdFGMDdDiIK0EcryVWPul0oY2MsJZN
         dqsbkokQb1Yqquyet0mhL2PRx1eV//ru5+151sQytJ8HQzqRNH5K4JuU0I7+T2/EijSO
         MtkIq9GoQoM2qCp6KGPoyle0JRyihu9/+BBvI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=xlI4oTH/nFAiwju5n7qFRWtFXCT6y3ILR59n8NcZBi2aq2YnCpp6A/1ISVnOdFLcs2
         Yb5E4fvgulcwckvbC+7zsdvYDhKziVe5X3tlkXUCMSFwlmVSTeRW3xT7xQBtKwnRGUOZ
         dMJVd+nHQFhTgOx9WTA+hsTA+bBGzr3mqsx+g=
MIME-Version: 1.0
Received: by 10.223.25.27 with SMTP id x27mr788684fab.7.1257170226103; Mon, 02 
	Nov 2009 05:57:06 -0800 (PST)
In-Reply-To: <1257167962.8374.0.camel@kh-d280-64>
References: <1255949617-22943-1-git-send-email-manuel.lauss@gmail.com>
	 <f861ec6f0910310913q4945d666tbdaafed3ce7b2125@mail.gmail.com>
	 <1257167962.8374.0.camel@kh-d280-64>
Date:	Mon, 2 Nov 2009 14:57:06 +0100
Message-ID: <f861ec6f0911020557v68eebeb8i1a527229922161fe@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Alchemy: physmap-flash for all devboards
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Kevin Hickey <khickey@netlogicmicro.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 2, 2009 at 2:19 PM, Kevin Hickey <khickey@netlogicmicro.com> wrote:
> On Sat, 2009-10-31 at 17:13 +0100, Manuel Lauss wrote:
>> Ping? Any comments? Flames?
>>
> I will look this over today or tomorrow.  I'm interested in this patch
> but haven't had the time to review it.  Now I'll make the time :)

Please do.  To test swapboot, just dump yamon from the default partition,
and inject it into the "User FS" partition at the appropriate offset, then boot
from the swapped flash, erase the yamon partition and try to boot the
normal nor layout.

If you deem it acceptable, I'll send the 2 db1200 patches (core+sound)
to be applied on top of it.

Manuel
