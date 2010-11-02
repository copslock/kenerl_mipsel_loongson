Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2010 13:50:27 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:44737 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491791Ab0KBMuY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Nov 2010 13:50:24 +0100
Received: by wwi18 with SMTP id 18so1008334wwi.24
        for <linux-mips@linux-mips.org>; Tue, 02 Nov 2010 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:date:message-id
         :subject:from:to:content-type;
        bh=7e/DeKvLFVT29DeRRta0FEF6DI7sGcEPfFITgXpXz/c=;
        b=SzUP+jBFQXtyOkrkZ7szJQOXWfNL1UY98Yhnxi+toPpVZwPLOGW3g+0MhlJxTXk4/y
         SFgx+H4BW+njutBtH1zmgOt237I8UxlsIlLCBLYe4cJexsNEPzHV0ykCDdyi0fN6zgLb
         31NWlhZ+XReekpG5q5gQ5B6SyY55IOWxaCaew=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=UXqLxrRWsehsT0dnhcCT2WYlhMSld1v7fBOnoGWwMf0bXXfplnpR0f5OZI+oNQJeVw
         T3YQXKeeIfLd4qzK4Eb6r/cjFyERUsEaLxOKg1oX1lV4fblz/dh5EL8W5Xyu9bGls1az
         7NAvG6j069scn13o7uJXXo7TQEEOCdV+E0YAA=
MIME-Version: 1.0
Received: by 10.216.16.85 with SMTP id g63mr921652weg.114.1288702218364; Tue,
 02 Nov 2010 05:50:18 -0700 (PDT)
Received: by 10.216.19.213 with HTTP; Tue, 2 Nov 2010 05:50:18 -0700 (PDT)
Date:   Tue, 2 Nov 2010 20:50:18 +0800
Message-ID: <AANLkTikAHSitrZkkTtr4u3N3ruwV047S51rq2Nugq3aW@mail.gmail.com>
Subject: where is blast_dcache32 ?
From:   loody <miloody@gmail.com>
To:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <miloody@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: miloody@gmail.com
Precedence: bulk
X-list: linux-mips

Dear all:
I try to grep blast_dcache32 but the results show as below.
#pwd
linux-2.6.30.9/arch/mips
#grep -rnw 'blast_dcache32' *
mm/c-r4k.c:140:		r4k_blast_dcache = blast_dcache32;
Binary file mm/built-in.o matches
mm/.svn/text-base/c-r4k.c.svn-base:140:		r4k_blast_dcache = blast_dcache32;
Binary file mm/c-r4k.o matches
#

Would anyone tell me where I can find it?
did I grep the wrong folder?
Thanks for your help,
miloody
