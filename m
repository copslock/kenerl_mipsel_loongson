Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Dec 2009 13:58:45 +0100 (CET)
Received: from mail-pw0-f45.google.com ([209.85.160.45]:57440 "EHLO
        mail-pw0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493770AbZLGMzV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Dec 2009 13:55:21 +0100
Received: by pwi18 with SMTP id 18so2477030pwi.24
        for <multiple recipients>; Mon, 07 Dec 2009 04:55:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:cc:content-type;
        bh=rxjNrjYi7BwsSgoC3zO9Y5BlEF23URNA5DiaarGeTro=;
        b=TOUr3nWxktX5NyPlslRH9DQltANRMFEhK40M8zweUfYEYHej/P6Sk9/2bfWaHgkXJs
         EdBPz1rR3dwJD+xkxL24vIzxex4O8cNzXMauO+kP0L3tmC82nFAIda+WURbn9FN5alUb
         3MGuPGf8RdoeDtvqBrc+BnE1cXEIfEcq0LqW8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=UTgZz4HWSxgU3XFCEAlJiA9ta9Rh4TYmzGe9pYBBUKROi9IuZgTYRf5vOY6l/UQsJz
         b2i0k9XwZNyQt+eXz1dMRkkDcdMpLhYnzqqoP5k8qjmfU8xlGF1bEi8N+J7uPxQa1n29
         +YpBQSRW5YptTWzExTksnGqF87LV8T5yoGfvM=
MIME-Version: 1.0
Received: by 10.115.81.24 with SMTP id i24mr11623414wal.194.1260190512545; 
        Mon, 07 Dec 2009 04:55:12 -0800 (PST)
Date:   Mon, 7 Dec 2009 20:55:12 +0800
Message-ID: <c6ed1ac50912070455n736af31fuf2c981fc182b494f@mail.gmail.com>
Subject: Dma addr should use Kuseg1 for MIPS32?
From:   figo zhang <figo1802@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>, macro@linux-mips.org
Cc:     linux-mips@linux-mips.org
Content-Type: multipart/alternative; boundary=0016e64de622d98132047a22f79c
Return-Path: <figo1802@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25348
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: figo1802@gmail.com
Precedence: bulk
X-list: linux-mips

--0016e64de622d98132047a22f79c
Content-Type: text/plain; charset=ISO-8859-1

hi,

I am writing a driver for MIPS32. i wirte this code for DMA addr:

dma_vaddr =(char*) __get_free_pages(GFP_KERNEL|
GFP_DMA, order);
dma_phy = virt_to_phy(dma_vaddr);

i write dma_phy to DMA base register, but why it cannot work? it should
write Kseg1 space to DMA register?
I remember that it is ok for ARM/X86 .


Best,
Figo.zhang

--0016e64de622d98132047a22f79c
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

hi,<br><br>I am writing a driver for MIPS32. i wirte this code for DMA addr=
:<br><br>dma_vaddr =3D(char*) __get_free_pages(GFP_KERNEL|<div class=3D"im"=
>GFP_DMA, order);<br>dma_phy =3D virt_to_phy(dma_vaddr);<br><br>i write dma=
_phy to DMA base register, but why it cannot work? it should write Kseg1 sp=
ace to DMA register? <br>

I remember that it is ok for ARM/X86 .<br><br><br>Best,<br>Figo.zhang</div>

--0016e64de622d98132047a22f79c--
