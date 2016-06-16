Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2016 14:20:32 +0200 (CEST)
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35522 "EHLO
        mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042341AbcFPMUbbqJdb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Jun 2016 14:20:31 +0200
Received: by mail-wm0-f49.google.com with SMTP id v199so189907281wmv.0;
        Thu, 16 Jun 2016 05:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=KVhso8/7nS+jjd3aWMu5hl48LooVSScChfs8FIwqzFE=;
        b=ycQIleUO8KPzBTdI8EL5iFIiLMifPEkCYcsBO0NRR2pzpBy5g73mUPbyF5UOpQSnY8
         aDzkU5vuXeRvMQBeMrSwqaFK5hgcDbEYhog0zkXKvBle/iqaa1gs1OTyJJqrkKUnpn1A
         lnSGWjXwTTPAyGRpBJwPEV8C4Ec0ySeS/cyhSao7vIB7WzP1WTramnbLRSWO6D+CmbKZ
         U/3RuVmd1mSmCJp4+D8+72k6XYpbgp/q4cDyRlrOro7/z+0tWG2dJzg3TaSDhLnI9GR2
         dnRUdTe/6JgQZZrRgcWtymlV4a7SlzLz2+c3tY6Gu1/RBYx4LjsGmQf39jnnzurXmxel
         tDyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=KVhso8/7nS+jjd3aWMu5hl48LooVSScChfs8FIwqzFE=;
        b=LLmDxYkmyIBeW3tpigRFIiPJbiqZ032txnDXd02AGjXTHQbITWmjiVVlCsGHCK5bVy
         OauanUIPkzliQGA6ohJ2PTBNOiS8LOSsP+ZSgnqQyGDXTBrKA84De+b0SR4FtPn2ZPT3
         6D3XGNhXAP4oSHJdjp1hvrKMyqj+gX1LoI9efqgKouK8h/eFA9YbFE3rKv5l5rZ26uQm
         l3FQGsVrQlbsTVLOQo2ehh4fOiO8KNenPwKatlw8a6qKxbMlbCZsg6saizkRXDBjvOf6
         ZcOuFkG7DYR+xEyUkJ+fCG26pBHAtxOaijNcpLtb47EJmuLIxm8fFkZkEZP9818NC6wj
         7jpw==
X-Gm-Message-State: ALyK8tLWiCHEtFXpC3moDSYAVrJggM1pO9Z4H84/wij90R3OiPsClMjXY4ia/9r1fynKHGDm7C54P+a9EhcD+g==
X-Received: by 10.28.48.15 with SMTP id w15mr15639067wmw.28.1466079624843;
 Thu, 16 Jun 2016 05:20:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.28.152.141 with HTTP; Thu, 16 Jun 2016 05:19:45 -0700 (PDT)
In-Reply-To: <trinity-17a92ddb-99fb-4084-bd99-4151434f09d4-1466077370809@3capp-gmx-bs78>
References: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
 <trinity-17a92ddb-99fb-4084-bd99-4151434f09d4-1466077370809@3capp-gmx-bs78>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Thu, 16 Jun 2016 14:19:45 +0200
Message-ID: <CAOLZvyFuP2TBFOkUZJPQ2HtaCb6pztMsxjiQVSDr8E5xxH3Ecw@mail.gmail.com>
Subject: Re: BCM4704 stopped booting with 4.4 (due to vmlinux size?)
To:     p.wassi@gmx.at
Cc:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Larry Finger <larry.finger@lwfinger.net>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54077
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

On Thu, Jun 16, 2016 at 1:42 PM,  <p.wassi@gmx.at> wrote:
>> On the other hand Paul also experiences some problems with his Linksys
>> WRT54GL (BCM5352E), the last stable kernel for him seems to be 3.18.
>
> I have to calrify that a bit:
> if I use prebuilt images from OpenWrt 15.05.1, they work out of the box (as you say, it's 3.18)
> If I take prebuilt images from (LEDE|OpenWrt) trunk (which was 4.1 then), they do not boot.
> However, if I clone the repo (which was used to build said trunk) and build it myself,
> the images work fine. (kernel 4.1) [1]

Differences in toolchain perhaps? What versions of gcc, binutils do
you and LEDE/OpenWrt use?

      Manuel
