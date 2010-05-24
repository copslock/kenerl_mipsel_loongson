Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 May 2010 15:15:59 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:40962 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491912Ab0EXNPz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 May 2010 15:15:55 +0200
Received: by vws4 with SMTP id 4so1435019vws.36
        for <linux-mips@linux-mips.org>; Mon, 24 May 2010 06:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=t7dCou9vhJSq97nWBRRcN/MDJB16aoEzEZUxUq5sdJg=;
        b=tmplEsB5YLCNuYGsLDOGUYajHteDf1mzFfiltKd/uhY/IXQZGytaKfEShZDoWk8LLY
         o0kn1vsFVVGoIwY2/hl66OXDDvdcag+Fv7aQWXJTx5qNsdcNf87lniki7bjzimHuDvlr
         O+umYuF0IEgQTEvmaYh+uBJtnmaIKI1cRYkrw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=R7x9Qd9DQ+D877Uu57DGY/8hPgMzDLw+Jv5Ld7MANiXqw2Z4CrKxUxKAzVeQSu7J4q
         ZbOOsMB4C6wRr21PZny09TSWPeFvplElh4W41vG/f+n5YT+O3/d2A5eu4OP0LDzEgIL0
         seYVRtGfwbGNYm7xIf+I2DrAMyX3ov2JKKvz4=
MIME-Version: 1.0
Received: by 10.220.57.197 with SMTP id d5mr3779969vch.132.1274706949485; Mon, 
        24 May 2010 06:15:49 -0700 (PDT)
Received: by 10.220.12.18 with HTTP; Mon, 24 May 2010 06:15:48 -0700 (PDT)
Date:   Mon, 24 May 2010 21:15:48 +0800
Message-ID: <AANLkTimFb95H1h2To4pEWw5cgsPpgBJYmsodFNcQnXfD@mail.gmail.com>
Subject: Ask help for understanding the boot process of Linux Kernel on MIPS
From:   Dominic <dominicwj@gmail.com>
To:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dominicwj@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26833
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dominicwj@gmail.com
Precedence: bulk
X-list: linux-mips

Hi,

I am trying to understand the boot process of Linux Kernel, especially
on MIPS, I am pretty new to these. Could anybody introduce some
documents or the boot logs on some MIPS platform? Any reply is much
appreciated!

Thank you!

BR/Dominic
