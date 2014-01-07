Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Jan 2014 22:25:10 +0100 (CET)
Received: from mail-wi0-f177.google.com ([209.85.212.177]:59409 "EHLO
        mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6870551AbaAGVZJDm4Of (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Jan 2014 22:25:09 +0100
Received: by mail-wi0-f177.google.com with SMTP id cc10so1286975wib.16
        for <linux-mips@linux-mips.org>; Tue, 07 Jan 2014 13:25:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/mWy0F0qcJCUBab5WLzOeuo+3Mh1rdqlbeaPtY+lXvk=;
        b=kvzNtZle1BTJjaHujXvUI1KjjpIiWMDsiFgyjFTymEhFeYlH1hIH3QHBPkbiQB6PLE
         jnt7xvz4F+OJcPLQ2fbKFlSuX/cXKmiiCz8lo1G+Rx0xLxR936UV/29BioQEsvsBWisG
         wQGesS+ycBo0DcqvNGBLTnVy+YKYu7JpGSlAuPXh8ak9MH5qJqFB8IThdkOs52Qf+Jb2
         55uwvTBi7AiUjAoWf9pwOI9jIamLSAlVeXppbNvg1lThqfw1ObWpi5iiHK0yxKPwJ9oG
         fYHbq+PTrguuOo4QS9/A14SFxOtEQK5Pve32xy7qv7xBMHA5tTIYr3SOsrM7PDMEYSOr
         R/dw==
MIME-Version: 1.0
X-Received: by 10.180.76.42 with SMTP id h10mr18656496wiw.46.1389129903625;
 Tue, 07 Jan 2014 13:25:03 -0800 (PST)
Received: by 10.227.207.68 with HTTP; Tue, 7 Jan 2014 13:25:03 -0800 (PST)
In-Reply-To: <52CC5B12.8090305@hauke-m.de>
References: <CANpj82+h1a0qBfaaYpqmuL69JpbB+T_z0pg0iL=5JPBvDE9A2w@mail.gmail.com>
        <52CC5B12.8090305@hauke-m.de>
Date:   Tue, 7 Jan 2014 22:25:03 +0100
Message-ID: <CANpj82Ln1SkOR-DQwK9Dy5E71QVE0PG3fWxOpkzX=B+T7dHU2Q@mail.gmail.com>
Subject: Re: Patch for the "ug" bug
From:   Jean-Yves Avenard <jyavenard@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <jyavenard@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jyavenard@gmail.com
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

On 7 January 2014 20:52, Hauke Mehrtens <hauke@hauke-m.de> wrote:

>
> Hi,
>
> this is a little late but I haven't seen this earlier. I just tried your
> script and had no problems on my Asus RT-N66U running OpenWrt with
> kernel 3.10.24. This problem was either cause by some other non upstream
> Broadcom modification or was already fixed in mainline kernel.
>

As you wrote, you're a little late.... about 18 months late...

The issue was in the mips memory management in 2.6.x kernel....
FWIW; all tomato and dd-wrt firmware include this fix.

Now the question is more about weither the fix is in your kernel or not...
