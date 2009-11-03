Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 16:34:50 +0100 (CET)
Received: from mail-bw0-f221.google.com ([209.85.218.221]:64598 "EHLO
	mail-bw0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493388AbZKCPeo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 3 Nov 2009 16:34:44 +0100
Received: by bwz21 with SMTP id 21so7677804bwz.24
        for <multiple recipients>; Tue, 03 Nov 2009 07:34:38 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=JWZdHMg3Bvv+fRk2OMj86M4QazS6FT1kezMKGTfqxRQ=;
        b=UfCknXYCxULmu9iHMOSU03IPJJXmpwFJhgooceIY/6oJM8jtm4HdBAHnaJkqkP9px3
         qHnwXxl4LU4u6HRk3wfCRgqcIuujIu/NDFzJOAzNLdiG1GgF8LvbHLG4tKnOTi8aKWGs
         S6IZn83HIvLIPiDOG7sy9O8m23zxtkB+8U1zw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Qlxy6m5XS+LSa+yYfJ9RYupYWf4JStI7sfJD1iykCZOJeFAk2O+kgbH9VNrfOCtAGa
         //BPxooFdMzuEAH6sOih1/DAZl4PitYRuE1SbM7FZYB6CyBXIRk7i+OKwKp4Fl4mWdSw
         b4rbTaMBkCBb6MgPr6Tvwkf1Ly9BCsuAm02ao=
MIME-Version: 1.0
Received: by 10.223.16.72 with SMTP id n8mr22568faa.26.1257262478052; Tue, 03 
	Nov 2009 07:34:38 -0800 (PST)
In-Reply-To: <20091103153518.GA5999@linux-mips.org>
References: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
	 <1257193305-29996-2-git-send-email-manuel.lauss@gmail.com>
	 <20091103153040.GC1742@linux-mips.org>
	 <f861ec6f0911030730k53b2b921kddc8c67266846af2@mail.gmail.com>
	 <20091103153518.GA5999@linux-mips.org>
Date:	Tue, 3 Nov 2009 16:34:37 +0100
Message-ID: <f861ec6f0911030734x3da489d2n1ccb53ed9ee0c21@mail.gmail.com>
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
X-archive-position: 24642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Tue, Nov 3, 2009 at 4:35 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Tue, Nov 03, 2009 at 04:30:26PM +0100, Manuel Lauss wrote:
>
>>
>> On Tue, Nov 3, 2009 at 4:30 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> > On Mon, Nov 02, 2009 at 09:21:44PM +0100, Manuel Lauss wrote:
>> >
>> >> Machine driver for DB1200 AC97 and I2S audio systems, intended as a
>> >> proper reference asoc machine for Alchemy-based systems.
>> >> AC97/I2S can be selected at boot time by setting switch S6.7
>> >>
>> >> Cc: alsa-devel@alsa-project.org
>> >> Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
>> >> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> >> ---
>> >> Depends on patch "ASoC: au1x: convert to platform drivers" in
>> >> Mark Brown's asoc tree to actually work.
>> >
>> > Queued for 2.6.33.  I've not seen the dependency but I hope there is no
>> > harm in getting things merged out of order?
>>
>> You just won't get any sound if the other patch isnt applied first,
>> no build failures of oopses.
>
> With Mark's approval I'd not mind merging the other patch through the MIPS
> tree as well then.

AFAIK Takashi already pulled it into the alsa tree for .33
