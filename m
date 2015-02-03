Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 15:28:43 +0100 (CET)
Received: from mail-qg0-f46.google.com ([209.85.192.46]:41249 "EHLO
        mail-qg0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014613AbbBCO2mVESvD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 15:28:42 +0100
Received: by mail-qg0-f46.google.com with SMTP id i50so52317315qgf.5
        for <linux-mips@linux-mips.org>; Tue, 03 Feb 2015 06:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=7oPxXvIWHhoPrMijKB29/4hihOA9bfgtBWkBECqOdFk=;
        b=NbzjTzTKN0UiaDHzGq9Vg7fgbKxMngCDVise0+Wq7DCivSxqJfbXUZTvCSs76OzEqi
         EPmkYSEUqtJTJJNsK/uTIToqJzha7Nzh/H1uglgwVU0fyAGSOY2hJUOdgL/ETHzYBpzt
         kv4b+9N94S242kx+x0H9ufLW+GQzOwD6Khskk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type;
        bh=7oPxXvIWHhoPrMijKB29/4hihOA9bfgtBWkBECqOdFk=;
        b=cqUkMZVGbyGXQRRTUhTC4vZB7/JzZP/XT/dBE1CQwx55fC4OzTiKzlf5hQs/qrcdoy
         JT510R6dQ/fDwA/7y+xPpi15EmWSlh8Gg6asbOOfr4D4Qyas6BvJpETkr3DCpQwl5+zw
         NvBOzN+qF8paJHFl9qNXtTVaS3Rj7im8iXSD7mQsrCJ5fsTjCqaPHjrgfjI3wBhD4GUm
         QYhTrZIMt5qFld9IBdn4TVCsJCS3rCbBXpsWKDdh6qz2AmHEDDFJGmA83gJ3+Xz9Z+Cf
         Et7bkppr/rnfEJ6f7YaJn5rgLewtV45ivmk7euDdSbBlsf4Ne4Gmr1OCw50VGMqHND1h
         IvMQ==
X-Gm-Message-State: ALoCoQkb/Q3LArl90baUTZuZdPezup/OUX6K9xtTC7omMftMK4HgRYceII6j3rvrn+qzkQlRIr9s
X-Received: by 10.140.82.234 with SMTP id h97mr46789231qgd.75.1422973716486;
        Tue, 03 Feb 2015 06:28:36 -0800 (PST)
Received: from mail-qa0-f42.google.com (mail-qa0-f42.google.com. [209.85.216.42])
        by mx.google.com with ESMTPSA id c8sm21359693qgf.14.2015.02.03.06.28.35
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 03 Feb 2015 06:28:35 -0800 (PST)
Received: by mail-qa0-f42.google.com with SMTP id dc16so33949634qab.1;
        Tue, 03 Feb 2015 06:28:34 -0800 (PST)
X-Received: by 10.140.83.163 with SMTP id j32mr46388183qgd.52.1422973714896;
 Tue, 03 Feb 2015 06:28:34 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.36.210 with HTTP; Tue, 3 Feb 2015 06:28:14 -0800 (PST)
In-Reply-To: <alpine.LFD.2.11.1502030930000.22715@eddie.linux-mips.org>
References: <54CEACC1.1040701@gmail.com> <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com>
 <yw1xwq409odv.fsf@unicorn.mansr.com> <54D017D4.70200@gmail.com> <alpine.LFD.2.11.1502030930000.22715@eddie.linux-mips.org>
From:   Kevin Cernekee <cernekee@chromium.org>
Date:   Tue, 3 Feb 2015 06:28:14 -0800
Message-ID: <CAJiQ=7DWiSEeBUiKCPZKn8fUwxUdOrCqMLDYFTaXSMTGsJCJOA@mail.gmail.com>
Subject: Re: Few questions about porting Linux to SMP86xx boards
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Oleg Kolosov <bazurbat@gmail.com>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@chromium.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@chromium.org
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

On Tue, Feb 3, 2015 at 3:39 AM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>  For the record -- the exact address `__fast_iob' reads from does not
> really matter, all it has to guarantee is no side effects on read access.
> Using the base of KSEG1 was therefore a natural choice for legacy MIPS
> processors that set the architecture back at the time this code was added,
> as the presence of exception vectors there guaranteed this area of the
> address space behaved like RAM so the same location did for any system.
>
>  With the introduction of revision 2 of the MIPS architecture the CP0
> EBase register was added and consequently there is no longer a guarantee
> that exception vectors reside at the base of KSEG1.  Using the value read
> from CP0.EBase to determine a usable address might therefore be a better
> idea, although the current revision of the MIPS architecture specification
> that includes segmentation control makes it a bit complicated.  Using a
> dummy page mapped uncached instead might work the best.

Would something like this work, assuming __fast_iob() doesn't get
called before mem_init()?

CKSEG1ADDR((void *)empty_zero_page)

It is currently a GPL export, so maybe that would need to change to
allow non-GPL drivers to use iob().  But that's still easier than
allocating another dummy page.
