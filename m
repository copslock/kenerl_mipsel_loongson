Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Apr 2010 06:59:14 +0200 (CEST)
Received: from mail-gy0-f177.google.com ([209.85.160.177]:56688 "EHLO
        mail-gy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491118Ab0DME7J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Apr 2010 06:59:09 +0200
Received: by gyb11 with SMTP id 11so3428674gyb.36
        for <multiple recipients>; Mon, 12 Apr 2010 21:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:subject:from:reply-to:to:cc
         :content-type:organization:date:message-id:mime-version:x-mailer;
        bh=4gS7GDD/9POeqiat1zoOSfMguQjiM7NXQQm4hMi2wbg=;
        b=DJpnHkdMfYENDcYaM1sQJDY0PTYhveiuXQMYtDcLUzMCvt/if/h4uyyG6w1Ojvu8bN
         7j/BOn7KwChVyzYlZsYnV/3mKQTq5Zh0OIormYGjJVM3KrsL5yA2xD+rXCMYFEZEdm92
         GjXg6DUfNxcRXbKyeBXgxot1jcTjB85Jxv2Y0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:reply-to:to:cc:content-type:organization:date
         :message-id:mime-version:x-mailer;
        b=MnKBNuD8coSbO/iM37HhnaApcSAnk6V2IDmO6YjtzQShZegcTL+x2eBDmz/B0AQvBi
         4yETfAInC3Nns76uDhNais1bXzcB+kktkPcaowK1PWzB/9VeKZDxscLit7aHZRXD7c4b
         IPnvGoRV0c9/AbJBtBmr+KTl3nfvXHU1WMquA=
Received: by 10.91.39.4 with SMTP id r4mr2327601agj.107.1271134741915;
        Mon, 12 Apr 2010 21:59:01 -0700 (PDT)
Received: from [192.168.2.212] ([202.201.14.140])
        by mx.google.com with ESMTPS id 20sm4591294iwn.1.2010.04.12.21.58.59
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 21:59:01 -0700 (PDT)
Subject: About MIPS specific dma_mmap_coherent()
From:   Wu Zhangjin <wuzhangjin@gmail.com>
Reply-To: wuzhangjin@gmail.com
To:     Ralf Baechle <ralf@linux-mips.org>, Takashi Iwai <tiwai@suse.de>
Cc:     linux-mips <linux-mips@linux-mips.org>
Content-Type: multipart/mixed; boundary="=-MOmtyQD51rQcYat/yaYI"
Organization: DSLab, Lanzhou University, China
Date:   Tue, 13 Apr 2010 12:58:54 +0800
Message-ID: <1271134735.25797.35.camel@falcon>
Mime-Version: 1.0
X-Mailer: Evolution 2.28.3 
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips


--=-MOmtyQD51rQcYat/yaYI
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit

Hi, Ralf and Takashi

Seems Takashi have sent the MIPS specific dma_mmap_coherent() at 18 Aug
2008:

http://www.linux-mips.org/archives/linux-mips/2008-08/msg00178.html

But that patch have not been accepted since it was not suitable to all
of the MIPS variants.

Without that patch, the ALSA output will be broken in some of the MIPS
variants, can we make the implementation in the above url be weak, then
the particular MIPS variants can override it with their own versions but
the common MIPS variants can share it to fix the ALSA problem?

I have attached a change of the above patch, which is applicable to the
linux-2.6.33 and linux-2.6.34-rcX and I have tested it on my YeeLoong
netbook, the following command function well with it.

$ mplayer -ao alsa file.mp3

but without it, the ALSA output is broken.

Regards,
	Wu Zhangjin

--=-MOmtyQD51rQcYat/yaYI
Content-Disposition: attachment; filename*0=0001-MIPS-Implement-dma_mmap_coherent-for-ALSA-audio-outp.pat; filename*1=ch
Content-Type: text/x-patch; name="0001-MIPS-Implement-dma_mmap_coherent-for-ALSA-audio-outp.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit
