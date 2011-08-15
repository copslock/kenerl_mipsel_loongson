Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2011 18:19:12 +0200 (CEST)
Received: from mail-ey0-f169.google.com ([209.85.215.169]:34994 "EHLO
        mail-ey0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491819Ab1HOQTG convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Aug 2011 18:19:06 +0200
Received: by eye22 with SMTP id 22so3259954eye.0
        for <multiple recipients>; Mon, 15 Aug 2011 09:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=+3AZsa8fjMHGuziQ21Os81goQHToHvtZUYDYImHNR5o=;
        b=haHOmh6oMV2UddByfhd5si12wuXPQK42JXlkcTRI70iz0KvZzGOeaUN+uZJFXtR3+3
         Zq7iosJTOPRMAwXtn5gkzz7a7QIwG4v4269Md8FUWUNFWDyPvTgKfceS9Q8dbi4JpXo+
         M3BALEFnLMpZivzGS+tFyzRzjwboscTUXQso0=
MIME-Version: 1.0
Received: by 10.14.151.14 with SMTP id a14mr618169eek.169.1313425140707; Mon,
 15 Aug 2011 09:19:00 -0700 (PDT)
Received: by 10.14.187.14 with HTTP; Mon, 15 Aug 2011 09:19:00 -0700 (PDT)
In-Reply-To: <20110815135515.GA1441@linux-mips.org>
References: <1313384834-24433-1-git-send-email-lacombar@gmail.com>
        <1313384834-24433-3-git-send-email-lacombar@gmail.com>
        <4E48EAA0.5020901@mvista.com>
        <20110815135515.GA1441@linux-mips.org>
Date:   Mon, 15 Aug 2011 12:19:00 -0400
Message-ID: <CACqU3MVyg_hA1m+1sJZ+aTHdxvzxviVXr0Fvom7p9EEHXVOMtA@mail.gmail.com>
Subject: Re: [PATCH 02/11] arch/mips: do not use EXTRA_CFLAGS
From:   Arnaud Lacombe <lacombar@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30883
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lacombar@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11047

Hi,

On Mon, Aug 15, 2011 at 9:55 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Mon, Aug 15, 2011 at 01:45:04PM +0400, Sergei Shtylyov wrote:
>
>>    You didn't sign off.
>
> True - but I won't make a big fuzz about that for a one-line.  I'm sure
> Arnaud will vow to do right the next time :-)
>
You are welcome to slap me. If it's not too late:

Signed-off-by: Arnaud Lacombe <lacombar@gmail.com>

  - Arnaud

> Applied.  Thanks, Arnaud!
>
>  Ralf
>
