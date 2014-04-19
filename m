Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 19 Apr 2014 02:49:45 +0200 (CEST)
Received: from mail-ve0-f181.google.com ([209.85.128.181]:58757 "EHLO
        mail-ve0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822290AbaDSAtjthYK4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 19 Apr 2014 02:49:39 +0200
Received: by mail-ve0-f181.google.com with SMTP id oy12so3924377veb.40
        for <multiple recipients>; Fri, 18 Apr 2014 17:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=DfVpD0KRlDV1lZVvpHPC8X0Coty+ty/7Ba9aR4qpiDQ=;
        b=Gy/nq+h+YgZohxnDe3w2iUbhcdA8v00k2eNDVxXhD567XIFqzMC5Ges16pyovD+5hJ
         Y+/IQaznE7wyH0hlKXKd3rvv2jp5JIZG4L3ruupMx7MrW7KutbcjkJz6rgyaEgep8/y1
         oiLo2m60P9JYvokYL1Nvfmn6Gkok/tvGkqPa9W1lM7a7HZlfkEqRrSr7GrG8pM9YPToc
         7+h0AWqlJ/2UJgEGTLAPjX4euirDTGsBkbsFmb6RKP4PqWNXKQQ8oWJ9E3izJY7B19BT
         cBU+6WH+JYBbNA2NaD6MGUgeddBl7p2x1lhqmvB9uujpF/A4mWLBIhuVtu/KVcBjtjgP
         q6ZA==
MIME-Version: 1.0
X-Received: by 10.52.173.165 with SMTP id bl5mr14374335vdc.13.1397868573397;
 Fri, 18 Apr 2014 17:49:33 -0700 (PDT)
Received: by 10.58.23.234 with HTTP; Fri, 18 Apr 2014 17:49:33 -0700 (PDT)
In-Reply-To: <CAGVrzcZLUgpZZKAHjPSWaBs6w1XoegLaoWUAaMYUD9zW9yzq0w@mail.gmail.com>
References: <1397719309-2022-1-git-send-email-computersforpeace@gmail.com>
        <1397719309-2022-4-git-send-email-computersforpeace@gmail.com>
        <CAGVrzcZLUgpZZKAHjPSWaBs6w1XoegLaoWUAaMYUD9zW9yzq0w@mail.gmail.com>
Date:   Fri, 18 Apr 2014 17:49:33 -0700
Message-ID: <CAN8TOE90nh1v_84FSvF8MrN=eR-dOcXAYiOLeqRqXd3JCjfAzw@mail.gmail.com>
Subject: Re: [PATCH 3/5] mips: defconfigs: add MTD_SPI_NOR (new dependency for M25P80)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Linux Kernel <linux-kernel@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

On Fri, Apr 18, 2014 at 5:24 PM, Florian Fainelli <f.fainelli@gmail.com> wrote:
> 2014-04-17 0:21 GMT-07:00 Brian Norris <computersforpeace@gmail.com>:
>> These defconfigs contain the CONFIG_M25P80 symbol, which is now
>> dependent on the MTD_SPI_NOR symbol. Add CONFIG_MTD_SPI_NOR to the
>> relevant defconfigs.
>
> so CONFIG_M25P80 should select CONFIG_MTD_SPI_NOR, right? in that
> case, I do not think this is needed at all, as it would be
> automatically picked up during the build and if someone refreshes the
> defconfigs, although it cannot hurt.

Can you reply to the cover letter? 3 people have made the same
comment, and I had a rebuttal that I'm not sure if anyone considered
yet.

(And it wouldn't be picked up by 'savedefconfig', since it saves a
minimal .config; when one symbol 'select's another, the latter is not
needed in the defconfig)

Brian
