Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 20 Dec 2009 06:03:23 +0100 (CET)
Received: from mail-fx0-f211.google.com ([209.85.220.211]:55290 "EHLO
        mail-fx0-f211.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491851AbZLTFDU convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 20 Dec 2009 06:03:20 +0100
Received: by fxm3 with SMTP id 3so1366712fxm.24
        for <multiple recipients>; Sat, 19 Dec 2009 21:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=jT1HP7c0gwhB1xa2AsNTaj/eRPBpmgKCBKyiqOz3gYk=;
        b=srkxX1+dee6OuX/sNpy2E55o22QS1W7byqAC0lO9rh9TQRdQVT7erF/XI64hvt6TBj
         /y1BFQW6ENWYECZARe+Y5beYOU7Vwf05G4mYSAfKoKM5cPPfXuO/2WkNM5oaGCIIMHav
         P7fauJpBXGkeYIJOib1/AcrBwN5mOYM3L836s=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=IAZdxEtay0GUkx+k+4OmSfTiZUVv4nK6QNw9t5ZgT6LN5MNHpChflcpFQ9DaR2U/s7
         astjzSyKB0ayrId8xdLRj29cG2QyacL6Kn4YAhlDffUKm7DjAMWf3bZvIEtBYTfMM0V1
         1JTDr1WGuqRulgEeDftXGkSrd5jN65TFtn8yw=
MIME-Version: 1.0
Received: by 10.223.95.79 with SMTP id c15mr7964958fan.31.1261285394123; Sat, 
        19 Dec 2009 21:03:14 -0800 (PST)
In-Reply-To: <20091219220743.GA23526@linux-mips.org>
References: <20091205104158.GA11800@linux-mips.org>
         <1260014960-16415-1-git-send-email-dmitri.vorobiev@movial.com>
         <20091219220743.GA23526@linux-mips.org>
Date:   Sun, 20 Dec 2009 07:03:14 +0200
Message-ID: <90edad820912192103s276d8f96ud331307329d249d7@mail.gmail.com>
Subject: Re: [PATCH] [MIPS] Fix MIPSsim build after command-line cleanup
From:   Dmitri Vorobiev <dmitri.vorobiev@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Dmitri Vorobiev <dmitri.vorobiev@movial.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <dmitri.vorobiev@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25429
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@gmail.com
Precedence: bulk
X-list: linux-mips

On Sun, Dec 20, 2009 at 12:07 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Dec 05, 2009 at 02:09:20PM +0200, Dmitri Vorobiev wrote:
>
>> Commit `MIPSsim: Remove unused code' removed the file
>> arch/mips/mipssim/sim_cmdline.c but did not clean the
>> reference to the corresponding object file.  This patch
>> is to fix the build breakage resulted from the above.
>
> I've already done this change myself to what was in the 2.6.33 before it
> went upstream, so this is no longer necessary.

OK, thanks for catching the error.

Dmitri

>
> Thanks anyway!
>
>  Ralf
>
>
