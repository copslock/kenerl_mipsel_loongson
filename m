Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Jan 2011 09:12:50 +0100 (CET)
Received: from mail-iy0-f177.google.com ([209.85.210.177]:58702 "EHLO
        mail-iy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491104Ab1ABIMq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Jan 2011 09:12:46 +0100
Received: by iyj21 with SMTP id 21so12392924iyj.36
        for <linux-mips@linux-mips.org>; Sun, 02 Jan 2011 00:12:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=VijcTEpHKm++EOI2Q0XpO+fpUm/q2gDRTRze4/2/aZ0=;
        b=CVxXwymyu+hocHh5ZJmjvD7MqIeFfDBxhs4vV7JK9NZfTpnmYo/6NoZ4J7fnQbXmXS
         vOpllXGxKbOgXMQk+kk35KqCT5JAiXW62lXn9AZb1RFJ/BRgQn/4lQBzEEg0ItY0BMwH
         9Fl9K68gbUQc7QCWP9SjcGtyWYwTI6SlQ9tSI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=ErWlb1iYbmriEjbsNOeZSA9xKdbcdgs9O6EA9mu/DVVlErFs8Ek1PBgtsOZXFM0pJf
         EUZ7f6Do7WvHbrR++S+3RdLZjLVDeHEjY8fjrNVB4nEWMDKOphwmzatv8CRUghdmgPhG
         3TiqpDuY3TFEZjbOVzI3pLfvNmBa8mY2edKWw=
MIME-Version: 1.0
Received: by 10.42.164.132 with SMTP id g4mr19576764icy.127.1293955960824;
 Sun, 02 Jan 2011 00:12:40 -0800 (PST)
Received: by 10.42.174.131 with HTTP; Sun, 2 Jan 2011 00:12:40 -0800 (PST)
Date:   Sun, 2 Jan 2011 16:12:40 +0800
Message-ID: <AANLkTims5ejcB8hmH5nE3zR5R_57oF88x=NS438ZOM3V@mail.gmail.com>
Subject: functions about dump backtrace function names in mips arch
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28783
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

 Dear all:
 If i remember correctly, when kernel panic there is a function I can
 use to dump all the names of backtrace functions.
 I have searched arch/mips/traps.c, but I only can see the dump
 functions of cpu registers,

 If my assumption is true, would anyone tell me what the name is or
 what Doc I can looking for?
 appreciate your help,
miloody
