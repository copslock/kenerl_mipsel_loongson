Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 09:48:24 +0200 (CEST)
Received: from mail-bk0-f54.google.com ([209.85.214.54]:47846 "EHLO
        mail-bk0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822451Ab3FSHsWf9fGo (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Jun 2013 09:48:22 +0200
Received: by mail-bk0-f54.google.com with SMTP id it16so2144856bkc.41
        for <multiple recipients>; Wed, 19 Jun 2013 00:48:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=rxotdEDrXE5I2DryIs9o43RNaTzYhcds+AdrtcIcrI8=;
        b=zKUn6SSchWEJY68yR7rruYEUUA4FAfRpNS9CIZSfBBpPOrv8IrNbaOoUJYjUYs+Pc1
         O3z2wkyTrP/dr4dHzP31LZsU4XZr+lDEdHDTTtcScp4Zxikz/zYtL72GRFXUPxauMo7M
         Igf1Uf5S4FkIwaDc0u7IQOi0y4hhm4RnfhbE1EfvbgMHZAP1AKtC2bG9dEwRa/tsmaee
         5b7XwJmNYPNLIM0DtzaPYD5I0YW+O1iBEquh6hAvandgoQv02xIYlqmJLPPRCz51K+MC
         aE70Khr5mXnBh+tFDGYkcGQjMYv7Ui+wB06kK4Da7ldbPUdVc8reqL2kYykDhOkinfKi
         it8w==
MIME-Version: 1.0
X-Received: by 10.204.191.132 with SMTP id dm4mr220617bkb.66.1371628096822;
 Wed, 19 Jun 2013 00:48:16 -0700 (PDT)
Received: by 10.204.174.8 with HTTP; Wed, 19 Jun 2013 00:48:16 -0700 (PDT)
In-Reply-To: <CAECwjAhzJUO4GFmnu3jX8e-UEj2wiVrB8xA3Hu_0iSaf1L1v5w@mail.gmail.com>
References: <1371564006-31805-1-git-send-email-markos.chandras@imgtec.com>
        <20130618141420.GA15141@linux-mips.org>
        <CAECwjAhzJUO4GFmnu3jX8e-UEj2wiVrB8xA3Hu_0iSaf1L1v5w@mail.gmail.com>
Date:   Wed, 19 Jun 2013 15:48:16 +0800
Message-ID: <CAECwjAg+3ec5hf4etmypA1mqp9+BUOcOCgFAcq=cA5kQAqx3+A@mail.gmail.com>
Subject: Re: [PATCH v2 5/7] drivers: watchdog: sb_wdog: Fix 32bit linking problems
From:   Yousong Zhou <yszhou4tech@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Markos Chandras <markos.chandras@imgtec.com>,
        linux-mips@linux-mips.org, sibyte-users@bitmover.com,
        Wim Van Sebroeck <wim@iguana.be>
Content-Type: text/plain; charset=UTF-8
Return-Path: <yszhou4tech@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37003
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yszhou4tech@gmail.com
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

On 19 June 2013 15:45, Yousong Zhou <yszhou4tech@gmail.com> wrote:
> I am not quite sure on this. I just digged this[1] out and thought that Linus
>  may not be happy about the operation `tmp_user_dog/1000000`.

Only realized that it's a decimal integer after I clicked the Send button.
Sorry for the noise...

>
> Correct me if I am wrong, please.
>
> [1] http://lwn.net/Articles/456241/
>
