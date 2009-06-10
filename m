Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Jun 2009 13:56:55 +0100 (WEST)
Received: from mail-bw0-f225.google.com ([209.85.218.225]:57031 "EHLO
	mail-bw0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023019AbZFJM4s convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Jun 2009 13:56:48 +0100
Received: by bwz25 with SMTP id 25so808951bwz.0
        for <multiple recipients>; Wed, 10 Jun 2009 05:56:41 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=T6BmEUWRE8ID4y2TO9A3JXKw0mM84VlG5zgpF6OEU0w=;
        b=RIefNxtbNLPN41GTTlibZ65kzxMFrbP9vpHn9GQynj+yyoXJDrw0QeqD7Vwi94gpe6
         BkuNpV+i1STnbuPhryVryd7z7sh8g694a02Scq1N0n336GxvsADygjy/ejkWdKXqX9sL
         1ZDmwkuYxtDUo2rPRXWNIVS3FqbaHtkLuRSCw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=eHByj8bVz9UhMpBbiNsYpGHOlJrFJeuZalsJtmD4a7827TCM3f95mnh0U6R88vYsSh
         8sSyzgJJMVAkw7N0gtXhZVFyQhkaSHlHi+sWGWCzKz9VDfZaud7CUYT0FGybr2aSPFTk
         UKh/0cSbEcgUYI27kTb8i5EubmFGnSwKYZ4lY=
MIME-Version: 1.0
Received: by 10.204.113.12 with SMTP id y12mr1257243bkp.214.1244638600779; 
	Wed, 10 Jun 2009 05:56:40 -0700 (PDT)
In-Reply-To: <20090609122017.GA14202@linux-mips.org>
References: <S20022929AbZFHPuy/20090608155054Z+9196@ftp.linux-mips.org>
	 <20090609.111248.161838296.nemoto@toshiba-tops.co.jp>
	 <20090609122017.GA14202@linux-mips.org>
Date:	Wed, 10 Jun 2009 14:56:39 +0200
X-Google-Sender-Auth: 401cc6443377df9b
Message-ID: <10f740e80906100556m1f8a2272y7844bb1a3cc728dc@mail.gmail.com>
Subject: Re: MIPS: Outline udelay and fix a few issues.
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23352
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Tue, Jun 9, 2009 at 14:20, Ralf Baechle<ralf@linux-mips.org> wrote:
> On Tue, Jun 09, 2009 at 11:12:48AM +0900, Atsushi Nemoto wrote:
>> > Relying on pure C for computation of the delay value removes the need for
>> > explicit.  The price we pay is a slight slowdown of the computation - to
>> > be fixed on another day.
>>
>> Please fix this commit.
>
> Sigh.  I wonder how this wrong version made it into my tree.  Oh well,
> applied.  No time to fuzz around before 2.6.30 even though I'd like to
> avoid the 64-bit arithmetic.
>
> Applied.  Thanks!

I can confirm that after this patch, 2.6.30 builds and boots fine on RBTX4927.

Please submit it for 2.6.30-rc1 and 2.6.30.1 ;-)

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
