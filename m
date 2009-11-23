Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2009 15:37:41 +0100 (CET)
Received: from mail-fx0-f216.google.com ([209.85.220.216]:46806 "EHLO
	mail-fx0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493225AbZKWOhd convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 23 Nov 2009 15:37:33 +0100
Received: by fxm8 with SMTP id 8so5806215fxm.27
        for <multiple recipients>; Mon, 23 Nov 2009 06:37:27 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=1lUWPh3eL5UiCh5jtOvTwPF4uv+jdqPT560QOM+Zc7k=;
        b=rVqZasWQNm3cSH9991GPSAXzsr2xaBH44QxeXVjoGwSDYo72Qn05qBEQw0J4thleXr
         ZPNhhK1GNMOvWRe2JjaSakGLuWz6oDYMOfapFjmGB96hG+LX4ZtHXRdoSK27r9KO7H06
         w3DmVxlLEqZquaB5z8kq1QbSUOVo4r/f2l2L4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=rP0t4zAe8pWfdM6f/Y6gJcnHo8ARcotCeFara522fK80Lf4wdee04rmjba9TaPGH4p
         6+5MY4o7/P+8dkS+buA4JMohQ6cOCDz+cxeDv3FsGQa37fvPouuhL0ys4967ToqEQcLF
         qI0tZ4vsqBp7pP3zloyXHUhnWOIhjH1/BFH48=
MIME-Version: 1.0
Received: by 10.223.21.3 with SMTP id h3mr783729fab.39.1258987047489; Mon, 23 
	Nov 2009 06:37:27 -0800 (PST)
In-Reply-To: <20091123.230616.70220116.anemo@mba.ocn.ne.jp>
References: <1258977217-25461-1-git-send-email-dmitri.vorobiev@movial.com>
	 <20091123.222609.74748367.anemo@mba.ocn.ne.jp>
	 <90edad820911230543i64f1e33fg86770f3ab2b6510b@mail.gmail.com>
	 <20091123.230616.70220116.anemo@mba.ocn.ne.jp>
Date:	Mon, 23 Nov 2009 16:37:27 +0200
Message-ID: <90edad820911230637r3f2c94adh737c9f4f5adcd197@mail.gmail.com>
Subject: Re: [PATCH] [MIPS] Move several variables from .bss to .init.data
From:	Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	dmitri.vorobiev@movial.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25069
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Mon, Nov 23, 2009 at 4:06 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
> On Mon, 23 Nov 2009 15:43:27 +0200, Dmitri Vorobiev <dmitri.vorobiev@gmail.com> wrote:
>> On Mon, Nov 23, 2009 at 3:26 PM, Atsushi Nemoto <anemo@mba.ocn.ne.jp> wrote:
>> > On Mon, 23 Nov 2009 13:53:37 +0200, Dmitri Vorobiev <dmitri.vorobiev@movial.com> wrote:
>> >> Several static uninitialized variables are used in the scope of
>> >> __init functions but are themselves not marked as __initdata.
>> >> This patch is to put those variables to where they belong and
>> >> to reduce the memory footprint a little bit.
>> >>
>> >> Also, a couple of lines with spaces instead of tabs were fixed.
>> >>
>> >> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
>> >
>> > NAK, at least for txx9 parts.  The struct mtd_partition arrays will be
>> > referenced by mtd map drivers via platform_data.
>>
>> You are right, thanks. What do you think about moving the variables to
>> file scope then?
>
> Well, why?  Does it make any check-scripts or something happy?

That's just looked somehow confusing to me that a variable defined in
the function scope was referenced from far outside this function, and
even when the function itself isn't valid anymore. Of course, there
are no technical disadvantage in that in itself.

Dmitri

>
> ---
> Atsushi Nemoto
>
