Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Dec 2010 21:56:19 +0100 (CET)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:37626 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492017Ab0LJU4Q convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 10 Dec 2010 21:56:16 +0100
Received: by wwi17 with SMTP id 17so3901627wwi.24
        for <multiple recipients>; Fri, 10 Dec 2010 12:56:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=ZjZzNRviWvRpOlgS2gDZj7meviUxj/GGYfYeeIoflBc=;
        b=HAzIvD4Q6ejMsDKXJCe2DWR5NaALWPd2MPZWmRiAhvkqD6LHvSZ/d47ijDc71ehdue
         Pk7eg3v0YVUBniKJeuKD9ZX1FuavYWbe3HvwIngEZzDvWD0G1IbbDHu4RwdoPf1w/6yu
         JJ4OegfjlHuBhnoDFViFXbSKTWHaCm5QAXScg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ZH/vxbINf5VcVtn++UXav2zhre1ylFknjGtHV/kvED6pgQnpNQ4Ok6ep6CbcAy1Jan
         1aHmbCKy9XIJsLEqPkn5ScVStbkrtJyAANKUAW/CvguE1mVZYJBUTJz7gE9sN3g978f2
         +X6yJi4MDIJaMFM+pKKAPSQPJB8AwKQE+L3A0=
MIME-Version: 1.0
Received: by 10.216.172.65 with SMTP id s43mr1504173wel.14.1292014571239; Fri,
 10 Dec 2010 12:56:11 -0800 (PST)
Received: by 10.216.176.12 with HTTP; Fri, 10 Dec 2010 12:56:11 -0800 (PST)
In-Reply-To: <20101210204052.GA1274@linux-mips.org>
References: <1288025051-17145-1-git-send-email-manuel.lauss@googlemail.com>
        <20101210204052.GA1274@linux-mips.org>
Date:   Fri, 10 Dec 2010 21:56:11 +0100
Message-ID: <AANLkTinwPVZdFUHTJY65=1dsTRSrpt9F0Msow-h3bkra@mail.gmail.com>
Subject: Re: [PATCH V2] MIPS: Alchemy: fix build with SERIAL_8250=n
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28634
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

On Fri, Dec 10, 2010 at 9:40 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>
> On Mon, Oct 25, 2010 at 06:44:11PM +0200, Manuel Lauss wrote:
>
> > In commit 7d172bfe ("Alchemy: Add UART PM methods") I introduced
> > platform PM methods which call a function of the 8250 driver;
> > this patch works around link failures when the kernel is built
> > without 8250 support.
> >
> > Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
> > ---
> > V2: added commit name to patch description as per Sergei's suggestion.
>
> Applied, thanks.
>
> Though anything like a CONFIG_SERIAL_8250 in board code always strikes me
> as wrong.  What if the driver is built as a module?  What if the kernel is
> built without the driver, then later on the module is built separately and
> then inserted?

Hm, I think I understand.  How's this approach (untested)?

--
