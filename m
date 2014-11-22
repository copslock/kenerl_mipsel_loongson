Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 22 Nov 2014 12:57:10 +0100 (CET)
Received: from arrakis.dune.hu ([78.24.191.176]:51401 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006520AbaKVL5HM2kB8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 22 Nov 2014 12:57:07 +0100
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id E62FD28BD4C;
        Sat, 22 Nov 2014 12:55:35 +0100 (CET)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qc0-f178.google.com (mail-qc0-f178.google.com [209.85.216.178])
        by arrakis.dune.hu (Postfix) with ESMTPSA id AC39028BD24;
        Sat, 22 Nov 2014 12:55:24 +0100 (CET)
Received: by mail-qc0-f178.google.com with SMTP id b13so5618688qcw.9
        for <multiple recipients>; Sat, 22 Nov 2014 03:56:51 -0800 (PST)
X-Received: by 10.224.129.9 with SMTP id m9mr13979915qas.50.1416657411721;
 Sat, 22 Nov 2014 03:56:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.95.79 with HTTP; Sat, 22 Nov 2014 03:56:31 -0800 (PST)
In-Reply-To: <20141121161055.GA5153@linux-mips.org>
References: <CAOiHx=nG0Td=9_A521NVjoixitTFxVnkvTCatubuFMKuHR+PEQ@mail.gmail.com>
 <20141121134141.GF30205@linux-mips.org> <CAOiHx=nJbFvUR4mBCTGdjDFkEX1onRK8P8_c3dwGwDxoox5mow@mail.gmail.com>
 <20141121161055.GA5153@linux-mips.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Sat, 22 Nov 2014 12:56:31 +0100
Message-ID: <CAOiHx=n4q3nj6Up8D7bEw3aNpz7+tV0LZw8bvwAC929WErP+Kw@mail.gmail.com>
Subject: Re: git caching(?) issues with http(s)
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44347
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Fri, Nov 21, 2014 at 5:10 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Fri, Nov 21, 2014 at 03:03:08PM +0100, Jonas Gorski wrote:
>
>> >> I noticed that git over http(s) seems to get stale data (just done a
>> >> few minutes ago):
>> >>
>> >> ~$ git clone http://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
>> >> Cloning into 'upstream-sfr'...
>> >> ~$ cd upstream-sfr/
>> >> ~/upstream-sfr$ git log -1
>> >> commit 475d5928b79bb78326a645863d46ff95c5e25e5a
>> >> Merge: c6b7b9f 1062080
>> >> Author: Ralf Baechle <ralf@linux-mips.org>
>> >> Date:   Sat Aug 2 00:07:03 2014 +0200
>> >>
>> >>     Merge branch '3.16-fixes' into mips-for-linux-next
>> >
>> > Odd - but I have an idea what might be wrong.
>> >
>> > Are you seeing this only with the upstream-sfr tree?
>>
>> Hadn't checked anything else, but looks like it also affects other trees:
>>
>> ~# git clone http://git.linux-mips.org/pub/scm/ralf/upstream-linus.git
>> Cloning into 'upstream-linus'...
>> ~$ cd upstream-linus/
>> ~/upstream-linus$ git log -1
>> commit 475d5928b79bb78326a645863d46ff95c5e25e5a
>> Merge: c6b7b9f 1062080
>> Author: Ralf Baechle <ralf@linux-mips.org>
>> Date:   Sat Aug 2 00:07:03 2014 +0200
>>
>>     Merge branch '3.16-fixes' into mips-for-linux-next
>>
>>
>> (strangely the same commit)
>
> The issue is a stale info/refs on the server.  This file normally gets
> updated when the hook hooks/post-update is ran which in turn calls
> git-update-server-info but that just didn't happen.
>
> Can you retry?

I am now able to clone a new, current tree, but updating my older
tree is broken:

# git pull --rebase
error: Unable to find e213b27f3921a88768201638d6d358f0f0c80419 under
https://git.linux-mips.org/pub/scm/ralf/upstream-sfr.git
Cannot obtain needed blob e213b27f3921a88768201638d6d358f0f0c80419
while processing commit fd37780aa0ee04f74e4323f45492947fcef62c35.
error: Fetch failed.

But I can live with that.

> Btw, why are you using http transport anyway?  The git protocol should
> be more efficient.

General paranoia (https) as well as occasional stupid corporate
firewalls that won't allow anything except 80 or 443.


Jonas
