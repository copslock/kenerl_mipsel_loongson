Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:30:44 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:64215 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493371AbZKCPai convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:30:38 +0100
Received: by bwz21 with SMTP id 21so7672998bwz.24
        for <multiple recipients>; Tue, 03 Nov 2009 07:30:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=RA4fC8DR++2aTqigWIFOQXZHy27yTSV7ScVxbMw3TdE=;
        b=lly9YDEzXpH6rguEiLUudlGGwbgSTUtkuII6Hez4I+D5y4TyRAeuoLrhe/Ow966IVy
         U5gnzn4V/diVBdpG26IADzs1N9TQtsnGqFPLZ+xkx9hlK5itTExT1QEcGyd5nKPoG/cr
         AA5tGlHTIo/OwhVWZvN3lP33TB5uk8y35O+pI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=oj92RkBXEcSqLJlYWyCCYPc0by9CBHrBP7blJXSTZJFZhq3RLP3ddkWrRNFe+zdnlY
         bcm0ml017FXeXHxqGzWf6MOU32wTfB0FDIpepbiC6E0fLhacCAH0SRMc2bJXTsPYpx0W
         +z05YZJNarjjriG0DzYbTUjcYDOuaZ72D96Mg=
MIME-Version: 1.0
Received: by 10.223.73.20 with SMTP id o20mr16648faj.71.1257262227102; Tue, 03 
	Nov 2009 07:30:27 -0800 (PST)
In-Reply-To: <20091103153040.GC1742@linux-mips.org>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	 <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
	 <20091103153040.GC1742@linux-mips.org>
Date:	Tue, 3 Nov 2009 16:30:26 +0100
Message-ID: <f861ec6f0911030730k53b2b921kddc8c67266846af2@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] MIPS: Alchemy: DB1200 AC97+I2S audio support.
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org,
	Mark Brown <broonie@opensource.wolfsonmicro.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 3, 2009 at 4:30 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
>
>> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
>> proper reference asoc machine for Alchemy-based systems.
>> AC97/I2S can be selected at boot time by setting switch S6.7
>>
>> Cc: alsa-devel@alsa-project.org
>> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>> Depends on patch "ASoC: au1x: convert to platform drivers" in
>> Mark Brown's asoc tree to actually work.
>
> Queued for 2.6.33.  I've not seen the dependency but I hope there is no
> harm in getting things merged out of order?

You just won't get any sound if the other patch isnt applied first,
no build failures of oopses.

Manuel
