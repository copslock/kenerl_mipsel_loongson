Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Oct 2010 20:19:51 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:45910 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491047Ab0JNSTs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Oct 2010 20:19:48 +0200
Received: by iwn5 with SMTP id 5so227986iwn.36
        for <multiple recipients>; Thu, 14 Oct 2010 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:received:in-reply-to
         :references:from:date:message-id:subject:to:content-type;
        bh=1KKaIfsVpzg7a/7BtPJDWovzvbuTqU1uNmcK39ATeHs=;
        b=BL4GkyjVQQHu0qmy6zED2wlPhk+A/fJTC897vsa367N76h7bVkQ08yc7IHYSfgae8t
         W9vdTga6ydhgtVDZQP5Wnl5apGRtErxB9xIvitqVF8zyQc+Y6YyKvEtS2lrP6I8RnvI7
         NojfulDKioczZWl25a5M32xMmGK18KsDSwtc0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type;
        b=jkJgMqJxgjcL0eDqTw6HbntzqFoHhh2UR93RfV/72l3BTvVthWZhf1q73HUKq5Y16U
         raREaq7bkj9Mv3L0aLQVBeuhQcYy78fieRe053qu7XsoLmkPUrp/dB+W+yZswArKjq+S
         T94cQoZt5CnktBn2XrRcQ0/LQurJ4adM8rvYo=
Received: by 10.231.10.139 with SMTP id p11mr8799650ibp.179.1287080386968;
 Thu, 14 Oct 2010 11:19:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.231.30.136 with HTTP; Thu, 14 Oct 2010 11:12:39 -0700 (PDT)
In-Reply-To: <AANLkTimhn4JFN+kPsm36qJ6Pu=P0GcNM9RLO3LaN+x0V@mail.gmail.com>
References: <AANLkTimhn4JFN+kPsm36qJ6Pu=P0GcNM9RLO3LaN+x0V@mail.gmail.com>
From:   Dragos Tatulea <dragos.tatulea@gmail.com>
Date:   Thu, 14 Oct 2010 20:12:39 +0200
Message-ID: <AANLkTikbmCA3qJmCLniUZdzq39f_FcNmDQ4mR=f04JL3@mail.gmail.com>
Subject: Re: RFC: add code to dump the kernel page tables for visual
 inspection by kernel developers
To:     ralf@linux-mips.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <dragos.tatulea@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dragos.tatulea@gmail.com
Precedence: bulk
X-list: linux-mips

Hmm, seems nobody is interested in this... Maybe it should be removed
from the TODO list as well.

-- Dragos
