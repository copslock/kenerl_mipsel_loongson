Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 May 2009 17:45:22 +0100 (BST)
Received: from mail-ew0-f174.google.com ([209.85.219.174]:35097 "EHLO
	mail-ew0-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022905AbZEDQpP (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 4 May 2009 17:45:15 +0100
Received: by ewy22 with SMTP id 22so4129625ewy.0
        for <linux-mips@linux-mips.org>; Mon, 04 May 2009 09:45:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=/+wG92suaR8HSBUo/B3voLxMhGGqHF1aFFLoK6gZhxQ=;
        b=T/+IYSFdwgTEUJMGOLjjfWCkin3GrV5Zfr0vO3KNUXNKzCx+xDirTzo8ujTsL5W/ed
         WTrJcIQGmy+g0EUi2NMp92Ukx4AynIYOsQ87JZ3aZhtT8KFE2sM6l6vmpTnIsLzDFjqF
         fNLyKraIKtxskJU2AxUKJYRS0jJqqvoG2+Pek=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=Y0xrWIF2CP7GCPk7ecGal18uY9JrYe6UngLl5oWdKqORPEx0tmGEmnJbnrKo4mIbqn
         GrcHEY2APmiaqOLa3TMMsQSuoPZ9ElOQiSwZmhC4eqnQun6BW9Dz9JQjB/VySXMSDgGX
         TTpvxTUAKyeWjwVtszT+3E7wM9r43HsaJdGoE=
MIME-Version: 1.0
Received: by 10.210.120.17 with SMTP id s17mr6362151ebc.99.1241455509657; Mon, 
	04 May 2009 09:45:09 -0700 (PDT)
Date:	Mon, 4 May 2009 18:45:09 +0200
X-Google-Sender-Auth: 050649cddb96c7b7
Message-ID: <10f740e80905040945i186e995ap1ecb43c2ad3e2458@mail.gmail.com>
Subject: rbtx4927 and sound?
From:	Geert Uytterhoeven <geert@linux-m68k.org>
To:	linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22612
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

Did anyone ever try to get sound working on the Toshiba RBTX4927?
It seems the AD1881A codec is connected to PIO2-4 of the TMPR4927 SoC.

Thx!

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
