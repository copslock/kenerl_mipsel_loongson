Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Feb 2015 18:26:20 +0100 (CET)
Received: from mail-qa0-f41.google.com ([209.85.216.41]:36537 "EHLO
        mail-qa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012762AbbBFR0SQrzgz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Feb 2015 18:26:18 +0100
Received: by mail-qa0-f41.google.com with SMTP id bm13so11877527qab.0
        for <linux-mips@linux-mips.org>; Fri, 06 Feb 2015 09:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zwKyHqe2i2boYwnY1p0iTDaGMlDcGHbF9EQYteIK97Q=;
        b=Qi8oVtOmnlOLAEj7E1tsAPy/0gqlNguVUeNikpGT2H2d5irS7397blhEUWi9FMOKhQ
         d9s1EcZyF/grujLsUKpUDoEyQbjMWDew/YK/u2KMDD0wstcRt6TkERZFzKaBtk4NrTwn
         /AfGHxbE89LX3cD7AB6HZ96jGjOwsx8ZYDiRN/OdabfM2LW56RQSxdWqfpsw1QIUMM13
         eNiy6xOxSCWmySFLtiJVZ1ja9FurA+Bd1HZD+HWoZ48pjLmwl0CF1MaFz7R4dlSPOPr/
         pqlcsUmgp6S5YOwoLHeVOSLIA0K1s/WbZcF4O6UBfFZGxkUxuPpup45LKwSD79phcO9i
         U4CQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=zwKyHqe2i2boYwnY1p0iTDaGMlDcGHbF9EQYteIK97Q=;
        b=VhqpqZv5MMpNM5vCfh61VBobt8pqEzlaxoEeAvWe8/PRlwNeDLicxa7fKWVkDRo2Er
         DC/Y8dxS0cNpg0iAgE6mXInC/5VsU7btx75LyxzM9/40bMDKkfautBZFzZUAfm0huyKZ
         7UrTeqjqUERZjezriB0LX4N548fWb+3Y3RY2c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=zwKyHqe2i2boYwnY1p0iTDaGMlDcGHbF9EQYteIK97Q=;
        b=Csbo5obZYa+kz0IG+q0G8+IcsE3Pwfovzp+y/NF5Ij366Tj3sT9wp2iseQTgdWHFzm
         FG6LOr5G87+ron/UxKw9PlI/Qta6PKfnPYHzgZcsAZXUZtGrl++lVJmzt8RtBJFiAVok
         C+lvC6d7j/tEtvH2L9l7nr6CHcow/mPIUJH7wHUK8tLumSs6z5kk4O39dXvKhlZQxRSz
         V0VZ/1/+1+T3FUvqbE2PKUrkjqC5bHYB1l+MUw0isgUx5dpYVEnR5q1eF3K5BCSjMLk0
         z4KqLnaFnchQb3uwaWrRRNYLo9s47eT/LWzX9zx3aL4/hu+KKhwboUgd/XQhgK7buDqf
         f2bQ==
X-Gm-Message-State: ALoCoQls8xFCsSyEYvDH8NTWw3luCe5wgNGTh1gJSCq5J/n8tKdHhXqvLQ5EWwXXJnI6jlI3wOKD
MIME-Version: 1.0
X-Received: by 10.140.102.165 with SMTP id w34mr10322087qge.26.1423243572375;
 Fri, 06 Feb 2015 09:26:12 -0800 (PST)
Received: by 10.140.19.72 with HTTP; Fri, 6 Feb 2015 09:26:12 -0800 (PST)
In-Reply-To: <1423239509-1432-1-git-send-email-niklass@axis.com>
References: <1423239509-1432-1-git-send-email-niklass@axis.com>
Date:   Fri, 6 Feb 2015 09:26:12 -0800
X-Google-Sender-Auth: xr30ZnijaTyh-VskMNt0rm9C69o
Message-ID: <CAL1qeaFEsBMvgy33y7+PRMPzzV08=EkeR1tbrTNh9jnzbDghow@mail.gmail.com>
Subject: Re: [PATCH] MIPS: sead3: Corrected get_c0_perfcount_int
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Niklas Cassel <niklas.cassel@axis.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        Niklas Cassel <niklass@axis.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45751
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Niklas,

On Fri, Feb 6, 2015 at 8:18 AM, Niklas Cassel <niklas.cassel@axis.com> wrote:
> Commit e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
> updated several platforms. This is a copy paste error.
>
> Signed-off-by: Niklas Cassel <niklass@axis.com>

Thanks for catching this!

Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
