Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Aug 2011 19:28:39 +0200 (CEST)
Received: from mail-ww0-f41.google.com ([74.125.82.41]:41566 "EHLO
        mail-ww0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491948Ab1HOR2c convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 15 Aug 2011 19:28:32 +0200
Received: by wwj26 with SMTP id 26so1489581wwj.0
        for <multiple recipients>; Mon, 15 Aug 2011 10:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pBJ2641kwexzFiBDzrQP1xLseNZhYTRIwmXm4DKvnEo=;
        b=h+87bbb2Oixs6/EsxKpvqYP40licDg0HdZhG29DUo6HBl+avykojq6rDELwXBFVzal
         2WaOcioiN+0YyGpJ49YvAeuPSuHL5TYzZD8C4Z+FOnISTW5D2Ae6Ihr1lMluI9juVbnr
         3da6DdaDh2jzeAInFFW7aFKBq+6lZsSu9Nv/A=
MIME-Version: 1.0
Received: by 10.216.46.208 with SMTP id r58mr2200392web.78.1313429307154; Mon,
 15 Aug 2011 10:28:27 -0700 (PDT)
Received: by 10.216.48.1 with HTTP; Mon, 15 Aug 2011 10:28:27 -0700 (PDT)
In-Reply-To: <CACqU3MVyg_hA1m+1sJZ+aTHdxvzxviVXr0Fvom7p9EEHXVOMtA@mail.gmail.com>
References: <1313384834-24433-1-git-send-email-lacombar@gmail.com>
        <1313384834-24433-3-git-send-email-lacombar@gmail.com>
        <4E48EAA0.5020901@mvista.com>
        <20110815135515.GA1441@linux-mips.org>
        <CACqU3MVyg_hA1m+1sJZ+aTHdxvzxviVXr0Fvom7p9EEHXVOMtA@mail.gmail.com>
Date:   Mon, 15 Aug 2011 22:58:27 +0530
X-Google-Sender-Auth: fopiUJOTOh6QJn_zkNvmyvpPkYM
Message-ID: <CA+7sy7DEBgcUYCf895yf8cKMS=iDgz-n9Nh7R8_EO_O-QX3MfA@mail.gmail.com>
Subject: Re: [PATCH 02/11] arch/mips: do not use EXTRA_CFLAGS
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Arnaud Lacombe <lacombar@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sshtylyov@mvista.com>,
        linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30884
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11093

On Mon, Aug 15, 2011 at 9:49 PM, Arnaud Lacombe <lacombar@gmail.com> wrote:
> Hi,
>
> On Mon, Aug 15, 2011 at 9:55 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Mon, Aug 15, 2011 at 01:45:04PM +0400, Sergei Shtylyov wrote:
>>
>>>    You didn't sign off.
>>
>> True - but I won't make a big fuzz about that for a one-line.  I'm sure
>> Arnaud will vow to do right the next time :-)
>>
> You are welcome to slap me. If it's not too late:
>
> Signed-off-by: Arnaud Lacombe <lacombar@gmail.com>

Thanks for fixing this up.   Looks like an acked-by is not needed :)

JC   (Netlogic XLR/XLS maintainer)
