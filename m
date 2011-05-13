Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 03:26:25 +0200 (CEST)
Received: from mail-px0-f182.google.com ([209.85.212.182]:49098 "EHLO
        mail-px0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491791Ab1EMB0T (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 13 May 2011 03:26:19 +0200
Received: by pxi20 with SMTP id 20so1470331pxi.27
        for <multiple recipients>; Thu, 12 May 2011 18:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=AqmK0JSCkIL2FwBTBJG+4iLx/AEUZpBx08IMWKRxFp0=;
        b=x2SeNnzCn5danH2/Mc/65LKa7J889cg/ZJk00yopTMEsnSGhizIdEKGCuhHj7N4E5a
         J+pC5JR0vlohZ53QMhV188D4TcBE/ghfp8jQa/j2LvP2pd0OtaWmiU8ARVH262PeSlLp
         9+Ix7byA+24wipB69M3YmJ6V4wqtpngjltaBg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=CD31UjFphGgc8McfTkels91XS9WH+e0aZxc0Kp+t4Eb1M6w29wc+xHeWgbkmrX/eUG
         QksEWT0MVLDYbAHrrdD8vSAUMjoplV5fe+hhhrpKTaWz66hKg24O6ov3afKlctJ1pk+f
         S/yi1tXjNpPMnkSywtx9BZoUm83YIoVPUC554=
MIME-Version: 1.0
Received: by 10.68.57.168 with SMTP id j8mr1301225pbq.111.1305249969334; Thu,
 12 May 2011 18:26:09 -0700 (PDT)
Received: by 10.68.51.72 with HTTP; Thu, 12 May 2011 18:26:09 -0700 (PDT)
In-Reply-To: <1305246299-7517-1-git-send-email-ddaney@caviumnetworks.com>
References: <1305246299-7517-1-git-send-email-ddaney@caviumnetworks.com>
Date:   Thu, 12 May 2011 18:26:09 -0700
Message-ID: <BANLkTim4UXhMC9BWvSgFWbWCiR4AdWjGeg@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Fix build breakage in cpu-probe.c
From:   Kevin Cernekee <cernekee@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, May 12, 2011 at 5:24 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> Move set_elf_platform() above all its uses.

Whoops, should have retested the Loongson patch v1 with the
set_elf_platform patch v2.  Thanks for fixing this.

Acked-by: Kevin Cernekee <cernekee@gmail.com>

BTW: the commit messages got a little messed up on the two patches
that had a secondary "From:" header to override the author field.  Is
there something I should be doing differently here?
