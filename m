Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Jun 2016 14:24:46 +0200 (CEST)
Received: from mail-oi0-f53.google.com ([209.85.218.53]:36528 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042341AbcFPMYnwjRW9 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Jun 2016 14:24:43 +0200
Received: by mail-oi0-f53.google.com with SMTP id p204so65973895oih.3;
        Thu, 16 Jun 2016 05:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DvS6eroV0rSJqS7mdD2PHYoKMLMvV6w0GT8dJy2yXLY=;
        b=dNpXJX3eCcSkYwcscEB6voxDOctZGr2sT/SiME23GkjSfFUmBU01zXQLCmDrfhnGZg
         qE5+lDoW4YEAu0qstR35yNvKc63e8Mp5uUZ5BJA40lJIRKlepUyXCtwTPTemw/AEzqCU
         lL/8tgAzy7hR+8XdCRyPZGIhkO9eUcKi+7EUSQ6QmspqI9Xj0g/aOGibNSqn+ezL9iEO
         mdmvoyjBtuePU2dGE3NJPBtrSNbkkOelMQmjyMM1UMbiDzQwkpyVuqd83Ddkv2GHd1LI
         S722Ogfzm/KwiniCcZg4ucaNA/xyonji4AaU/bJdjw/OL8VmQXsPz/AcGEgEjG2kC5xQ
         /Pfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DvS6eroV0rSJqS7mdD2PHYoKMLMvV6w0GT8dJy2yXLY=;
        b=UyoUMg7wRvyPY8jlMYVFL+xL7ZquaW08K5i/bN9nxcScL7lJN9QTBr3+4tkFQb0MQb
         k9kIK6sqOPSMG1N5iBn7bUbFIzCeIQYbVMPtW7/AIckVWDx6ERQtLe2RFAOXEltH3xt7
         h9O3Fr3eEqZrvud+W6SvMoAzDBFls8cg4E8WIA72si2TLLzSath3YZnZzcDClN20UhHT
         MdtoYlqokDuOowgoxXGXyEVegNquaLvylpNVAoUvCQrK9x7qpXDZ05Sy1WOoGUhv3yyK
         V03rMlHk/YxMrRdDCBwcKDxhz6ztkEUS3PFDOdIl8w1LYVINhjnro2cvYp9H4Kyw29mR
         78Nw==
X-Gm-Message-State: ALyK8tLKPcHYm54TJz8JyuemAgD6IS5yy37CEKHBusd5GpkcWK/P7lbV/hyxL/mz6zeb20zgviXCo8NUU5/s5w==
X-Received: by 10.202.183.131 with SMTP id h125mr2300609oif.189.1466079877830;
 Thu, 16 Jun 2016 05:24:37 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.175.140 with HTTP; Thu, 16 Jun 2016 05:24:37 -0700 (PDT)
In-Reply-To: <CAOLZvyFuP2TBFOkUZJPQ2HtaCb6pztMsxjiQVSDr8E5xxH3Ecw@mail.gmail.com>
References: <CACna6rwCPFWj1wJpm8sW2ZSfNpTRxi9-9MmzKSbJ617HW7LTNw@mail.gmail.com>
 <trinity-17a92ddb-99fb-4084-bd99-4151434f09d4-1466077370809@3capp-gmx-bs78> <CAOLZvyFuP2TBFOkUZJPQ2HtaCb6pztMsxjiQVSDr8E5xxH3Ecw@mail.gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Thu, 16 Jun 2016 14:24:37 +0200
Message-ID: <CACna6rz0jm2BhCVwiwjXCTayjU5UacNh3Y=TuXp56OcfJ4huUg@mail.gmail.com>
Subject: Re: BCM4704 stopped booting with 4.4 (due to vmlinux size?)
To:     Manuel Lauss <manuel.lauss@gmail.com>
Cc:     Paul Wassi <p.wassi@gmx.at>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>,
        David Daney <david.daney@cavium.com>,
        =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Larry Finger <larry.finger@lwfinger.net>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54078
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 16 June 2016 at 14:19, Manuel Lauss <manuel.lauss@gmail.com> wrote:
> On Thu, Jun 16, 2016 at 1:42 PM,  <p.wassi@gmx.at> wrote:
>>> On the other hand Paul also experiences some problems with his Linksys
>>> WRT54GL (BCM5352E), the last stable kernel for him seems to be 3.18.
>>
>> I have to calrify that a bit:
>> if I use prebuilt images from OpenWrt 15.05.1, they work out of the box (as you say, it's 3.18)
>> If I take prebuilt images from (LEDE|OpenWrt) trunk (which was 4.1 then), they do not boot.
>> However, if I clone the repo (which was used to build said trunk) and build it myself,
>> the images work fine. (kernel 4.1) [1]
>
> Differences in toolchain perhaps? What versions of gcc, binutils do
> you and LEDE/OpenWrt use?

When building LEDE, it first compiles toolchain and compiler and then
it uses them to compile all the software. It doesn't use host-provided
toolchain/gcc. So it shouldn't matter on what machine you build your
image (buildbot or locally). Right now LEDE's master uses gcc 5.3.0
and musl 1.1.14.

-- 
Rafał
