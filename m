Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2011 08:02:45 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:38252 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490975Ab1ENGCj convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 14 May 2011 08:02:39 +0200
Received: by pwi8 with SMTP id 8so1735284pwi.36
        for <multiple recipients>; Fri, 13 May 2011 23:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=gwqY80S0QTgmsorOV+ATkJ1EScvm5bna312xwtqLSTw=;
        b=KpHPDFaRzwo8n392EcMmiwU2wvslfO7EZWWJ6K/cuYWzpXqUxM4qZlhxbHrTQnoNwE
         KRs2OjmtsamzQx/T+onEvxAlJmMokBvKzyVz5+nLI321WgPmDABxwSvIlXh1j+jVORRT
         cCsbxSYzqWWe6w/7Oakz07b6tlqsA7ECpV7LY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=C5I/SAoXSl/4fEceHKd6ylUDucRUCBEkeEuICJRyfPzrvvyCDN6jrWaWDGyrvat2dN
         iC53lDZqa/qag/B+AbgwzG1EZrOOkeYADP45UItMNgYFJpSekCocT7bsGlhyMEVbiUCm
         elkYjvrWF1wI8moPDjO2pHxsPsOhMRSy9f78s=
MIME-Version: 1.0
Received: by 10.68.57.168 with SMTP id j8mr3473118pbq.111.1305352950751; Fri,
 13 May 2011 23:02:30 -0700 (PDT)
Received: by 10.68.51.72 with HTTP; Fri, 13 May 2011 23:02:27 -0700 (PDT)
In-Reply-To: <20110514051303.GE14607@jayachandranc.netlogicmicro.com>
References: <7aa38c32b7748a95e814e5bb0583f967@localhost>
        <20110513150707.GA26389@linux-mips.org>
        <BANLkTikcyEzjOWt9pWToE=89dySSEYbw_g@mail.gmail.com>
        <20110513155605.GA30674@linux-mips.org>
        <BANLkTinnALQV6dXkJ0AjaQ1=bTawYMMkuQ@mail.gmail.com>
        <20110513173633.GA14607@jayachandranc.netlogicmicro.com>
        <BANLkTim+z7TSCvNA2duA6LsUzNsiu9OQaQ@mail.gmail.com>
        <20110513184532.GC14607@jayachandranc.netlogicmicro.com>
        <BANLkTi=CJPuhO7OjCv5UF_ABQMb-bFe-2A@mail.gmail.com>
        <20110514051303.GE14607@jayachandranc.netlogicmicro.com>
Date:   Fri, 13 May 2011 23:02:27 -0700
Message-ID: <BANLkTimuz8bgrpwJTSh4guDXt+h2hUvSGQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] MIPS: Replace _PAGE_READ with _PAGE_NO_READ
From:   Kevin Cernekee <cernekee@gmail.com>
To:     "Jayachandran C." <jayachandranc@netlogicmicro.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Fri, May 13, 2011 at 10:13 PM, Jayachandran C.
<jayachandranc@netlogicmicro.com> wrote:
> Can you send me the patchset which works on top of queue with any
> debugging you want enabled?  I can try that and send you the results.
>
> It is also possible that something is broken with the XLR platform code,
> it is currently almost straight r4k...

Well, David suggested adding "#define DEBUG 1" at the very top of
tlbex.c, then booting with "debug" and posting the TLB refill handler
to make sure the RI/XI code isn't getting enabled.  That seems like a
reasonable start.  Even if there's no smoking gun, we'd still be able
to compare our TLB handlers side-by-side.

Personally I don't have any other leads or patches to try.  These
changes work fine for me in every configuration I am able to test:

32-bit MIPS32 system, 32-bit kernel (non-RIXI)
32-bit MIPS32 system, 32-bit kernel (XI)
64-bit R5000 system, 32-bit kernel (non-RIXI, with 64-bit physical addresses)
64-bit R5000 system, 64-bit kernel (non-RIXI)

So it's really best for somebody to debug the problem hands-on, on the
system that showed the issue.

Would you be able to post your rootfs image?  Are you using
"usr/dev_file_list usr/rootfs" from CONFIG_INITRAMFS_SOURCE?  That
could eliminate one other potential difference between our
configurations.
