Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 10:43:54 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:57883 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022562AbZFHJnr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jun 2009 10:43:47 +0100
Received: by bwz25 with SMTP id 25so2918996bwz.0
        for <multiple recipients>; Mon, 08 Jun 2009 02:43:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=0e4BBwRmOBq5zjPsVs/BcsdN8IkTtKTV17rwNYYpZ0c=;
        b=hxxeIkX0j1fHOJJ9BG5J1nOa041+I4kmxadHLVtDhSn2kYoQn8CvBPpkHWYPeMW53d
         OW+6ViMvsgb1Z8jdjMHAJI+rKGBWH60huPxV0kQXj+hrTMlOaYFXWXZbZmAGEf924ixX
         yf2XoTKdg/oWrDfhNyoim/Ph3SK3KbatPUhwk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=d3uCRlFrx9bdh5Tsah3Mi0HVHDTEonokyRDqlr5X0xachIcjIqBElieM9dSHRXG5MM
         u/Z6/TiaW4ObUirNB8w8fjwhqGjq1FvGyo/VN1XrWynGRkoB2ALqCK3TKkyhGZIeqOHK
         a2udZc7ADjnFprD/lI+fqrJhDoCpuS649RBnI=
MIME-Version: 1.0
Received: by 10.223.116.195 with SMTP id n3mr3794845faq.12.1244454221211; Mon, 
	08 Jun 2009 02:43:41 -0700 (PDT)
In-Reply-To: <20090608092521.GA7858@sirena.org.uk>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	 <20090608092521.GA7858@sirena.org.uk>
Date:	Mon, 8 Jun 2009 11:43:41 +0200
Message-ID: <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Mark!

On Mon, Jun 8, 2009 at 11:25 AM, Mark
Brown<broonie@opensource.wolfsonmicro.com> wrote:
> On Sun, Jun 07, 2009 at 08:39:01PM +0200, Manuel Lauss wrote:
>> Replaces the sample Alchemy PSC AC97 machine code with a DB1200 machine
>> driver with AC97 and I2S support.
>
> Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
>
> If this is going to go in during the merge window I'm happy for it to go
> in via the MIPS tree but otherwise I'd much rather it goes via ASoC in
> case API changes cause merge issues.  I don't know what you prefer,
> Ralf?

I'd rather have it all go through the MIPS tree; this is the only patch of
7 which touches files outside it, and it depends on another one to
apply cleanly.


> We could also split the MIPS and ASoC parts into separate patches if
> that helps.
>
>> +/* it sucks that the ASoC headers are not under include/ */
>> +#include "../codecs/ac97.h"
>> +#include "../codecs/wm8731.h"
>
> This is because they're internal to ASoC - having them out of include
> should set off big red warning flags for something outside ASoC is
> looking at them.  If there are things that should be referenced outside
> ASoC they should be in a separate header in include/sound like the
> WM9081 platform data.

I'd actually love to move this file to the actual board code, however due
to the way ASoC is organized this isn't at all possible.  This is one of two
things I don't like about ASoC: the machine registration is extremely awkward
compared to other platform drivers. (the other being that ASoC doesn't
support multiple machines [i.e. I could actually run both AC97 and I2S
simultaneously one of my boards, as independent sound cards])


>> +static int db1200_ac97_init(struct snd_soc_codec *codec)
>> +{
>> +     snd_soc_dapm_sync(codec);
>> +     return 0;
>> +}
>
> This could be removed but it does no harm.

I'll  drop it.


>> +/*-------------------------  COMMON PART  ---------------------------*/
>> +
>> +static struct resource psc1_res[] = {
>> +     [0] = {
>> +             .start  = CPHYSADDR(PSC1_BASE_ADDR),
>> +             .end    = CPHYSADDR(PSC1_BASE_ADDR) + 0x000fffff,
>> +             .flags  = IORESOURCE_MEM,
>
> If you conver the I2S driver to use the standard device probing model
> this could all me moved into the architecture code rather than placed in
> machine drivers.

Again, I'd love to, but can't: the AC97/I2S/DBDMA drivers extract base address
and DMA information from the platform device resource structure;  however
I can't just copy the resource info from the this db1200_sound platform_driver
to the soc_audio platform driver because the driver core complains about
resource conflicts (two platform_devices sharing the same resources).
Unless I missed a flag which needs to be passed to the resource.flags member?

Thanks!
        Manuel Lauss
