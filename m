Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Apr 2017 22:05:44 +0200 (CEST)
Received: from mail-qk0-x235.google.com ([IPv6:2607:f8b0:400d:c09::235]:36153
        "EHLO mail-qk0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991957AbdDYUFgU84of (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Apr 2017 22:05:36 +0200
Received: by mail-qk0-x235.google.com with SMTP id u75so57739567qka.3
        for <linux-mips@linux-mips.org>; Tue, 25 Apr 2017 13:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iOShJA3zaJZ2T/W8JFqJ2wa/M1NuqVEQRNgZwMi4VMM=;
        b=STFPF6p8DYkfIuQnT1Id6r2dVvIGuwqgauMfDY+Jo9OTS46vJNIdcUhUf1FD8mow55
         nCqdjG4dbjrAuKAeYxmDrN5r+qXbLQUDtoxJm5RSwB7cCzwvoBBxj8PTNLr9LAiU9QJi
         vTPfD+0xyvsWpbeTPhiNfZvLpLc7i4vFGRx6E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iOShJA3zaJZ2T/W8JFqJ2wa/M1NuqVEQRNgZwMi4VMM=;
        b=eyiPyCvPbrw3Q5qdrXABk9YAGpWdMXoCKtzSPC0G4j6KVXk09yH2zaAgmq7jd+T3hV
         qvQEpm79+3OycOVEGF+b0vfmzxk6sdVmuN34GrpHdpoXSiJFttcXVWMQgjKlNwm7/JwK
         5wABTJ8jXkH372olWnZsmFOYmm0ME1RCx0kVek/9qPiUGYI1TRVCRtB3yuUsZo6wLLT6
         09ltyuOmIuw0hyfFYmSRn1Fk2c9gGLDkNEEs+j7yyDKlz9OBxttE5lLyLCAQDLBsZbee
         HE7Ok+IaNGf0HsDGCL/nvlK9HI7rIie7pT9QtwWICnl1waT86uEXKzTTj792Z7cFtdTk
         HIew==
X-Gm-Message-State: AN3rC/4TnEBjiYrD9BfrugzT64dvMJ5fmLpJQ0DNm3paSgX1gS3PtnlP
        /O3aGj1E4OGUCM3cSbQF1PG9MTMdTRGR
X-Received: by 10.55.167.72 with SMTP id q69mr26003281qke.193.1493150730538;
 Tue, 25 Apr 2017 13:05:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.200.37.246 with HTTP; Tue, 25 Apr 2017 13:05:30 -0700 (PDT)
In-Reply-To: <20170425195451.GE28041@linux-mips.org>
References: <1493059318-767-1-git-send-email-steven.hill@cavium.com>
 <CAPDyKFoAeyqnomWSphRt95WPDuhHRnAuowYHRnMkAB6izZv4nw@mail.gmail.com> <20170425195451.GE28041@linux-mips.org>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 25 Apr 2017 22:05:30 +0200
Message-ID: <CAPDyKFr5imEOADNXdhv_YCVBQCHtZUQs1px_=VGiOf=64Mt6Ew@mail.gmail.com>
Subject: Re: [PATCH 0/4] MMC support for Octeon platforms.
To:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J. Hill" <steven.hill@cavium.com>
Cc:     David Daney <david.daney@cavium.com>,
        Jan Glauber <jglauber@cavium.com>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        linux-mips@linux-mips.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <ulf.hansson@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57790
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ulf.hansson@linaro.org
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

On 25 April 2017 at 21:54, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Apr 24, 2017 at 09:56:42PM +0200, Ulf Hansson wrote:
>
>> Thanks, applied patch 1->3. Patch 4 is for the MIPS SoC maintainer,
>> unless I get an ack for it.
>
> Here's the Ack for patch 4:
>
> Acked-by: Ralf Baechle <ralf@linux-mips.org>
>
>   Ralf

Thanks, applied patch4 for next!

Kind regards
Uffe
