Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 19 May 2011 17:05:37 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:41091 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491053Ab1ESPFb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 19 May 2011 17:05:31 +0200
Received: by pwi8 with SMTP id 8so1486743pwi.36
        for <multiple recipients>; Thu, 19 May 2011 08:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=xEl9jveZvvc5j4TtjN4RyF6x2IGATxe/8CDWXyAtMFY=;
        b=abj1EB4BhS//VXdtx4gpVaISIo0j043TPQ8GAo22rxUN8pYpdggRDmjyBOrjdc9gou
         R4DoUDKfnEjezEi214b6g4u7GgQQBWzKzhVvAIH6dCOyhEgdnpgcMGXzEct8R1MS6hMn
         Ku73g2wW5MswdLtc7//1s809xKPCHAlaPcHv8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=G5LE8mEEG9ZgmXFBnurgbz2FhAe3UN82Yr5WojEPJNI9+izJrKTpECsqdYMWuHRKKy
         2RKzYNKktusfRA6wQiZzjl4AJs2xJM/aX+kvZ2ilpyZLAL5Q3QeblnrEvlrVTGmBonAE
         70i0shC0lHuvXweGvNt7reki3Wt04so0eEJhY=
MIME-Version: 1.0
Received: by 10.68.69.8 with SMTP id a8mr4973983pbu.418.1305817524759; Thu, 19
 May 2011 08:05:24 -0700 (PDT)
Received: by 10.68.47.5 with HTTP; Thu, 19 May 2011 08:05:24 -0700 (PDT)
In-Reply-To: <20110519110638.GA11371@linux-mips.org>
References: <002fbbeb01a5a51fff8015af85d5d101@localhost>
        <20110519110638.GA11371@linux-mips.org>
Date:   Thu, 19 May 2011 08:05:24 -0700
Message-ID: <BANLkTikouHA-Owkqji5W4sYdZ2nFrT_==g@mail.gmail.com>
Subject: Re: [PATCH v4] MIPS: HIGHMEM DMA on noncoherent MIPS32 processors
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     dediao@cisco.com, ddaney@caviumnetworks.com, dvomlehn@cisco.com,
        sshtylyov@mvista.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30087
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, May 19, 2011 at 4:06 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> Who is the author of this patch, you or Dezhong Diao?

The author is Dezhong... I should have added the extra "From:" header.
