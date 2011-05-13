Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 18:55:34 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:40460 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491866Ab1EMQz2 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 18:55:28 +0200
Received: by pvh11 with SMTP id 11so1463178pvh.36
        for <multiple recipients>; Fri, 13 May 2011 09:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=9AnqNeRx7meIEbfnubWlbdGN26QbgqCou10ZQUd3oLA=;
        b=RlMcnV+ChauuA4XDR0Nhwnwa7onZ5fOVvhtQG4JB9RpR0HlK0s86cIfIi8DPP5fa+3
         jk3DOUOMIyBsTGogwaXaCPqgNSDVcXi6aGs/RUUUFimppTw1NpcJtuLEm99+CKY5i1Ke
         dkrmLTWEkr3SVU4YJavNZcyMRNMQFECV2qLGY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=B5QMv0FaofYZGERf+UYwZYByaTGf5+aiFI8ghrfdeiWZ9hVWpQLTCTMNmFJwEAgoEf
         2IFlrhDe/Zx0bpa6kOmLUuWmDwxaCKRZX4chUcqsdGY98JnxZG3Y9Hw4dlsZdlD//Qwj
         L8R0B9u2EavjFHcG0O0s9DJXK07p7aPnfjREc=
MIME-Version: 1.0
Received: by 10.68.57.168 with SMTP id j8mr2528871pbq.111.1305305721728; Fri,
 13 May 2011 09:55:21 -0700 (PDT)
Received: by 10.68.51.72 with HTTP; Fri, 13 May 2011 09:55:21 -0700 (PDT)
In-Reply-To: <20110513155605.GA30674@linux-mips.org>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
        <20110513150707.GA26389@linux-mips.org>
        <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
        <20110513155605.GA30674@linux-mips.org>
Date:   Fri, 13 May 2011 09:55:21 -0700
Message-ID: <BANLkTinnALQV6dXkJ0AjaQ1=bTawYMMkuQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Jayachandran C <jayachandranc@netlogicmicro.com>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 8:56 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> I'm not totally certain with my explanation but it seemed like a good
> working hypothesis.  Jayachandran C. bisected this morning's linux-queue
> on his Netlogic XLR which is MIPS64 R1 and found this comment causing
> the problem.

Jayachandran, could you please confirm/deny the following:

Netlogic XLR is a MIPS64 R1 system.

You are running a 32-bit kernel.

You are using 64-bit physical addresses.

You are not enabling RI/XI.

The commit that caused the regression was "[PATCH 1/4] MIPS: Replace
_PAGE_READ with _PAGE_NO_READ" (not 2/4, 3/4, or 4/4).

Do you have a log showing the failure, or any other details of what happened?

Thanks.
