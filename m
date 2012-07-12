Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jul 2012 10:58:31 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:53389 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1902243Ab2GLI6Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jul 2012 10:58:24 +0200
Received: by obbta17 with SMTP id ta17so2944847obb.36
        for <multiple recipients>; Thu, 12 Jul 2012 01:58:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=MHWANTt7HFd7kn0Ndmbc50DEjV/ul8bkcB5GV3WypcY=;
        b=GGsXJb4wmqgukXuyhY+YG+LjxcEuFs1diR41PavwQrthepOBJtEK9HlDF5EjWuizEO
         RX7GazsSzzGvkMAWuH1/yd9DoJtVz9+xBLw6Uq1oSmsJd70T69s17T5MGa9rGaX5d5Bq
         Pn/t6JCyfHZHHExDhO1Wj6VMCK7cVHyfPEYe2hgED6vJQhdTemBg2iG3t39o901H2RuN
         /Cd2FFfJFVwkn6GYV5Z587mJOyTHYvlOFLzV4MvDHapVMzQ0Ivdqyk4uELCGDh8kz4fL
         P8dELcrkR58l7qY4us2gEw32gKIT+r8SMSQF+UOjBScC3v/9CI0NPL5w1ymngpkNGtmP
         xFLg==
Received: by 10.182.51.69 with SMTP id i5mr29082295obo.42.1342083498641; Thu,
 12 Jul 2012 01:58:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.76.94.235 with HTTP; Thu, 12 Jul 2012 01:57:58 -0700 (PDT)
In-Reply-To: <CAJiQ=7Dxp8StP6Wj-EFAgWpLHxRrs616089BpKRSbPq4kWszag@mail.gmail.com>
References: <0f67eabbb0d5c59add27e42a08b94944@localhost> <CAJiQ=7Dxp8StP6Wj-EFAgWpLHxRrs616089BpKRSbPq4kWszag@mail.gmail.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Thu, 12 Jul 2012 10:57:58 +0200
Message-ID: <CAOiHx==+Z+GL6r8dDWVSrtUHMYXNsK3GWktq=1RLN0VjkQcL1Q@mail.gmail.com>
Subject: Re: [PATCH 0/7] Prerequisites for BCM63XX UDC driver
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     ralf@linux-mips.org, ffainelli@freebox.fr, mbizon@freebox.fr,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
X-archive-position: 33890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 9 July 2012 04:58, Kevin Cernekee <cernekee@gmail.com> wrote:
> On Fri, Jun 22, 2012 at 10:14 PM, Kevin Cernekee <cernekee@gmail.com> wrote:
>> These patches are intended to lay the groundwork for a new USB Device
>> Controller (gadget UDC) driver.
>
> I have posted "V2" for 4 of the 7 patches.  New bundle is here:
>
> http://patchwork.linux-mips.org/bundle/cernekee/bcm63xx-udc-prereq-v2/

These look good to me, and I have no further objections.

Jonas
