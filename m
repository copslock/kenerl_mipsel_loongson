Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Dec 2011 13:13:37 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:57756 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903632Ab1LFMN3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Dec 2011 13:13:29 +0100
Received: by fabs1 with SMTP id s1so2447250fab.36
        for <multiple recipients>; Tue, 06 Dec 2011 04:13:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=qo+Ikvpk1uOUCq2zTGn9vGEF1soTk/Vzi3peI1CAeVU=;
        b=gF9b57mj33HP4eQxorXmQXV85v0ig8meHeOGhHwTX+e9f55IfMVrZVN+OmdDExRGhe
         uVfRDF+rONWJpZCNsCoHS/hwDHz1jcDZtP7+BeYJRJ44hxxESZtvLDjlGwTxhNu+/PBh
         Ppp36dAnwQE+D/EQQ/D80GOAY2qYf2K0YiG2w=
Received: by 10.216.137.215 with SMTP id y65mr2758533wei.66.1323173604348;
 Tue, 06 Dec 2011 04:13:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.223.14.151 with HTTP; Tue, 6 Dec 2011 04:13:03 -0800 (PST)
In-Reply-To: <1323172965.2163.5.camel@koala>
References: <1323097691-16414-1-git-send-email-jonas.gorski@gmail.com> <1323172965.2163.5.camel@koala>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Tue, 6 Dec 2011 13:13:03 +0100
Message-ID: <CAOiHx==avQMJiATzfcgHKe4AP8D2fjHyirG4RpT4hmeakabcZA@mail.gmail.com>
Subject: Re: [PATCH 0/7] MTD: MAPS: remove bcm963xx-flash
To:     dedekind1@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-mips@linux-mips.org,
        Artem Bityutskiy <Artem.Bityutskiy@intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Florian Fainelli <florian@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 32044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 4420

On 6 December 2011 13:02, Artem Bityutskiy <dedekind1@gmail.com> wrote:
> On Mon, 2011-12-05 at 16:08 +0100, Jonas Gorski wrote:
>> While trying to improve the bcm963xx CFE partition parsing, I noticed
>> that it could be completely replaced by the generic physmap flash
>> driver using a custom parser.
>
> Hi,
>
> would you please send a version which applies cleanly to my
> l2-mtd-2.6.git tree:
>
> http://git.infradead.org/users/dedekind/l2-mtd-2.6.git

On Mon, 2011-12-05 at 16:08 +0100, Jonas Gorski wrote:
> P.S: This patchset is based on l2-mtd-2.6.git, which seems to be the
> "correct" tree now (the website says mtd-2.6.git, but it doesn't look
> like the correct one, having no commits).

And these patches do apply cleanly for me on my local copy of your git
(latest commit from 29 hours ago according to gitweb).


Regards
Jonas
