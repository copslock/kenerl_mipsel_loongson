Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2009 15:06:21 +0200 (CEST)
Received: from mail-fx0-f220.google.com ([209.85.220.220]:35149 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493267AbZGUNGO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2009 15:06:14 +0200
Received: by fxm20 with SMTP id 20so3034414fxm.0
        for <multiple recipients>; Tue, 21 Jul 2009 06:06:09 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VlwtZ8kS5JO8q5yrMlY8xn9BgX7X41U5erP8Y+cGjjY=;
        b=Q2exc7rqtWfhewEsYyxMKVrP8iPFyaNudmA/Ofys+kB42tKgFKX3Xk/M/IFlNuAaxw
         pU7yPHufBAtc8S1Z+e3ojZXTJvl1AaLSzgqONssA6iJ3iPlkdoBT1Gsy2Gw05XHgN9QY
         xjZMVd+sNuXyqC+/xZBftimvqPov9t6LhYXfI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Pr3/kjgv5i+5Mn9+YHcMBDbUEa7/EYK0kdne6zl9Wn5tXYG5xPrLgAI1qf3B0rhSPe
         mapmCLjiwEE6zzWZPPncR1d7gSw95q/Ah8zwI92nBh6uBEl+4RiQDEdXrRIo9PBrFiZq
         7Rj+nownaqhTFXNOItUrAWENiSYLS9g9dldUE=
MIME-Version: 1.0
Received: by 10.223.119.5 with SMTP id x5mr2047909faq.40.1248181569166; Tue, 
	21 Jul 2009 06:06:09 -0700 (PDT)
In-Reply-To: <4A65B8BB.40502@gmail.com>
References: <4A65B8BB.40502@gmail.com>
Date:	Tue, 21 Jul 2009 15:06:09 +0200
Message-ID: <f861ec6f0907210606m334bcd83u7f28f3062e6f6829@mail.gmail.com>
Subject: Re: [PATCH] mips: decrease size of au1xxx_dbdma_pm_regs[][]
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Roel Kluin <roel.kluin@gmail.com>
Cc:	rjw@sisk.pl, ralf@linux-mips.org,
	linux-pm@lists.linux-foundation.org, linux-mips@linux-mips.org,
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23762
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi Roel,

On Tue, Jul 21, 2009 at 2:46 PM, Roel Kluin<roel.kluin@gmail.com> wrote:
> Only registers [0-DDMA_CHANNEL_BASE][0-6] are used by the suspend
> and resume routines.
>
> Signed-off-by: Roel Kluin <roel.kluin@gmail.com>
> ---
> These routines are on the bottom of the file. Only used are
> registers:
>
> au1xxx_dbdma_pm_regs[0][0-3]
>
> and
>
> au1xxx_dbdma_pm_regs[1-NUM_DBDMA_CHANS][0-6]
>
> Is my patch right, that assumes that the array can be smaller, or
> should the storage and recovery of other registers be added?

Actually, I think there's a bug in the save/restore functions.

This:
  for (i = 1, addr = DDMA_CHANNEL_BASE; i < NUM_DBDMA_CHANS; i++) {

should be changed to
 for (i = 1, addr = DDMA_CHANNEL_BASE; i <= NUM_DBDMA_CHANS; i++)

as there are 16 individual channels (NUM_DBDMA_CHANS) to save/restore
plus the global ddma block config (the +1).
And looking closer at it, the last register in a channel can be
skipped since it's
read-only (at offset 0x18).

So, 6 slots per channel for 16 channels plus one row for the ddma global
config are enough:

static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][6];

Thanks!
      Manuel Lauss
