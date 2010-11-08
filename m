Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Nov 2010 23:27:47 +0100 (CET)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:51256 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492100Ab0KHW1n convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 8 Nov 2010 23:27:43 +0100
Received: by iwn8 with SMTP id 8so6711201iwn.36
        for <multiple recipients>; Mon, 08 Nov 2010 14:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=ZTb9WojDWbYsd/XAjh8i+u3HyvrzA9UuXFiKGnUjPmA=;
        b=cb/bUFncvczQ1Pd4iHqlp8uhcvJ//GNmM/uOrIe6mlI6B66a/mwQ+0XKImNj+zx541
         UZvlNusmyVMblTBI4xfUYLwSr9l/xXzOJzKmVcs6WvqEhNhntw6808/F7uW+Koi6qXpE
         BK+B0wxDEzgmRYuY2mxTKwyVnz5w07fFfgC6Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=gmenFC7vTO9N8WvtoyZBW28+9AxXFkWyisGQ6RbHHE9EELyqihwwBxGTV8sEfD9w7b
         q5drXKe1GuVteomGy56qpf3xZAzSFZVFsYD+iDInQvuJeLbbZfP7ItUx1RBW/XBqbnGF
         sXuIGVBAl8kZ7903Xe2P4ryGwFFdk2sTLyRNU=
MIME-Version: 1.0
Received: by 10.231.36.197 with SMTP id u5mr2080891ibd.110.1289255260185; Mon,
 08 Nov 2010 14:27:40 -0800 (PST)
Received: by 10.231.170.70 with HTTP; Mon, 8 Nov 2010 14:27:40 -0800 (PST)
In-Reply-To: <4CD84BEA.6010607@caviumnetworks.com>
References: <1289133059.1547.0@thorin>
        <4CD84BEA.6010607@caviumnetworks.com>
Date:   Mon, 8 Nov 2010 23:27:40 +0100
X-Google-Sender-Auth: -LIdXYo83hsrRBx9oCudeA6gw0k
Message-ID: <AANLkTikCD_HjshMiP0ubyYZkPDoRb8nkFScUPE3GB2F4@mail.gmail.com>
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
From:   Robert Millan <rmh@gnu.org>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <rmh.aybabtu@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28325
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rmh@gnu.org
Precedence: bulk
X-list: linux-mips

2010/11/8 David Daney <ddaney@caviumnetworks.com>:
> I seems weird to me that you cannot get this information from the PRId
> register.  Perhaps the documentation is defective.

Yes, I agree it's really shortsighted of them, but I don't
see any way around it.

> The Chinese version of the Loongson2E user guide seems to say something
> about the two lower nibbles of the PRId, but being a non-chinese reader, I
> have no idea if it would be relevant.
>
> I would think that the low order bits of the register can reliably
> differentiate these two parts.

There are English versions for both 2E and 2F.  See page 66
of the Loongson 2F document:

http://dev.lemote.com/files/resource/documents/Loongson/ls2f/Loongson2FUserGuide.pdf

<quote>
The revision number can distinguish some chip revisions, however there
is no guarantee
that changes to the chip will necessarily be reflected in the PRId
register, or that changes to
the revision number necessarily reflect real chip changes. For this
reason, software should
not rely on the revision number in the PRId register to characterize the chip.
</quote>

Page 72 of the Loongson 2E document
(http://www.lemote.com/upfiles/godson2e-user-manual-V0.6.pdf) has the
same text.

In both documents, the lower byte is defined as "Revision number",
and its value is 0x02 (for both 2E and 2F).

If you'd rather not assume the docs are correct, I can test if
my Yeeloong (Loongson 2F) has 0x02, but then in case it's
something higher, would you be willing to assume:

  rev <= 0x02  -->  2E
  rev > 0x02  --> 2F

or similar logic?  This seems risky if we take into account
that there's no guarantee from the vendor.

-- 
Robert Millan
