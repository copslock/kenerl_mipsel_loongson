Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 18:26:09 +0200 (CEST)
Received: from mail-yx0-f177.google.com ([209.85.213.177]:42402 "EHLO
        mail-yx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490996Ab0JUQ0G convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Oct 2010 18:26:06 +0200
Received: by yxl31 with SMTP id 31so2129654yxl.36
        for <multiple recipients>; Thu, 21 Oct 2010 09:25:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=R3JMMMRtghaIkagBfXQ7xvqDRYVAFXYHTuK+n7MoO04=;
        b=DqFHR2OMjJNFwkIdeReg6vEq6UP3W43wSHiHkjmCwMeeIccJUl/HLfoP3oxnPf7tKi
         aXdXPQblF/wwBPntzwYLsiBFsuA7I47N8sDDgp4M8uiYyyknFP9bWcUy0jSpkWcnPA9U
         WUovO3txW/bGpqQPn9KUAPbF+W6ig314fi/4k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=eFLQK17mLxpJYA1YOU3Hk5SP2P5amoKPlmheRWIk+H4zF+5nNPl5eEUjRHptpu3awP
         yZMERCl4WMV7cYTHN846o4+n7pQS1kQ3GOw5quVq2/fm7tk/crtkKPXerQy/6NpakgN8
         uif6aUJJeeKgB8+8jPXc7KToXn43ZD7UtvuYg=
MIME-Version: 1.0
Received: by 10.42.222.134 with SMTP id ig6mr970875icb.119.1287678359470; Thu,
 21 Oct 2010 09:25:59 -0700 (PDT)
Received: by 10.42.8.4 with HTTP; Thu, 21 Oct 2010 09:25:59 -0700 (PDT)
In-Reply-To: <20101021125809.GA15031@linux-mips.org>
References: <74b5d3ba9506b2e6d885546bd6dcdaec@localhost>
        <20101021125809.GA15031@linux-mips.org>
Date:   Thu, 21 Oct 2010 09:25:59 -0700
Message-ID: <AANLkTinJ4wU30AaBhcvJRLZ_iw-eo9tEkds8QA1S=Nqw@mail.gmail.com>
Subject: Re: [PATCH v2 8/9] MIPS: Honor L2 bypass bit
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28191
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Oct 21, 2010 at 5:58 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> I did a bit of research in the meantime.  Turns out that some MIPS
> customers are using their own L2 cache controller.  That means a simple
> check by the CPU PrID is not sufficient and we will need some sort of
> platform-specific probe, sigh.

FWIW, I did check the software user's manual for each of the four
processors in the list and verified that L2B is at CONFIG2 bit 12.  It
would be very rude for an L2 designer to redefine those bits in
defiance of the SUM, no?

I also rechecked 24KE just now, and found that L2B is defined in the
latest rev of the SUM, but in my local copy (Revision 01.02) bit 12 is
the MSB of SS instead.  Hmmm.
